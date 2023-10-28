import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_states.dart';

class SplashCubit extends Cubit<CoachHomeStates> {
  SplashCubit() : super(CoachHomeInitalState());
  // bool image_loaded = true;
  // String img = "";
  // String firstname = "";
  // String lastname = "";
  // bool isVisible = true;
  //
  // // void logout() {
  // //   di<SuccessSignupCoachCubit>().clearSignUpCoachData();
  // //   Navigator.pushReplacementNamed(
  // //       AppRoutes.navigatorKey.currentContext!, Routes.login);
  // //   StorageService.removeUserFromStorage();
  // // }
  //
  //
  // Future<CoachHome> fetchProfileData() async {
  //   CoachHome coach = await CoachHomeRepo().getProfileData();
  //   try {
  //     coach.fetchData();
  //     emit(CoachProfileData(coach));
  //   } catch (e) {
  //     emit(CoachProfileError("Failed to fetch profile data."));
  //   }
  //   return coach;
  // }
  //
  // Future<String> getCoachProfileImage() async{
  //   img = await CoachHomeRepo().getProfilePicture();
  //   image_loaded = false;
  //   emit(SuccessCoachImageLoaded());
  //   return img;
  // }
}
