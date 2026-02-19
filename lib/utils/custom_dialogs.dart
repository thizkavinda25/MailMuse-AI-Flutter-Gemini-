import 'package:flutter/material.dart';

class CustomDialogs {
  static void showEmptyFieldDialog(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('Please enter a topic'),
      ),
    );
  }
}
