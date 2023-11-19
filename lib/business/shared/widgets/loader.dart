import 'package:flutter/material.dart';
import '../../../config/routes/app_routes_logic.dart';
import 'custom_loading_indicator.dart';

class Loader {
  static start() {
    showDialog(
      context: AppRoutes.navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CustomLoadingIndicator(),
      ),
    );
  }

  static stop(BuildContext context) {
    Navigator.pop(context);
  }

  static Widget loadingWidget() {
    return const Center(
      child: CustomLoadingIndicator(),
    );
  }
}
