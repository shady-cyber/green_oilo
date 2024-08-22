import 'package:flutter/material.dart';
import 'package:reni/screens/persentation/home/widget/select_state_dialog.dart';
import '../../../../config/styles/colors/app_colors.dart';
import '../../../../network.dart';
import '../../../data/generalCubit/general_cubit.dart';
import '../../../data/generalCubit/general_state.dart';
import '../../../data/model/order_model.dart';

class OrdersList extends StatefulWidget {
  final GeneralCubit homeCubit;
  final GeneralOrderData state;
  final BuildContext context;

  OrdersList({super.key, required this.context, required this.state, required this.homeCubit});

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  late bool isOrderListEmpty;

  @override
  void initState() {
    super.initState();
    isOrderListEmpty = widget.homeCubit.OrderData.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
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
          'الطلبات',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.red),
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
                  await widget.homeCubit.refreshData(context);
                  isOrderListEmpty = widget.homeCubit.OrderData.isEmpty;
                },
                child: Builder(
                  builder: (BuildContext context) {
                    if (widget.state is LoadingOrderState) {
                      return Center(child: CircularProgressIndicator());
                    } else if (isOrderListEmpty) {
                      return Center(child: Text('لا يوجد طلبات'));
                    }else {
                      return ListView.builder(
                        itemCount: widget.homeCubit.OrderData.length,
                        itemBuilder: (context, index) {
                          Order order = widget.homeCubit.OrderData[index];
                          // Log data for debugging purposes
                          NetworkConnectivity().logData(order);
                          NetworkConnectivity().logDataString(order.customer.mobileNumber);

                          return Column(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: BorderSide(color: AppColors.primaryColor, width: 0.3),
                                ),
                                elevation: 0,
                                child: ListTile(
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(order.customer.fullName),
                                      Text(
                                        'العنوان: ${order.address.addressLine1 ?? 'No Address'}\n'
                                            '${order.address.addressLine2 != null && order.address.addressLine2!.isNotEmpty ? 'العنوان 2: ${order.address.addressLine2}' : 'No Address 2'}',
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          widget.homeCubit.makePhoneCall(order.customer.mobileNumber);
                                        },
                                        child: Text(
                                          'رقم الهاتف: ${order.customer.mobileNumber}',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                      Text('الكمية: ${order.quantity} لتر'),
                                      Text('الهدية: ${order.gift.giftName}'),
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
                                            isScrollControlled: true,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                            ),
                                            builder: (context) => Padding(
                                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                              child: Container(
                                                height: 300,
                                                child: SelectOrderStateDialog(
                                                  homeOrderCubit: widget.homeCubit,
                                                  states: widget.state,
                                                  index: 0,
                                                  onClose: () {
                                                    widget.homeCubit.showTextview = false;
                                                    widget.homeCubit.showTextviewReceived = false;
                                                  },
                                                ),
                                              ),
                                            ),
                                          ).whenComplete(() {
                                            widget.homeCubit.showTextview = false;
                                            widget.homeCubit.showTextviewReceived = false;
                                            if(widget.homeCubit.OrderData.isEmpty)
                                              Center(child: Text('لا يوجد طلبات'));
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
}

