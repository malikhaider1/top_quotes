import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class CustomScaffoldMessenger {
  static void showSnackBar({
    required String message,
    Duration duration = const Duration(seconds: 2),
    SnackBarAction? action,
    Color? backgroundColor,
  }) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        backgroundColor: backgroundColor,
        action: action,
      ),
    );
  }

  static void showError({required String error, Duration duration = const Duration(seconds: 3)}) {
    showSnackBar(message: error, duration: duration, backgroundColor: Colors.red);
  }

  static void showSuccess({required String message, Duration duration = const Duration(seconds: 2)}) {
    showSnackBar(message: message, duration: duration, backgroundColor: Colors.green);
  }
}