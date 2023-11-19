import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../config/styles/colors/app_colors.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitWaveSpinner(
      size: 50,
      color: AppColors.primaryColor,
      // itemBuilder: (BuildContext context, int index) {
      //   return DecoratedBox(
      //     decoration: BoxDecoration(
      //       color: AppColors.primaryColor,
      //     ),
      //   );
      // },
    );
  }
}
