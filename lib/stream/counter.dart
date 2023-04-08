import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  final int price = 2000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Builder'),
      ),
      body: StreamBuilder<int>(
        initialData: price,
        stream: addStreamValue(),
        // snapshot이란, stream의 결과물이다.
        // 그러므로 streamBuilder가 사용하게 하기 위하여
        // snapshot을 설정해준다. 이름은 바뀌어도 된다.
        builder: (context, snapshot) {
          // snapshot.data 사용해야 값 (int)을 얻어올 수 있음.
          final priceNumber = snapshot.data.toString();
          return Center(
            child: Text(
              priceNumber,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
          );
        },
      ),
    );
  }

  // 1초마다 값을 더해주는 Stream<T>.periodic
  Stream<int> addStreamValue() {
    return Stream<int>.periodic(
      const Duration(seconds: 1),
      (count) => price + count,
    );
  }
}
