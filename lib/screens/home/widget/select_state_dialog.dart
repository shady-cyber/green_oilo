import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../business/shared/textstyle/customTextFormStyle.dart';
import '../../../../../../../business/shared/widgets/shared_button.dart';
import '../../../../../../../config/styles/colors/app_colors.dart';
import '../../../../../../../config/styles/strings/app/app_strings.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

class SelectOrderStateDialog extends StatefulWidget {
  HomeOrderCubit homeOrderCubit;
  String level;
  int index;
  SelectOrderStateDialog({super.key, required this.homeOrderCubit, required this.level, required this.index});

  @override
  State<SelectOrderStateDialog> createState() => _SelectOrderStateDialogState();
}

class _SelectOrderStateDialogState extends State<SelectOrderStateDialog> {
  @override
  void initState() {
    super.initState();
  //  widget.editTraineeSportCubit.initialChecker(widget.level);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.homeOrderCubit,
      child: BlocBuilder<HomeOrderCubit, HomeOrderState>(
          builder: (context, state) {
            return SizedBox(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 13.h,
                    ),
                    Text(
                      AppStrings.selectOrderState,
                      style: headingTextStyle.copyWith(fontSize: 17.sp),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 5.h),
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