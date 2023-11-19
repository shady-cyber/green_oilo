import '../../../../../../../../business/connection/backend/dio_helper.dart';
import '../../../../../../../../business/connection/backend/end_points.dart';
import '../model/order_model.dart';
import 'order_abstract.dart';

class OrderDataRepo extends OrderRepoAbstract {
  @override
  Future<Order> getOrderData(String phone) async {
    try {
      phone = "01020315690";
      var result = await DioHelper.getData(
          path: EndPoints.BASE_URL+EndPoints.GET_ALL+phone,
          );

      Map<String, dynamic> data = result.data;
      if(data.isNotEmpty) {
        Order order = Order.fromJson(data);
        return order;
      }else{
        throw Exception("order data is empty");
      }
    } catch (error) {
      throw Exception("Error fetching order data");
    }
  }


}
