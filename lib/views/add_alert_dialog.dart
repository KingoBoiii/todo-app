import 'package:flutter/material.dart';
import 'package:todo_app/views/generic_alert_dialog.dart';

class AddAlertDialog extends GenericAlertDialog {
  AddAlertDialog({super.key, required this.onAddClicked, required this.onCancelClicked});
  
  final void Function(TextEditingController) onAddClicked;
  final void Function() onCancelClicked;
  
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      TextButton.icon(
        style: const ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(Colors.redAccent)
        ),
        icon: const Icon(Icons.close),
        label: const Text("Cancel"), 
        onPressed: () => onCancelClicked.call()
      ),
      TextButton.icon(
        icon: const Icon(Icons.add),
        label: const Text("Add"), 
        onPressed: () => onAddClicked.call(super.textFieldController)
      )
    ];
  }
}
