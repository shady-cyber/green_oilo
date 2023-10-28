import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/styles/colors/app_colors.dart';
import '../../../config/styles/strings/app/app_strings.dart';
import '../textstyle/customTextFormStyle.dart';
import 'shared_button.dart';
import '../../../config/assets/assets_manager.dart';

class NoInternetErrorPopUp extends StatelessWidget {
  const NoInternetErrorPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      alignment: Alignment.center,
      children: [
        Container(
          width: double.infinity,
          height: 250.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Image.asset(
                ImgAssets.internetErrorImage,
                width: 80.w,
                height: 50.h,
                fit: BoxFit.fill,
              ),
               SizedBox(height: 14.h),
              Text(
                'Ooops!',
                style: headingTextStyle.copyWith(fontSize: 17.sp),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 14.h),
              Text(
                'Slow or no internet connection.\nPlease check your internet connection.',
                textAlign: TextAlign.center,
                style: hintTextStyle.copyWith(fontSize: 14.sp),
              ),
              SizedBox(
                height: 35.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: SharedButton(
                  title: AppStrings.okayBtn,
                  textStyle: btnTextStyle,
                  backgroundColor: AppColors.primaryColor,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  textTitleSize: 15,
                  borderRaduis: 10,
                  width: 308.w,
                  height: 45.h,
                  color: AppColors.whiteColor,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
