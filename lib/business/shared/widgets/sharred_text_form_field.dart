import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/styles/colors/app_colors.dart';

class TextFormFieldSharred extends StatelessWidget {
  TextFormFieldSharred(
      {Key? key,
      this.controller,
      this.keyboardType,
      this.style,
      this.obscuringCharacter = '*',
      this.autocorrect = true,
      this.height,
      this.width,
      this.maxLines,
      this.onChanged,
      this.textInputAction,
      this.focusNode,
      this.onTap,
      this.onFieldSubmitted,
      this.validator,
      required this.hintText,
      this.hintColor,
      this.obscureText,
      this.prfixIcon,
      this.suffixIcon,
      this.withError,
      this.onEditingComplete,
      this.fillColor,
      this.hintStyle,
      required this.textAlign})
      : super(key: key);
  bool? withError;
  Color? fillColor;
  FocusNode? focusNode;
  Function? onEditingComplete;
  String? hintText;
  Color? hintColor;
  Widget? prfixIcon;
  TextInputAction? textInputAction;
  Widget? suffixIcon;
  TextEditingController? controller;
  TextInputType? keyboardType;
  TextStyle? style;
  TextStyle? hintStyle;
  String? obscuringCharacter = '*';
  bool? obscureText;
  bool? autocorrect;
  int? maxLines;
  double? width;
  double? height;
  TextAlign textAlign;

  void Function(String)? onChanged;
  void Function()? onTap;
  void Function(String)? onFieldSubmitted;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 60.0,
      width: width ?? 170.0,
      color: AppColors.grayColor.withOpacity(0.1),
      child: TextFormField(
        focusNode: focusNode,
        textInputAction: textInputAction,
        cursorColor: AppColors.primaryColor,
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.text,
        style: style ?? TextStyle(color: Colors.grey, fontSize: 14.0.sp),
        obscureText: obscureText ?? false,
        autocorrect: autocorrect ?? true,
        maxLines: 1,
        textAlign: textAlign,
        decoration: InputDecoration(
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: 1.w,
              ),
              borderRadius: BorderRadius.circular(5.r),
            ),
            border: withError == true
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )
                : InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.calendarColor, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            errorStyle: TextStyle(color: Colors.red),
            prefixIcon: prfixIcon,
            suffixIcon: suffixIcon,

            contentPadding: EdgeInsets.only(top: 20.0, left: 18.0, right: 20.0),
            hintStyle: TextStyle(
                color: hintColor ?? AppColors.grayColor, fontSize: 14.sp),
            hintText: hintText ?? "Type hint  text",
            fillColor: fillColor),
        onChanged: (s) {
          if (onChanged != null) {
            onChanged!(s);
          }
        },
        onTap: () {
          if (onTap != null) {
            onTap!();
          }
        },
        validator: (String? s) {
          if (validator != null) {
            return validator!(s);
          }
        },
        onEditingComplete: onEditingComplete?.call(),
        onFieldSubmitted: (s) {
          if (onFieldSubmitted != null) {
            onFieldSubmitted!(s);
          }
        },
      ),
    );
  }
}
