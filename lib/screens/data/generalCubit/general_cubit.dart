import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_template/business/shared/widgets/loader.dart';
import '../../../business/saved_data/cache_helper.dart';
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

  Future <List<Order>> fetchOrderData(BuildContext context, String phone) async {
    bool result = false;
    emit(LoadingOrderState());
    DeliveredData.clear();
    OrderData.clear();
    List<Order> data = await repo.getOrderData(context, phone);
    try {
      for(int i = 0; i < data.length; i++){
        if(data[i].orderData.isEmpty){
          if(data[i].status != "pending"){
            data[i].orderDeliveredData.add(data[i]);
            DeliveredData.add(data[i]);
        } else if(data[i].status == "pending"){
            data[i].orderData.add(data[i]);
            OrderData.add(data[i]);
          }
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


  sendOrderStatus(String status, int orderId, String? notes) async {
    emit(LoadingOrderState());
    String phone = CacheHelper.getData(key: "phone");
    try {
      await repo.sendOrderStatus(status, orderId,
          notes, phone);
      emit(SuccessOrderDeliveryLoaded());
    } on DioError catch (e) {
      print(e);
      print(e.error);
      print(e.message);
      emit(ErrorOrderLoaded());
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
    repo.getOrderData(context, CacheHelper.getData(key: "phone"));
    emit(SuccessOrderLoaded());
  }

}