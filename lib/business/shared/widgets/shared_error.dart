import 'package:flutter/material.dart';
import '../../../config/routes/app_routes_logic.dart';
import 'error_dialog.dart';

showErrorDialog(String error, {showCloseButton = false}) {
  if (error.isNotEmpty) {
    showDialog(
        context: AppRoutes.navigatorKey.currentContext!,
        builder: (context) {
          return ErrorDialog(
            text: error,
            showCloseButton: showCloseButton,
            isError: true,
          );
        });
    }
}
