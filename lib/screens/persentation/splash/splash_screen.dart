import 'package:flutter/material.dart';
import 'package:sample_template/config/assets/assets_manager.dart';
import '../../../config/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    // Wait for 5 seconds and then navigate to the login screen
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushNamed(context, Routes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [Colors.green, Colors.white],
        //   ),
        // ),
        child: Center(
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
              // Optional: Add a text below the logo
              // Text(
              //   'Delivery Boy',
              //   style: TextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.white,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}