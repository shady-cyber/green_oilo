import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reni/config/assets/assets_manager.dart';
import 'package:reni/screens/data/generalCubit/general_cubit.dart';
import '../../../../../../../business/shared/textstyle/customTextFormStyle.dart';
import '../../../../../../../business/shared/widgets/shared_button.dart';
import '../../../../../../../config/styles/colors/app_colors.dart';
import '../../../../../../../config/styles/strings/app/app_strings.dart';
import '../../../data/generalCubit/general_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart'; // Import Lottie package

class SelectOrderStateDialog extends StatefulWidget {
  final GeneralCubit homeOrderCubit;
  final GeneralOrderData states;
  final int index;
  final VoidCallback onClose;

  SelectOrderStateDialog({
    Key? key,
    required this.homeOrderCubit,
    required this.states,
    required this.index,
    required this.onClose,
  }) : super(key: key);

  @override
  State<SelectOrderStateDialog> createState() => _SelectOrderStateDialogState();
}

class _SelectOrderStateDialogState extends State<SelectOrderStateDialog> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.homeOrderCubit,
      child: BlocBuilder<GeneralCubit, GeneralState>(builder: (context, state) {
        return SizedBox(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Visibility(
                        visible: widget.homeOrderCubit.showTextviewReceived || widget.homeOrderCubit.showTextview,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            widget.homeOrderCubit.handelTextViewOnBack();
                            widget.homeOrderCubit.changeHeaderText(AppStrings.selectOrderState);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: widget.homeOrderCubit.showTextviewReceived || widget.homeOrderCubit.showTextview
                              ? Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: Text(
                              widget.homeOrderCubit.headerText,
                              style: headingTextStyle.copyWith(fontSize: 17.sp),
                              textAlign: TextAlign.left,
                            ),
                          )
                              : Text(
                            widget.homeOrderCubit.headerText,
                            style: headingTextStyle.copyWith(fontSize: 17.sp),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.0.h),
                    child: Column(
                      children: [
                        Visibility(
                          visible: !(widget.homeOrderCubit.showTextview || widget.homeOrderCubit.showTextviewReceived),
                          child: Container(
                            child: SharedButton(
                              title: AppStrings.received,
                              textStyle: btnTextStyle,
                              backgroundColor: AppColors.primaryColor,
                              onPressed: () {
                                widget.homeOrderCubit.handelShowTextviewReceived();
                                widget.homeOrderCubit.changeHeaderText(AppStrings.receivedHEADER);
                              },
                              textTitleSize: 15,
                              borderRaduis: 10,
                              width: 284.w,
                              height: 45.h,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                        BlocBuilder<GeneralCubit, GeneralState>(
                          builder: (context, state) {
                            return Visibility(
                              visible: widget.homeOrderCubit.showTextviewReceived,
                              child: Column(
                                children: [
                                  SizedBox(height: 10.h),
                                  Container(
                                    child: SharedButton(
                                      title: AppStrings.ImageUpload,
                                      textStyle: btnTextStyle,
                                      backgroundColor: AppColors.validateTextColorGrey,
                                      onPressed: () async {
                                        widget.homeOrderCubit.checkPermissionCamera("completed", widget.homeOrderCubit.OrderData[widget.index].id, "");
                                        widget.homeOrderCubit.showTextviewReceived = !widget.homeOrderCubit.showTextviewReceived;
                                      },
                                      textTitleSize: 15,
                                      borderRaduis: 10,
                                      width: 284.w,
                                      height: 45.h,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Container(
                                    child: SharedButton(
                                      title: AppStrings.confirm,
                                      textStyle: btnTextStyle,
                                      backgroundColor: AppColors.primaryColor,
                                      onPressed: () {
                                        widget.homeOrderCubit.sendOrderStatus(
                                          "completed",
                                          widget.homeOrderCubit.OrderData[widget.index].id,
                                          widget.homeOrderCubit.optinalText.text,
                                        ).then((value) {
                                          if (value == true) {
                                            // Remove the item from the list
                                            widget.homeOrderCubit.OrderData.removeAt(widget.index);
                                            widget.homeOrderCubit.showAnimation = true;
                                            widget.homeOrderCubit.changeHeaderText(AppStrings.SuccessAdded);
                                             widget.homeOrderCubit.handelTextViewOnBack();
                                            // Optionally hide the animation after a delay
                                            Future.delayed(Duration(seconds: 2), () {
                                              widget.homeOrderCubit.showAnimation = false;
                                              Navigator.pop(context);
                                            });
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('حدث خطأ ما'),
                                                duration: Duration(seconds: 2),
                                              ),
                                            );
                                          }
                                         // Navigator.pop(context);
                                        });
                                        widget.homeOrderCubit.showTextviewReceived = !widget.homeOrderCubit.showTextviewReceived;
                                      },
                                      textTitleSize: 15,
                                      borderRaduis: 10,
                                      width: 284.w,
                                      height: 45.h,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 10.h),
                        Visibility(
                          visible: !(widget.homeOrderCubit.showTextview || widget.homeOrderCubit.showTextviewReceived),
                          child: Container(
                            child: SharedButton(
                              title: AppStrings.NotReceived,
                              textStyle: btnTextStyle,
                              backgroundColor: AppColors.redTextColor,
                              onPressed: () {
                                widget.homeOrderCubit.handelShowTextview();
                                widget.homeOrderCubit.changeHeaderText(AppStrings.NotReceivedHEADER);
                              },
                              textTitleSize: 15,
                              borderRaduis: 10,
                              width: 284.w,
                              height: 45.h,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                        BlocBuilder<GeneralCubit, GeneralState>(
                          builder: (context, state) {
                            return Visibility(
                              visible: widget.homeOrderCubit.showTextview,
                              child: Column(
                                children: [
                                  Container(
                                    width: 284.w,
                                    height: 45.h,
                                    child: TextField(
                                      controller: widget.homeOrderCubit.optinalText,
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.right,
                                      decoration: InputDecoration(
                                        hintText: AppStrings.enterReason,
                                        hintStyle: TextStyle(
                                          fontSize: 15.sp,
                                          color: AppColors.primaryColor,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Container(
                                    child: SharedButton(
                                      title: AppStrings.ImageUpload,
                                      textStyle: btnTextStyle,
                                      backgroundColor: AppColors.validateTextColorGrey,
                                      onPressed: () async {
                                        widget.homeOrderCubit.checkPermissionCamera("declined", widget.homeOrderCubit.OrderData[widget.index].id, "");
                                      },
                                      textTitleSize: 15,
                                      borderRaduis: 10,
                                      width: 284.w,
                                      height: 45.h,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Container(
                                    child: SharedButton(
                                      title: AppStrings.confirm,
                                      textStyle: btnTextStyle,
                                      backgroundColor: AppColors.primaryColor,
                                      onPressed: () {
                                        widget.homeOrderCubit.sendOrderStatus(
                                          "declined",
                                          widget.homeOrderCubit.OrderData[widget.index].id,
                                          widget.homeOrderCubit.optinalText.text,
                                        ).then((value) {
                                          if (value == true) {
                                            widget.homeOrderCubit.OrderData.removeAt(widget.index);
                                              widget.homeOrderCubit.showAnimation = true;
                                              widget.homeOrderCubit.changeHeaderText(AppStrings.SuccessAdded);
                                              widget.homeOrderCubit.handelTextViewOnBack();

                                            Future.delayed(Duration(seconds: 2), () {
                                                widget.homeOrderCubit.showAnimation = false;
                                                Navigator.pop(context);
                                            });
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('حدث خطأ ما'),
                                                duration: Duration(seconds: 2),
                                              ),
                                            );
                                          }
                                        //  Navigator.pop(context);
                                        });
                                        widget.homeOrderCubit.showTextview = !widget.homeOrderCubit.showTextview;
                                      },
                                      textTitleSize: 15,
                                      borderRaduis: 10,
                                      width: 284.w,
                                      height: 45.h,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  // Display Lottie animation here
                  if (widget.homeOrderCubit.showAnimation)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: Lottie.asset(ImgAssets.success), // Path to your Lottie animation file
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
