import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/app_provider.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key, required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
        actions: [
          IconButton(
            onPressed: () {
              final state = Provider.of<AppProvider>(context, listen: false);
              state.signOff();
            }, 
            icon: const Icon(Icons.videogame_asset_off)
          )
        ],
      ),
      body: body
    );
  }
}