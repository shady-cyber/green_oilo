import 'package:flutter/material.dart';
import '../../../../../../../../business/connection/backend/dio_helper.dart';
import '../../../../../../../../business/connection/backend/end_points.dart';
import '../../../business/shared/widgets/loader.dart';
import '../model/order_model.dart';
import 'order_abstract.dart';

class OrderDataRepo extends OrderRepoAbstract {
  @override
  Future<List<Order>> getOrderData(BuildContext context, String phone) async {
    try {
      var result = await DioHelper.getData(
        path: EndPoints.BASE_URL + EndPoints.GET_ALL + phone,
      );
      // Check if the result is a Map
      if (result.data is Map<String, dynamic>) {
        Map<String, dynamic> data = result.data;
        if (data.isNotEmpty) {
          // Return a list with a single Order object
          return [Order.fromJson(data)];
        } else {
          throw Exception("Order data is empty");
        }
      } else if (result.data is List<dynamic>) {
        // Handle the case where the result is a List
        List<dynamic> dataList = result.data;
        // Convert the list to a list of Order objects
        List<Order> orderList = dataList.map((item) => Order.fromJson(item))
            .toList();

        return orderList;
      } else {
        throw Exception("Unexpected data format");
      }
    } catch (error) {
      if (error.toString().contains("404")) {
        Loader.stop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("هذا الرقم غير مسجل"),
          ),
        );
      }
      throw Exception("Error fetching order data: $error");
    }
  }
}