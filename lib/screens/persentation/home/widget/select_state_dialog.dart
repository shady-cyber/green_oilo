import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sample_template/screens/data/generalCubit/general_cubit.dart';
import '../../../../../../../business/shared/textstyle/customTextFormStyle.dart';
import '../../../../../../../business/shared/widgets/shared_button.dart';
import '../../../../../../../config/styles/colors/app_colors.dart';
import '../../../../../../../config/styles/strings/app/app_strings.dart';
import '../../../data/generalCubit/general_state.dart';

class SelectOrderStateDialog extends StatelessWidget {
  GeneralCubit homeOrderCubit;
  GeneralOrderData states;
  int index;
  SelectOrderStateDialog({super.key, required this.homeOrderCubit, required this.states, required this.index});

  TextEditingController optinalText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: homeOrderCubit,
      child: BlocBuilder<GeneralCubit, GeneralState>(
          builder: (context, state) {
            return SizedBox(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      AppStrings.selectOrderState,
                      style: headingTextStyle.copyWith(fontSize: 17.sp),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 25.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.0.h),
                      child: Column(
                        children: [
                          Container(
                            child: SharedButton(
                              title: AppStrings.received,
                              textStyle: btnTextStyle,
                              backgroundColor: AppColors.primaryColor,
                              onPressed: () {
                                homeOrderCubit.sendOrderStatus(states.order[index].status, states.order[index].id, states.order[index].notes);
                                Navigator.pop(context);
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
                              title: AppStrings.NotReceived,
                              textStyle: btnTextStyle,
                              backgroundColor: AppColors.redTextColor,
                              onPressed: () {
                                homeOrderCubit.handelShowTextview();
                              },
                              textTitleSize: 15,
                              borderRaduis: 10,
                              width: 284.w,
                              height: 45.h,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        BlocBuilder<GeneralCubit, GeneralState>(
                        builder: (context, state) {
                        return Visibility(
                            visible: homeOrderCubit.showTextview ? true : false,
                              child: Column(
                                children: [
                                  SizedBox(height: 10.h),
                                  Container(
                                    width: 284.w,
                                    height: 45.h,
                                    child: TextField(
                                      controller: optinalText,
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
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Container(
                                    child: SharedButton(
                                      title: AppStrings.confirm,
                                      textStyle: btnTextStyle,
                                      backgroundColor: AppColors.validateTextColorRed,
                                      onPressed: () {
                                        homeOrderCubit.sendOrderStatus(states.order[index].status, states.order[index].id, states.order[index].notes);
                                        homeOrderCubit.showTextview = !homeOrderCubit.showTextview;
                                        Navigator.pop(context);
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
    }
    ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}