import 'package:flutter/material.dart';
import '../../../../config/styles/colors/app_colors.dart';
import '../../../data/generalCubit/general_cubit.dart';
import '../../../data/generalCubit/general_state.dart';
import '../../../data/model/order_model.dart';

Widget DeliveredList(BuildContext context, GeneralOrderData state, GeneralCubit homeCubit) {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
  GlobalKey<RefreshIndicatorState>();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Divider(
        color: AppColors.primaryColor,
        thickness: 0.2,
      ),
      SizedBox(height: 10),
      Text(
        'تم التسليـم',
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
                // Implement refreshData method in your GeneralCubit
                await homeCubit.refreshData(context);
              },
              child: homeCubit.DeliveredData.isEmpty
                  ? Center(child: Text('لا يوجد طلبات'))
                  : ListView.builder(
                itemCount: homeCubit.DeliveredData.length,
                itemBuilder: (context, index) {
                  Order order = homeCubit.DeliveredData[index];
                  homeCubit.DeliveredData[index].fetchOrderData();
                  return Card(
                    color: homeCubit.DeliveredData[index].status == "processing"
                        ? Colors.yellow[50]
                        : homeCubit.DeliveredData[index].status == "completed"
                        ? Colors.green[50]
                        : homeCubit.DeliveredData[index].status == "declined"
                        ? Colors.red[50]
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(
                        color: AppColors.primaryColor,
                        width: 0.3,
                      ),
                    ),
                    elevation: 0,
                    child: ListTile(
                      title: Text(order.CustomerName),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('العنوان: ${order.OrderAddress}'),
                          Text('الهدية: ${order.CustomerGift}'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('الكمية: ${order.Quantity} لتر'),
                              Text(
                                homeCubit.DeliveredData[index].status == "processing"
                                    ? 'قيد التنفيذ'
                                    : homeCubit.DeliveredData[index].status == "completed"
                                    ? 'تم التنفيذ'
                                    : homeCubit.DeliveredData[index].status == "declined"
                                    ? 'تم الالغاء'
                                    : '',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
