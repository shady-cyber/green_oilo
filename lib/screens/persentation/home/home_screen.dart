import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_template/config/styles/colors/app_colors.dart';
import 'package:sample_template/screens/data/generalCubit/general_cubit.dart';
import 'package:sample_template/screens/data/repo/order_repo.dart';
import 'package:sample_template/screens/persentation/home/widget/select_state_dialog.dart';

import '../../data/generalCubit/general_state.dart';
import '../../data/model/order_model.dart';


class HomeScreen extends StatelessWidget {
  GeneralCubit homeCubit;
  GeneralOrderData state;
  HomeScreen({super.key, required this.homeCubit, required this.state});

  // Sample list of items
  // final List<Item> itemList = [
  // Item(name: 'حسن محمد عواد', address: 'الفالوجا العجوزه عماره 5 شقه 10', literNumber: 5),
  // Item(name: 'سيد رجب علي', address: 'شبرا  السنترال عماره 10 شقه 6', literNumber: 8),
  // Item(name: 'زينب السيد محمد', address: 'ميدان الجامع عماره 5 شقه 3', literNumber: 3),
  // ];

  @override
  Widget build(BuildContext context) {
    return
      BlocProvider.value(
          value: homeCubit,
          child: BlocBuilder<GeneralCubit, GeneralState>(
          builder: (context, states) {
          state.order.fetchOrderData();

          return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Icon(Icons.monetization_on, color: AppColors.goldColor),
          title: Text('حسن محمد', style: TextStyle(fontFamily: 'Cairo', color: AppColors.primaryColor, fontSize: 25),),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.person, color: AppColors.primaryColor),
              onPressed: () {
                // Handle notifications button press
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ListView.builder(
              itemCount:  state.order.orderData.length,
              itemBuilder: (context, index) {
                Order order = state.order.orderData[index];
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
                                    homeOrderCubit: homeCubit, level: '', index: 0,

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
    );
          }
        ),
      );
  }
}