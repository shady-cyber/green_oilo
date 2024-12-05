import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/styles/colors/app_colors.dart';
import '../../../data/generalCubit/general_cubit.dart';
import '../../../data/generalCubit/general_state.dart';
import '../../../data/model/order_model.dart';
class DeliveredList extends StatefulWidget {

  final GeneralCubit homeCubit;
  final GeneralOrderData state;
  final BuildContext context;

  DeliveredList({super.key, required this.context, required this.state, required this.homeCubit});

  @override
  State<DeliveredList> createState() => _DeliveredListState();
}

class _DeliveredListState extends State<DeliveredList> {
  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: widget.homeCubit,
        child: BlocListener<GeneralCubit, GeneralState>(
          listener: (context, states){
            if (states is SuccessOrderLoaded) {
              _refreshKey.currentState?.show();
            }
          },
          child: BlocBuilder<GeneralCubit, GeneralState>
            (builder: (context, states){
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
                          // Implement refreshData method in your GeneralCubit
                         // await widget.homeCubit.refreshData(context);
                        },
                        child: widget.homeCubit.DeliveredData.isEmpty
                            ? Center(child: Text('لا يوجد طلبات'))
                            : ListView.builder(
                          itemCount: widget.homeCubit.DeliveredData.length,
                          itemBuilder: (context, index) {
                            Order order = widget.homeCubit.DeliveredData[index];
                            widget.homeCubit.DeliveredData[index].fetchOrderData();
                            return Card(
                              color: widget.homeCubit.DeliveredData[index].status ==
                                  "processing"
                                  ? Colors.yellow[50]
                                  : widget.homeCubit.DeliveredData[index].status == "completed"
                                  ? Colors.green[50]
                                  : widget.homeCubit.DeliveredData[index].status == "declined"
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
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(order.CustomerName),
                                    Text('العنوان: ${order.OrderAddress}'),
                                    Text('الهدية: ${order.CustomerGift}'),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('الكمية: ${order.Quantity} لتر'),
                                        Text(
                                          widget.homeCubit.DeliveredData[index].status ==
                                              "processing"
                                              ? 'قيد التنفيذ'
                                              : widget.homeCubit.DeliveredData[index].status ==
                                              "completed"
                                              ? 'تم التنفيذ'
                                              : widget.homeCubit.DeliveredData[index].status ==
                                              "declined"
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
          }),
        ));
  }
}
