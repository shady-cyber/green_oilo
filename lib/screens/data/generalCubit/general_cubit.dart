import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_template/business/shared/widgets/loader.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../business/saved_data/cache_helper.dart';
import '../model/order_main_model.dart';
import '../model/order_model.dart';
import '../repo/order_repo.dart';
import 'general_state.dart';

class GeneralCubit extends Cubit<GeneralState> {
  GeneralCubit() : super(InitialGeneralState());

  final OrderDataRepo repo = OrderDataRepo();
  Object? selectOrder = 0;
  bool oneTime = false;
  bool showTextview = false;
  int selectIndexOfOrder = 1;
  List<Order> DeliveredData = [];
  List<Order> OrderData = [];
  List<OrdersMain> DeliveryBoyData = [];


  selectOrderFunc(Object item, int index) {
    emit(LoadingOrderState());
    oneTime = true;
    selectOrder = item;
    selectIndexOfOrder = index;
    emit(SuccessOrderLoaded());
  }

  handelShowTextview(){
    emit(LoadingOrderState());
    showTextview = !showTextview;
    emit(SuccessOrderLoaded());
  }

  Future<GeneralOrderData> fetchOrderData(BuildContext context, String phoneNumber) async {
    // Simulate data fetching and transform the response to GeneralOrderData
    final response = await fetchOrderDataFromApi(context, phoneNumber);
    return GeneralOrderData(response);
  }

  Future <List<OrdersMain>> fetchOrderDataFromApi(BuildContext context, String phone) async {
    bool result = false;
    emit(LoadingOrderState());
    DeliveredData.clear();
    OrderData.clear();
    List<OrdersMain> data = await repo.getOrderData(context, phone);
    data = data.reversed.toList();
    try {
      for(int i = 0; i < data[0].orders.length; i++){
        if(data[0].orders.isNotEmpty){
          if(data[0].orders[i].status != "pending"){
            data[0].orders[i].orderDeliveredData.add(data[0].orders[i]);
            DeliveredData.add(data[0].orders[i]);
        } else if(data[0].orders[i].status == "pending"){
            data[0].orders[i].orderData.add(data[0].orders[i]);
            OrderData.add(data[0].orders[i]);
          }
          DeliveryBoyData.add(data[0]);
        }
      }
      emit(GeneralOrderData(data));
      // data.orderData = data;
      // data.fetchOrderData();
      if(data != null){
        result = true;
        savePhoneNumber(phone);
        emit(SuccessOrderLoaded());
        return data;
      } else {
        Loader.stop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(" من فضلك ادخل رقم الهاتف المسجل بشكل صحيح"),
            ));
        emit(ErrorOrderLoaded());
        return data;
      }
    } catch (e) {
      Loader.stop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(" من فضلك ادخل رقم الهاتف المسجل بشكل صحيح"),
          ));
      emit(ErrorOrderLoaded());
      return [];
    }
  }


  Future<bool> sendOrderStatus(String status, int orderId, String? notes) async {
    emit(LoadingOrderState());
    String phone = CacheHelper.getData(key: "phone");
    try {
      await repo.sendOrderStatus(status, orderId,
          notes, phone);
      emit(SuccessOrderDeliveryLoaded());
      return true;
    } on DioError catch (e) {
      print(e);
      print(e.error);
      print(e.message);
      emit(ErrorOrderLoaded());
      return false;
    }
  }

  savePhoneNumber(String phone) {
    emit(LoadingOrderState());
      CacheHelper.saveData(key: "phone", value: phone);
      emit(SuccessOrderLoaded());
  }

  Future<void> refreshData(BuildContext context) async {
    emit(LoadingOrderState()); // Add a loading state
    await Future.delayed(Duration(seconds: 2));
    fetchOrderData(context, CacheHelper.getData(key: "phone"));
    emit(SuccessOrderLoaded());
  }

  void makePhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}