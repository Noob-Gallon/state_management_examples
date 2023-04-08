import 'package:english_words/english_words.dart';
import 'package:flutter/foundation.dart';

// change notifier는 saved 데이터를 이 안에 저장하는데,
// 이 데이터가 변경이 되면 이 데이터를 사용하는 위젯들에게
// 디자인, layout을 조정하라고 알려주는 역할을 한다.
class SavedNotifier extends ChangeNotifier {
  final Set<WordPair> _saved = <WordPair>{};

  void toggleSaved(WordPair newSaved) {
    final alreadySaved = _saved.contains(newSaved);
    if (alreadySaved) {
      _saved.remove(newSaved);
    } else {
      _saved.add(newSaved);
    }

    // 이 notifier를 사용하고 있는 Widget들에게
    // 데이터가 변경되었으니 Layout을 새롭게 구성하라고 알려줌.
    // 어떻게 보면 Getx랑 거의 유사한 것 같음. 큰 차이는 없는듯함.
    // Provider는 여러 종류가 있고, 여기서는 가장 기본이 되는
    // notifyListeners만 알아본 것이다.
    notifyListeners();
  }

  // getter
  Set<WordPair> get saved => _saved;

  // 같은 기능
  // Set<WordPair> getSaved() {
  //   return _saved;
  // }

  bool checkAlreadyContained(WordPair wordPair) {
    return _saved.contains(wordPair);
  }
}
