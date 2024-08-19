import 'package:flutter/material.dart';

class Message {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> customMessage(
    BuildContext context, {
    double? screenWidth,
    required String message,
    Color? backgroundColor,
    Color? iconCloseColor,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        //width: screenWidth,
        showCloseIcon: true,
        closeIconColor: iconCloseColor ?? Colors.black,
        duration: const Duration(seconds: 5),
        content: Center(
          child: Text(
            message,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        backgroundColor: backgroundColor ?? Colors.green,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
