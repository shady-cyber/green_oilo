import 'package:flutter/material.dart';
import 'package:sample_template/config/styles/colors/app_colors.dart';
import 'package:sample_template/screens/home/cubit/home_cubit.dart';
import 'package:sample_template/screens/home/widget/select_state_dialog.dart';

import 'model/item_model.dart';

class HomeScreen extends StatelessWidget {

  HomeOrderCubit homeOrderCubit = HomeOrderCubit();
  // Sample list of items
  final List<Item> itemList = [
  Item(name: 'حسن محمد عواد', address: 'الفالوجا العجوزه عماره 5 شقه 10', literNumber: 5),
  Item(name: 'سيد رجب علي', address: 'شبرا  السنترال عماره 10 شقه 6', literNumber: 8),
  Item(name: 'زينب السيد محمد', address: 'ميدان الجامع عماره 5 شقه 3', literNumber: 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.monetization_on, color: AppColors.goldColor),
            SizedBox(width: 5), // Add some spacing between icon and text
            Text(
              '200',
              style: TextStyle(fontFamily: 'Poppins', color: AppColors.primaryColor),
            ),
          ],
        ),
        // IconButton(
        //   icon: Icon(Icons.monetization_on, color: AppColors.goldColor),
        //   onPressed: () {
        //   },
        // ),
        title: Text('حسن محمد', style: TextStyle(fontFamily: 'Poppins', color: AppColors.primaryColor, fontSize: 25),),
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
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              Item item = itemList[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0), // Set the border radius here
                  side: BorderSide(color: AppColors.primaryColor, width: 1.0), // Set the border color and width
                ),
                elevation: 0,
                child: ListTile(
                  title: Text(item.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('العنوان: ${item.address}'),
                      Text('الكمية: ${item.literNumber} لتر'),
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
                              builder: (context) => SelectOrderStateDialog(
                                homeOrderCubit: homeOrderCubit, level: '', index: 0,

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
}