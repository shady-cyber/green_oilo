import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_template/config/styles/colors/app_colors.dart';
import 'package:sample_template/screens/data/generalCubit/general_cubit.dart';
import 'package:sample_template/screens/persentation/home/widget/select_state_dialog.dart';
import '../../data/generalCubit/general_state.dart';
import '../../data/model/order_model.dart';

class HomeScreen extends StatefulWidget {
  GeneralCubit homeCubit;
  GeneralOrderData state;
  HomeScreen({super.key, required this.homeCubit, required this.state});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Sample list of items
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return
      BlocProvider.value(
          value: widget.homeCubit,
          child: BlocBuilder<GeneralCubit, GeneralState>(
          builder: (context, states) {
          return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Row(
            children: [
              Icon(Icons.monetization_on, color: AppColors.goldColor),
              SizedBox(width: 5), // Add spacing between icon and number
              Text(
                '200',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  color: AppColors.primaryColor,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          title: Flexible(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'حسن محمد علي',
                style: TextStyle(color: AppColors.primaryColor ,fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          centerTitle: false,
        ),

        body: PageView(
          controller: _pageController,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'تم التسليم',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.red),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: Divider(
                    color: AppColors.primaryColor,
                    thickness: 0.5,
                  ),
                ),
                SizedBox(height: 5),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListView.builder(
                        itemCount:  widget.state.order.length,
                        itemBuilder: (context, index) {
                          Order order = widget.state.order[index];
                          widget.state.order[index].fetchOrderData();
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0), // Set the border radius here
                              side: BorderSide(color: AppColors.primaryColor, width: 1.0), // Set the border color and width
                            ),
                            elevation: 0,
                            child: ListTile(
                              title: Text(order.CustomerName),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('العنوان: ${order.OrderAddress}'),
                                  Text('الكمية: ${order.Quantity} لتر'),
                                ],
                              ),
                              trailing: Directionality(
                                textDirection: TextDirection.rtl,
                                child: IconButton(
                                  icon: Icon(Icons.arrow_forward_ios, color: AppColors.primaryColor,size: 20,),
                                  onPressed: () {
                                    showModalBottomSheet(
                                        backgroundColor: Colors.white,
                                        context: context,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.vertical(top: Radius.circular(20))),
                                        builder: (context) => Container(
                                          height: 250,
                                          child: SelectOrderStateDialog(
                                            homeOrderCubit: widget.homeCubit, level: '', index: 0,

                                          ),
                                        ));
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'الطلبات',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.red),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: Divider(
                    color: AppColors.primaryColor,
                    thickness: 0.5,
                  ),
                ),
                SizedBox(height: 5),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListView.builder(
                        itemCount:  widget.state.order.length,
                        itemBuilder: (context, index) {
                          Order order = widget.state.order[index];
                          widget.state.order[index].fetchOrderData();
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0), // Set the border radius here
                              side: BorderSide(color: AppColors.primaryColor, width: 1.0), // Set the border color and width
                            ),
                            elevation: 0,
                            child: ListTile(
                              title: Text(order.CustomerName),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('العنوان: ${order.OrderAddress}'),
                                  Text('الكمية: ${order.Quantity} لتر'),
                                  Text('الهدية: ${order.CustomerGift}'),
                                ],
                              ),
                              trailing: Directionality(
                                textDirection: TextDirection.rtl,
                                child: IconButton(
                                  icon: Icon(Icons.arrow_forward_ios, color: AppColors.primaryColor,size: 20,),
                                  onPressed: () {
                                    showModalBottomSheet(
                                        backgroundColor: Colors.white,
                                        context: context,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.vertical(top: Radius.circular(20))),
                                        builder: (context) => Container(
                                          height: 250,
                                          child: SelectOrderStateDialog(
                                            homeOrderCubit: widget.homeCubit, level: '', index: 0,

                                          ),
                                        ));
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      );
          }
        ),
      );
  }
}