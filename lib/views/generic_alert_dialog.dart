import 'package:flutter/material.dart';

abstract class GenericAlertDialog extends StatelessWidget {
  GenericAlertDialog({super.key, required this.title, required this.onPreBuild});
  
  final String title;
  final MainAxisAlignment actionsAlignment = MainAxisAlignment.spaceBetween;

  final void Function(TextEditingController) onPreBuild;

  @protected
  final TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    onPreBuild(textFieldController);

    return AlertDialog(
      title: Text(title),
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