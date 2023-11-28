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
              onRefresh: () => homeCubit.refreshData(context),
              child: Builder(
                builder: (BuildContext context) {
                  // Use a Builder widget to get a new context to call Scaffold.of(context)
                  if (state is LoadingOrderState) {
                    // Show a loading indicator while data is being fetched
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return homeCubit.OrderData.isEmpty
                        ? Center(child: Text('لا يوجد طلبات'))
                        : ListView.builder(
                      itemCount: homeCubit.OrderData.length,
                      itemBuilder: (context, index) {
                        Order order = homeCubit.OrderData[index];
                        homeCubit.OrderData[index].fetchOrderData();
                       // state.order[index].orders[index].fetchOrderData();
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
                                Text('الكمية: ${order.Quantity} لتر'),
                                Text('الهدية: ${order.CustomerGift}'),
                              ],
                            ),
                            trailing: Directionality(
                              textDirection: TextDirection.rtl,
                              child: IconButton(
                                icon: Icon(Icons.arrow_forward_ios, color: AppColors.primaryColor, size: 20,),
                                onPressed: () {
                                  showModalBottomSheet(
                                    backgroundColor: Colors.white,
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                                    builder: (context) => Container(
                                      height: 300,
                                      child: SelectOrderStateDialog(
                                        homeOrderCubit: homeCubit, states: state, index: 0,
                                      ),
                                    ),
                                  );
                                },
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