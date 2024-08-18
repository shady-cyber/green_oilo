import 'package:flutter/material.dart';
import 'package:sample_template/config/assets/assets_manager.dart';
import '../../../config/styles/colors/app_colors.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor, // Or any color you want for your splash screen
        body: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          // Your logo image goes here
          Image.asset(
          ImgAssets.splashImage,
          width: 200, // Adjust the width as needed
          height: 200, // Adjust the height as needed
            ),
             SizedBox(height: 16),
             CircularProgressIndicator(),
            ],// Replace with your app icon if desired
          ),
        ),
    );
  }
}
