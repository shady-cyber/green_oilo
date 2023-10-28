import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/assets/assets_manager.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key, this.height, this.width});

  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width:width ??  100.w,
      height: height ?? 100.w,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
        child: Image.asset(ImgAssets.loadingSpinnerGIF), //loadingSpinnerGIF
      ),
    );
  }
}
