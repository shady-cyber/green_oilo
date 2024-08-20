import 'package:equatable/equatable.dart';

import '../model/order_main_model.dart';
import '../model/order_model.dart';

abstract class GeneralState extends Equatable {
  const GeneralState();

  @override
  List<Object?> get props => [];
}

class GeneralOrderData extends GeneralState {
  final List<OrdersMain> order;
  GeneralOrderData(this.order) : super();

  factory GeneralOrderData.fromJson(Map<String, dynamic> json) {
    final List<dynamic> orderListJson = json['order'];
    final List<OrdersMain> orderList = orderListJson.map((orderJson) => OrdersMain.fromJson(orderJson)).toList();
    return GeneralOrderData(orderList);
  }
  @override
  List<Object?> get props => [order];
}


class InitialGeneralState extends GeneralState {}

class LoadingOrderState extends GeneralState {}

class SuccessOrderLoaded extends GeneralState {}

class HeaderTextChanged extends GeneralState {}

class ShowAnimationState extends GeneralState {}

class SuccessOrderDeliveryLoaded extends GeneralState {}

class ErrorOrderLoaded extends GeneralState {}