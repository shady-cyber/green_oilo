import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_template/config/styles/colors/app_colors.dart';
import 'package:sample_template/screens/data/generalCubit/general_cubit.dart';
import 'package:sample_template/screens/persentation/home/widget/delivered_list.dart';
import 'package:sample_template/screens/persentation/home/widget/order_list.dart';
import 'package:sample_template/screens/persentation/home/widget/select_state_dialog.dart';
import '../../data/generalCubit/general_state.dart';
import '../../data/model/order_model.dart';

class HomeScreen extends StatelessWidget {
  GeneralCubit homeCubit;
  GeneralOrderData state;
  HomeScreen({super.key, required this.homeCubit, required this.state});

  // list of items
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: homeCubit,
      child:
          BlocBuilder<GeneralCubit, GeneralState>(builder: (context, states) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Row(
            children: [
            Icon(Icons.monetization_on, color: AppColors.goldColor), // Your icon goes here
            SizedBox(width: 8.0),
            Text('200',
              style: TextStyle(
                fontFamily: 'Cairo',
                color: AppColors.primaryColor,
                fontSize: 15,
                    ),
                  ), // Your text goes here
                ],
              ),
            Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text('حسن محمد علي',
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
                  ), // Your title text goes here
                 ),
               ],
              ),
            ),
            //   leading: Row(
            //     children: [
            //       Icon(Icons.monetization_on, color: AppColors.goldColor),
            //       SizedBox(width: 5),
            //       // Add spacing between icon and number
            //       Text(
            //         '200',
            //         style: TextStyle(
            //           fontFamily: 'Cairo',
            //           color: AppColors.primaryColor,
            //           fontSize: 15,
            //         ),
            //       ),
            //     ],
            //   ),
            //   title: Align(
            //     alignment: Alignment.centerRight,
            //     child: Text(
            //       'حسن محمد علي',
            //       style: TextStyle(
            //           color: AppColors.primaryColor,
            //           fontWeight: FontWeight.bold,
            //           fontSize: 18),
            //     ),
            //   ),
            //   centerTitle: false,
            // ),
            body: PageView(
              reverse: true,
              controller: _pageController,
              children: [
                OrderedList(context, state, homeCubit),
                DeliveredList(context, state, homeCubit),
              ],
            ));
      }),
    );
  }
}
