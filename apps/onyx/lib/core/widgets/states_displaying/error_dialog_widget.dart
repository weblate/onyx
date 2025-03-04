import 'package:flutter/material.dart';

class ErrorDialogWidget extends StatelessWidget {
  const ErrorDialogWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Erreur"),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "OK",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        )
      ],
    );
  }
}
