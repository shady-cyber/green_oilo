import 'package:flutter/material.dart';
import '../../../config/styles/colors/app_colors.dart';

class NoInternetConeection extends StatelessWidget {
  const NoInternetConeection({super.key});

  @override
  Widget build(BuildContext context) {
  //  SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0, bottom: 30, left: 30),
                child: GestureDetector(
                  onTap: () {
                    //  Navigator.pushNamed(context, Routes.initialRoute);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      border: Border.all(
                        color: AppColors.grayColor,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 16,
                        weight: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: getProportionateScreenHeight(20),
            // ),
            // Expanded(child: ConnectionError()),
          ],
        ),
      ),
    );
  }
}
