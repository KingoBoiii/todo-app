import 'package:flutter/material.dart';
import 'package:todo_app/views/generic_alert_dialog.dart';

class UpdateAlertDialog extends GenericAlertDialog {
  UpdateAlertDialog({super.key, super.title = 'Update', required super.onPreBuild, required this.onUpdateClicked, required this.onCancelClicked});
  
  final void Function(TextEditingController) onUpdateClicked;
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
        label: const Text("Update"), 
        onPressed: () => onUpdateClicked.call(super.textFieldController)
      )
    ];
  }
}

/*
class UpdateAlertDialog extends GenericAlertDialog {
  UpdateAlertDialog({super.key, required this.onUpdateClicked, required this.onCancelClicked});
  
  final void Function(TextEditingController) onUpdateClicked;
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
        label: const Text("Update"), 
        onPressed: () => onUpdateClicked.call(super.textFieldController)
      )
    ];
  }
}
*/