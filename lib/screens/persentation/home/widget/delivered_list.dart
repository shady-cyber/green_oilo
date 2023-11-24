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
              onRefresh: () => homeCubit.refreshData(context),
              child: ListView.builder(
                itemCount:  homeCubit.DeliveredData.length,
                itemBuilder: (context, index) {
                  Order order = homeCubit.DeliveredData[index];
                  state.order[index].fetchOrderData();

                  return
                    homeCubit.DeliveredData.length == 0
                        ? Center(child: Text('لا يوجد طلبات'))
                        : Card(
                      color: homeCubit.DeliveredData[index].status == "processing" ? Colors.yellow[50] :
                      homeCubit.DeliveredData[index].status == "delivered" ? Colors.green[50] :
                      homeCubit.DeliveredData[index].status == "canceled" ? Colors.red[50] : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0), // Set the border radius here
                      side: BorderSide(color: AppColors.primaryColor, width: 0.3), // Set the border color and width
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
                              homeCubit.DeliveredData[index].status == "processing" ? Text('قيد التنفيذ') :
                              homeCubit.DeliveredData[index].status == "delivered" ? Text('تم التنفيذ') :
                              homeCubit.DeliveredData[index].status == "canceled" ? Text('تم الالغاء') : Text(''),
                            ],
                          ),
                        ],
                      ),
                      // trailing: Directionality(
                      //   textDirection: TextDirection.rtl,
                      //   child: IconButton(
                      //     icon: Icon(Icons.arrow_forward_ios, color: AppColors.primaryColor,size: 20,),
                      //     onPressed: () {
                      //       showModalBottomSheet(
                      //           backgroundColor: Colors.white,
                      //           context: context,
                      //           shape: const RoundedRectangleBorder(
                      //               borderRadius:
                      //               BorderRadius.vertical(top: Radius.circular(20))),
                      //           builder: (context) => Container(
                      //             height: 250,
                      //             child: SelectOrderStateDialog(
                      //               homeOrderCubit: homeCubit, level: '', index: 0,
                      //             ),
                      //           ));
                      //     },
                      //   ),
                      // ),
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