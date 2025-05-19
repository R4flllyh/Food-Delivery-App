import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      // duration: const Duration(seconds: 2),
      // backgroundColor: Colors.red,
      // behavior: SnackBarBehavior.floating,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );
}
