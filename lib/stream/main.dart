import 'package:flutter/material.dart';
import 'package:state_management_example/stream/counter.dart';

void mainStream() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream Builder',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: const Counter(),
    );
  }
}
