import '../../../config/styles/colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSeparationWidget extends StatelessWidget {
  CustomSeparationWidget({Key? key, required this.size, this.w})
      : super(key: key);
  double size = 0;
  double? w;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.grayColor,
      height: size,
      width: w,
    );
  }
}
