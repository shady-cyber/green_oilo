import 'package:equatable/equatable.dart';

import '../model/order_model.dart';

abstract class GeneralState extends Equatable {
  const GeneralState();

  @override
  List<Object?> get props => [];
}

class GeneralOrderData extends GeneralState {
  final Order order;
  GeneralOrderData(this.order) : super();

  @override
  List<Object?> get props => [order];
}

class InitialGeneralState extends GeneralState {}

class LoadingOrderState extends GeneralState {}

class SuccessOrderLoaded extends GeneralState {}

class ErrorOrderLoaded extends GeneralState {}