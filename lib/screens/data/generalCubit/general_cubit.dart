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
  int selectIndexOfOrder = 1;


  selectOrderFunc(Object item, int index) {
    emit(LoadingOrderState());
    oneTime = true;
    selectOrder = item;
    selectIndexOfOrder = index;
    emit(SuccessOrderLoaded());
  }

  Future <List<Order>> fetchOrderData(BuildContext context, String phone) async {
    bool result = false;
    emit(LoadingOrderState());
    List<Order> data = await repo.getOrderData(context, phone);
    try {
      for(int i = 0; i < data.length; i++){
        if(data[i].orderData.isEmpty){
          data[i].orderData.add(data[i]);
        //  data[i].fetchOrderData();
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

  savePhoneNumber(String phone) {
    emit(LoadingOrderState());
      CacheHelper.saveData(key: "phone", value: phone);
      emit(SuccessOrderLoaded());
  }


}