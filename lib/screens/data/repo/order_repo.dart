import 'package:flutter/material.dart';
import '../../../../../../../../business/connection/backend/dio_helper.dart';
import '../../../../../../../../business/connection/backend/end_points.dart';
import '../../../business/shared/widgets/loader.dart';
import '../model/delivery_model.dart';
import '../model/order_main_model.dart';
import '../model/order_model.dart';
import 'order_abstract.dart';

class OrderDataRepo extends OrderRepoAbstract {
  @override
  Future<List<OrdersMain>> getOrderData(BuildContext context, String phone) async {
    try {
      var result = await DioHelper.getData(
        path: EndPoints.BASE_URL + EndPoints.SUB_URL + EndPoints.GET_ALL + phone,
      );
      if (result.data is Map<String, dynamic>) {
        Map<String, dynamic> data = result.data;

        if (data.isNotEmpty) {
          return [OrdersMain.fromJson(data)];
        } else {
          throw Exception("Order data is empty");
        }
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

  @override
  Future<DeliveryOrder> sendOrderStatus(String status, String? base64Image, int orderId,
      String? notes, String phone) async {
    var response = await DioHelper.postData(
      path: EndPoints.UPDATE_ORDER,
      data: {
        "status": status,
        "order_image": base64Image,
        "order_id": orderId,
        "notes": notes,
        "delivery_mobile": phone,
      },
    );
    if (response.statusCode == 200) {
      return DeliveryOrder.fromJson(response.data);
    } else {
      throw Exception("Error sending order status");
    }
  }
  //
  // @override
  // Future<void> sendOrderImage(String status, String image, int orderId, String? notes, String phone) async {
  //   var response = await DioHelper.postData(
  //     path: EndPoints.UPDATE_ORDER,
  //     data: {
  //       "status": status,
  //       "order_image": image,
  //       "order_id": orderId,
  //       "notes": notes,
  //       "delivery_mobile": phone,
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //    // return DeliveryOrder.fromJson(response.data);
  //     print(response.data);
  //   } else {
  //     throw Exception("Error sending order status");
  //   }
  // }
}