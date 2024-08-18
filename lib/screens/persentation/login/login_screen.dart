import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_template/business/shared/widgets/shared_button.dart';
import 'package:sample_template/config/styles/colors/app_colors.dart';
import 'package:sample_template/config/styles/strings/app/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../business/shared/widgets/loader.dart';
import '../../../config/assets/assets_manager.dart';
import '../../../config/routes/app_routes.dart';
import '../../../config/routes/navigation_arguments.dart';
import '../../data/generalCubit/general_cubit.dart';
import '../../data/generalCubit/general_state.dart';
import '../../data/model/order_main_model.dart';

class LoginScreen extends StatelessWidget {

  Future<void> _saveLoginState(String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("phoneNumber", phoneNumber);
    await prefs.setBool('isLoggedIn', true);
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
                          ImgAssets.splashImage,
                          width: 150,
                          height: 150,
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
                          controller: phoneController,
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
                          onPressed: () async {
                            Loader.start();
                            if (phoneController.text.isNotEmpty) {
                              try {
                                // Fetch the order data using the phone number
                                GeneralOrderData state = await generalCubit.fetchOrderData(context, phoneController.text);
                                List<OrdersMain> orders = state.order; // Extract the list of orders

                                // Perform your validation and navigation
                                if (orders.isNotEmpty) {
                                  Loader.stop(context);
                                  _saveLoginState(phoneController.text); // Save login state
                                  Navigator.pushNamed(
                                    context,
                                    Routes.home,
                                    arguments: NavigationArguments(cubit: generalCubit, data: state),
                                  );
                                } else {
                                  Loader.stop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("No orders found."),
                                    ),
                                  );
                                }
                              } catch (e) {
                                // Handle errors
                                Loader.stop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("An error occurred: ${e.toString()}"),
                                  ),
                                );
                              }
                            } else {
                              Loader.stop(context);
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