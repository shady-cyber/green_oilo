import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reni/business/shared/widgets/shared_button.dart';
import 'package:reni/config/styles/colors/app_colors.dart';
import 'package:reni/config/styles/strings/app/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../business/shared/widgets/loader.dart';
import '../../../config/assets/assets_manager.dart';
import '../../../config/routes/app_routes.dart';
import '../../../config/routes/navigation_arguments.dart';
import '../../data/generalCubit/general_cubit.dart';
import '../../data/generalCubit/general_state.dart';
import '../../data/model/order_main_model.dart';
import 'dart:html' as html;

class LoginScreen extends StatelessWidget {

  Future<void> _saveLoginState(String phoneNumber) async {
    if (kIsWeb) {
      html.window.localStorage['phoneNumber'] = phoneNumber;
      html.window.localStorage['isLoggedIn'] = 'true';
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("phoneNumber", phoneNumber);
      await prefs.setBool('isLoggedIn', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final generalCubit = GeneralCubit();
    TextEditingController phoneController = TextEditingController();

    return BlocProvider(
      create: (context) => generalCubit,
      child: BlocBuilder<GeneralCubit, GeneralState>(
        builder: (context, state) {
              return Scaffold(
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Your app logo or any other image can go here
                        Image.asset(
                          ImgAssets.LoginImage,
                          width: 250,
                          height: 250,
                        ),
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
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          maxLength: 11,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            labelText: 'رقم الهاتف',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue, width: 2.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 10.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        // Login button
                        SharedButton(
                          onPressed: () async {
                            if (!kIsWeb) {
                              Loader.start();
                            }
                            if (phoneController.text.isNotEmpty) {
                              try {
                                // Fetch the order data using the phone number
                                GeneralOrderData state = await generalCubit.fetchOrderData(context, phoneController.text);
                                List<OrdersMain> orders = state.order; // Extract the list of orders
                                // Perform your validation and navigation
                                if (orders.isNotEmpty) {
                                  if (!kIsWeb) {
                                    Loader.stop(context);
                                  }
                                  _saveLoginState(phoneController.text); // Save login state
                                  Navigator.pushNamed(
                                    context,
                                    Routes.home,
                                    arguments: NavigationArguments(cubit: generalCubit, data: state),
                                  );
                                } else {
                                  if (!kIsWeb) {
                                    Loader.stop(context);
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("No orders found."),
                                    ),
                                  );
                                }
                              } catch (e) {
                                // Handle errors
                                if (!kIsWeb) {
                                  Loader.stop(context);
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Server Error"),
                                  ),
                                );
                              }
                            } else {
                              if (!kIsWeb) {
                                Loader.stop(context);
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("من فضلك ادخل رقم الهاتف"),
                                ),
                              );
                            }
                          },
                          title: AppStrings.loginBtn,
                          textTitleSize: 20,
                          color: AppColors.primaryColor,
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
        ),
    );
  }
}