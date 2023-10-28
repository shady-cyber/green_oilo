import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../textstyle/customTextFormStyle.dart';

class OutLineButtonWidget extends StatelessWidget {
  OutLineButtonWidget(
      {super.key,
      required this.onPressFunc,
      this.btnIcon,
      this.btnIconColor,
      this.btnText,
      this.btnTextColor});

  String? btnText;
  Color? btnTextColor;
  IconData? btnIcon;
  Color? btnIconColor;
  final Function onPressFunc;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      width: 100.w,
      child: OutlinedButton(
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              btnIcon,
              color: btnIconColor,
              size: 25.sp,
            ),
            SizedBox(
              width: 15.w,
            ),
            Text(
              btnText!,
              style: btnTextStyle.copyWith(
                  color: btnTextColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        onPressed: () => onPressFunc(),
      ),
    );
  }
}
