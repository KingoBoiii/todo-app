import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/app_provider.dart';

class UnauthLayout extends StatelessWidget {
  const UnauthLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List')
      ),
      body: Center(
        child: IntrinsicWidth(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: ElevatedButton.icon(
              onPressed: () {
                final state = Provider.of<AppProvider>(context, listen: false);
                state.signInGoogle();
              },
              icon: const Icon(Icons.g_mobiledata),
              label: const Text("Sign in with Google"),
            ),
          ),
        ),
      )
    );
  }
}