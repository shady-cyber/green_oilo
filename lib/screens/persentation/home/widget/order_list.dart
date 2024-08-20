import 'package:flutter/material.dart';
import 'package:sample_template/screens/persentation/home/widget/select_state_dialog.dart';
import '../../../../config/styles/colors/app_colors.dart';
import '../../../data/generalCubit/general_cubit.dart';
import '../../../data/generalCubit/general_state.dart';
import '../../../data/model/order_model.dart';

Widget OrderedList(BuildContext context, GeneralOrderData state, GeneralCubit homeCubit) {
  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Divider(
        color: AppColors.primaryColor,
        thickness: 0.2,
      ),
      SizedBox(height: 10),
      Text(
        'الطـلبـات',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.red),
      ),
      SizedBox(height: 5),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: RefreshIndicator(
              key: _refreshKey,
              onRefresh: () async {
                // Call refreshData to update OrderData
                await homeCubit.refreshData(context);
              },
              child: Builder(
                builder: (BuildContext context) {
                  if (state is LoadingOrderState) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return homeCubit.OrderData.isEmpty
                        ? Center(child: Text('لا يوجد طلبات'))
                        : ListView.builder(
                      itemCount: homeCubit.OrderData.length,
                      itemBuilder: (context, index) {
                        Order order = homeCubit.OrderData[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(color: AppColors.primaryColor, width: 0.3),
                          ),
                          elevation: 0,
                          child: ListTile(
                            title: Text(order.CustomerName),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('العنوان: ${order.OrderAddress}'),
                                GestureDetector(
                                  onTap: () {
                                    homeCubit.makePhoneCall(order.CustomerNumber);
                                  },
                                  child: Text('رقم الهاتف: ${order.CustomerNumber}', style: TextStyle(color: Colors.red)),
                                ),
                                Text('الكمية: ${order.Quantity} لتر'),
                                Text('الهدية: ${order.CustomerGift}'),
                              ],
                            ),
                            trailing: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Transform.rotate(
                                angle: -90 * 3.1415926535897932 / 180,
                                child: IconButton(
                                  icon: Icon(Icons.arrow_forward_ios, color: AppColors.primaryColor, size: 20),
                                  onPressed: () {
                                    showModalBottomSheet(
                                      backgroundColor: Colors.white,
                                      context: context,
                                      isScrollControlled: true, // Allows the bottom sheet to be flexible in height
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                      ),
                                      builder: (context) => Padding(
                                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                        child: Container(
                                          height: 300,
                                          child: SelectOrderStateDialog(
                                            homeOrderCubit: homeCubit,
                                            states: state,
                                            index: 0,
                                            onClose: () {
                                              homeCubit.showTextview = false; // Set showTextview to false when modal closes
                                              homeCubit.showTextviewReceived = false; // Set showTextview to false when modal closes
                                            },
                                          ),
                                        ),
                                      ),
                                    ).whenComplete(() {
                                      // Ensure showTextview is set to false when modal is dismissed
                                      homeCubit.showTextview = false;
                                      homeCubit.showTextviewReceived = false;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

