import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: CupertinoButton(
            onPressed: null,
            child: Icon(CupertinoIcons.back)
          ),
          middle: Text("Navigation Bar"),
        ),
        child: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
