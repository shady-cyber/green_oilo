import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/styles/colors/app_colors.dart';

class SharedButton extends StatelessWidget {
  const SharedButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.textStyle,
    this.fixedSize,
    this.borderRaduis,
    this.backgroundColor,
    this.padding,
    this.borderSide,
    this.width,
    this.height,
    this.titleColor,
    this.icon,
    required this.textTitleSize,
    this.textTitleStyle,
    required Color color,
  });
  final String title;
  final Color? titleColor;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  final Size? fixedSize;
  final double? width;
  final double? height;
  final double? borderRaduis;

  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final BorderSide? borderSide;
  final double textTitleSize;
  final TextStyle? textTitleStyle;
  final Icon? icon;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(
          width ?? 350.w,
          height ?? 50.w,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRaduis ?? 11.r,
          ),
        ),
        backgroundColor: backgroundColor ?? AppColors.primaryColor,
        padding: padding ?? EdgeInsets.zero,
        side: borderSide,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon ?? Container(),
          Text(
            title,
            style: textTitleStyle ??
                TextStyle(
                    color: titleColor ?? Colors.white,
                    fontSize: textTitleSize.sp),
          ),
        ],
      ),
    );
  }
}
