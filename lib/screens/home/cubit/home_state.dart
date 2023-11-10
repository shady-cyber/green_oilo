import 'package:equatable/equatable.dart';

abstract class HomeOrderState extends Equatable {
  const HomeOrderState();

  @override
  List<Object> get props => [];
}

class InitialHomeOrderState extends HomeOrderState {}

class LoadingOrderState extends HomeOrderState {}

class SuccessOrderLoaded extends HomeOrderState {}