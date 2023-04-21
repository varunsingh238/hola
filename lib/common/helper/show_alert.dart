import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showAlertDialog({
  required BuildContext context,
  required String message,
  String? btnText,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
            message,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                btnText ?? "OK",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        );
      });
}
