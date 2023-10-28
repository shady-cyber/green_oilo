import 'package:flutter/material.dart';
//import '../../../../Basic_Features/Shared/signin/presentation/screens/splash_screen/splash_screen.dart';

void snackBarMessage (BuildContext context, String message){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
  ));
}

void snackBarMessageCode (BuildContext context, String message){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 2)
  ));
}

void closeScreen(BuildContext context){
  Navigator.pop(context);
}

// void backToSplash(BuildContext context) {
//   Navigator.pushReplacement(
//     context,
//   //   MaterialPageRoute(
//   //       builder: (context) => SplashScreen()),
//   // );
// }

