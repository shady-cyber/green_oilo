import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';

class HomeOrderCubit extends Cubit<HomeOrderState> {
  HomeOrderCubit() : super(InitialHomeOrderState());

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

}