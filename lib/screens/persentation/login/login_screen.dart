import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_template/business/shared/widgets/shared_button.dart';
import 'package:sample_template/config/styles/colors/app_colors.dart';
import 'package:sample_template/config/styles/strings/app/app_strings.dart';
import '../../../business/shared/widgets/loader.dart';
import '../../../config/assets/assets_manager.dart';
import '../../../config/routes/app_routes.dart';
import '../../data/generalCubit/general_cubit.dart';
import '../../data/generalCubit/general_state.dart';

class LoginScreen extends StatelessWidget {
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
                              await generalCubit.fetchPrivacyData(phoneController.text).then((value) {
                                    if(value == true){
                                       Loader.stop(context);
                                       Navigator.pushNamed(context, Routes.home, arguments: [generalCubit,state]);
                                    } else {
                                      Loader.stop(context);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text("من فضلك ادخل رقم الهاتف"),
                                          ));
                                    }
                                });

                            } else {
                              Loader.stop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("من فضلك ادخل رقم الهاتف"),
                                  ));
                            }
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
        ),
    );
  }
}