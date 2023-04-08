import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';
import 'package:state_management_example/provider/cart.dart';
import 'package:state_management_example/provider/saved_notifier.dart';

void mainProvider() {
  runApp(const MainApp());
}

// saved를 private으로 만들면 다른 파일에서 접근이 불가능하므로
// 이름 앞에서 언더바를 떼준다.

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // ChangeNotiferProvider.value는 instance가 이미 생성되어 있는 것을 전달해주는 것이고,
  // CHangeNotiferProvider는 instance를 생성해주는 것이다.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SavedNotifier>(
      // 이 Widget의 아래로 SavedNotifier가 관리하는
      // Data의 전달이 가능하다.
      create: (_) => SavedNotifier(),
      child: const MaterialApp(
        home: RandomWords(),
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = generateWordPairs().take(30).toList();
  // final Set<WordPair> _saved = <WordPair>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
        actions: [
          IconButton(
            onPressed: _pushSaved,
            icon: const Icon(Icons.list),
          )
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    // wordPair를 넘겨서 buildRow를 실행,
    // buildRow는 좋아요가 눌렸는지 체크 가능.
    Iterable<Widget> tiles =
        _suggestions.map((wordPair) => _buildRow(wordPair));

    // 각각 아이템 가운데에 선을 긋는것.
    final divided = tiles.isNotEmpty
        ? ListTile.divideTiles(tiles: tiles, context: context).toList()
        : <Widget>[];

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: divided,
    );
  }

  // Provider의 사용법
  // Provider를 통해 데이터에 접근하는 방법은 여러가지가 있는데,
  // 내가 BuildContext에 접근할 수 있느냐 아니냐에 따라 방법이 달라진다.
  //
  Widget _buildRow(WordPair pair) {
    // BuildContext에 접근할 수 없다면 Consumer를 이용,
    // 어떤 데이터에 접근할 것인지 Generic을 통해 지정해준다.
    return Consumer<SavedNotifier>(
      // SavedNotifier의 builder를 통해서
      // 데이터를 받아올 수 있다.
      // BuildContext, SavedNotifier, Widget이 정해짐
      builder: (context, savedNotifier, child) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
          ),
          trailing: Icon(
            savedNotifier.checkAlreadyContained(pair)
                ? Icons.favorite
                : Icons.favorite_border,
            color:
                savedNotifier.checkAlreadyContained(pair) ? Colors.red : null,
          ),
          onTap: () {
            // if (alreadySaved) {
            // 이와 같이 remove나 add를 직접 사용하면 안된다.
            // 왜냐면, Notifier Class에서 notifyListeners()를 사용해야
            // 데이터의 변경을 알릴 수 있기 때문이다.
            // savedNotifier.saved.remove(pair);
            // } else {
            // savedNotifier.saved.add(pair);
            // }
            savedNotifier.toggleSaved(pair);
          },
        );
      },
    );
  }

  void _pushSaved() async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          return const Cart(/*saved: saved*/);
        },
      ),
    );

    setState(() {});
  }
}
