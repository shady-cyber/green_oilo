import '../../../config/styles/colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomRadioBtn extends StatefulWidget {
  final Function(bool) onNewState;
  final bool value;
  final bool isDisabled;
  const CustomRadioBtn(
      {Key? key,
      required this.onNewState,
      required this.value,
      this.isDisabled = false})
      : super(key: key);
  @override
  _CustomRadioBtnState createState() => _CustomRadioBtnState();
}

class _CustomRadioBtnState extends State<CustomRadioBtn> {
  late bool isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.isDisabled) {
          setState(() {
            isSelected = !isSelected;
          });
          widget.onNewState(isSelected);
        }
      },
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
            // border: Border.all(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(4)),
        child: isSelected
            ? Center(
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(4)),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                    color: AppColors.checkBoxBackgroundColor,
                    borderRadius: BorderRadius.circular(4)),
              ),
      ),
    );
  }
}
