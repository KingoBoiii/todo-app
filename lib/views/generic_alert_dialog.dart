import 'package:flutter/material.dart';

abstract class GenericAlertDialog extends StatelessWidget {
  GenericAlertDialog({super.key});
  
  final MainAxisAlignment actionsAlignment = MainAxisAlignment.spaceBetween;

  @protected
  final TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add todo collection'),
      content: TextField(
        controller: textFieldController,
        maxLength: 50,
        autofocus: true
      ),
      actionsAlignment: actionsAlignment,
      actions: buildActions(context)
    );
  }

  @protected
  List<Widget> buildActions(BuildContext context);
}