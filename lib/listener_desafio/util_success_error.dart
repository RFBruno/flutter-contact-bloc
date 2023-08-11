import 'package:flutter/material.dart';

void utilSuccess(BuildContext context) {
  Navigator.of(context).pop();
}

void utilError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.red.shade200,
    ),
  );
}
