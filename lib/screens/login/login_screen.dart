import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sample_template/business/shared/widgets/shared_button.dart';
import 'package:sample_template/config/styles/colors/app_colors.dart';
import 'package:sample_template/config/styles/strings/app/app_strings.dart';
import '../../config/assets/assets_manager.dart';
import '../../config/routes/app_routes.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Your app logo or any other image can go here
              Image.asset(
                ImgAssets.splashImage,
                width: 100,
                height: 100,
              ),
              SizedBox(height: 16),
              Text(
                'ادخل رقم هاتفك للتسجيل',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              // Phone number input field
              TextFormField(
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                maxLength: 11,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  labelText: 'رقم الهاتف',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              // Login button
              SharedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.home);
                },
                title: AppStrings.loginBtn,
                textTitleSize: 20,
                color: AppColors.primaryColor,
               ),
            ],
          ),
        ),
      ),
    );
  }
}