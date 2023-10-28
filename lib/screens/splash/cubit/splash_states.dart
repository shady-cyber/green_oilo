import 'package:equatable/equatable.dart';

abstract class CoachHomeStates extends Equatable {
  const CoachHomeStates();

  @override
  List<Object> get props => [];
}


// class CoachProfileData extends CoachHomeStates {
//   final CoachHome coach;
//   const CoachProfileData(this.coach);
//
//   @override
//   List<Object?> get prop => [coach];
// }

class CoachProfileError extends CoachHomeStates {
  final String errorMessage;

  CoachProfileError(this.errorMessage);

  @override
  List<Object?> get prop=> [errorMessage];
}

class CoachHomeInitalState extends CoachHomeStates {}

class CoachFirstNameState extends CoachHomeStates {}

class CoachLastNameState extends CoachHomeStates {}

class LoadingCoachProfilePicture extends CoachHomeStates {}

class SuccessCoachImageLoaded extends CoachHomeStates {}

class SuccessCoachScrolled extends CoachHomeStates {}

class ErrorToGetProfileImage extends CoachHomeStates {}