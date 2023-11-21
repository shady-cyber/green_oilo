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
  String level;
  int index;
  SelectOrderStateDialog({super.key, required this.homeOrderCubit, required this.level, required this.index});

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
                                // widget.editTraineeSportCubit.showList = widget.editTraineeSportCubit.selectTraineeSportsLevel(
                                //     widget.editTraineeSportCubit.selectIndexToDetectTraineeSportsLevel, widget.index);
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
                                // widget.editTraineeSportCubit.showList = widget.editTraineeSportCubit.selectTraineeSportsLevel(
                                //     widget.editTraineeSportCubit.selectIndexToDetectTraineeSportsLevel, widget.index);
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