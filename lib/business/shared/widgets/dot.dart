import 'package:flutter/material.dart';

import '../../../config/styles/colors/app_colors.dart';

class Dot extends StatelessWidget {
  final bool isSelected;

  const Dot({Key? key, required this.isSelected}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12.0,
      height: 4.0,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: isSelected ? AppColors.primaryColor : AppColors.culturedColor),
    );
  }
}
