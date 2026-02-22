import 'package:flutter/material.dart';

class CustomDialogs {
  static void showEmptyFieldDialog(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text(message),
      ),
    );
  }

  static void showSucceededDialog(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        backgroundColor: Colors.green,
        content: Text(message),
      ),
    );
  }
}
