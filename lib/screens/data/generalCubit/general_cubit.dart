import 'package:flutter_bloc/flutter_bloc.dart';
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

  Future<bool> fetchPrivacyData(String phone) async {
    bool result = false;
    emit(LoadingOrderState());
    Order data = await repo.getOrderData(phone);
    try {
      data.fetchOrderData();
      emit(GeneralOrderData(data));
      if(data != null){
        result = true;
        savePhoneNumber(phone);
        emit(SuccessOrderLoaded());
        return result;
      }
    } catch (e) {
      emit(ErrorOrderLoaded());
      return result;
    }
    return result;
  }

  savePhoneNumber(String phone) {
    emit(LoadingOrderState());
      CacheHelper.saveData(key: "phone", value: phone);
      emit(SuccessOrderLoaded());
  }


}