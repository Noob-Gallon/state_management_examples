import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_example/provider/saved_notifier.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  // final Set<WordPair> saved;

  // Constructor를 통해 saved 데이터를 전달받게 되는데,
  // 이는 독립적인 복사본을 갖게되는 것이므로
  // 값이 변해도 main.dart에서 존재하는 상위 tree에
  // 이 변화를 전달할 수 없다.
  // const Cart({super.key, required this.saved});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  // SavedNotifier는 크게 세 개의 method가 있다.
  // read, watch, select
  // read는 change를 listen하지 않고, 단순히 값만 읽어오는 것이다.
  // => build 내에서 사용할 수 없다.
  // watch는 change를 listen하는 것이다.
  // select는 notifier 내에 여러 개의 변수가 존재할 때 사용된다.
  @override
  Widget build(BuildContext context) {
    final savedNotifier = context.watch<SavedNotifier>();
    final tiles = savedNotifier.saved.map(
      (WordPair pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
          ),
          onTap: () {
            savedNotifier.toggleSaved(pair);
          },
        );
      },
    );

    final divided = tiles.isNotEmpty
        ? ListTile.divideTiles(tiles: tiles, context: context).toList()
        : <Widget>[];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Suggestions'),
      ),
      body: ListView(children: divided),
    );
  }
}
