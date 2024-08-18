import 'package:flutter/material.dart';
import 'package:sample_template/screens/data/generalCubit/general_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config/routes/app_routes_logic.dart';
import 'config/styles/strings/app/app_strings.dart';
import 'config/themes/app_theme.dart';
import 'screens/data/generalCubit/general_state.dart';
import 'screens/persentation/home/home_screen.dart';
import 'screens/persentation/login/login_screen.dart';
import 'screens/persentation/splash/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<String> _getPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('phoneNumber') ?? "0";
  }

  @override
  Widget build(BuildContext context) {
    // Initialize your GeneralCubit here
    final GeneralCubit homeCubit = GeneralCubit();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: _checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: SplashScreen(),
            );
          } else if (snapshot.hasData && snapshot.data == true) {
            return FutureBuilder<String>(
              future: _getPhoneNumber(),
              builder: (context, phoneSnapshot) {
                if (phoneSnapshot.connectionState == ConnectionState.waiting) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    home: SplashScreen(),
                  );
                } else if (phoneSnapshot.hasData) {
                  return FutureBuilder<GeneralOrderData>(
                    future: homeCubit.fetchOrderData(context, phoneSnapshot.data!), // Ensure correct type
                    builder: (context, orderSnapshot) {
                      if (orderSnapshot.connectionState == ConnectionState.waiting) {
                        return MaterialApp(
                          home: SplashScreen(),
                        );
                      } else if (orderSnapshot.hasData) {
                        return MaterialApp(
                          debugShowCheckedModeBanner: false,
                          navigatorKey: AppRoutes.navigatorKey,
                          title: AppStrings.appName,
                          theme: appTheme(),
                          onGenerateRoute: AppRoutes.onGenerateRoute,
                          home: HomeScreen(
                            homeCubit: homeCubit,
                            state: orderSnapshot.data!, // Pass the fetched GeneralOrderData
                          ),
                        );
                      } else {
                        return MaterialApp(
                          debugShowCheckedModeBanner: false,
                          home: Scaffold(
                            body: Center(child: Text('Failed to load orders')),
                          ),
                        );
                      }
                    },
                  );
                } else {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    home: Scaffold(
                      body: Center(child: Text('Failed to load phone number')),
                    ),
                  );
                }
              },
            );
          } else {
            return MaterialApp(
              navigatorKey: AppRoutes.navigatorKey,
              debugShowCheckedModeBanner: false,
              title: AppStrings.appName,
              theme: appTheme(),
              onGenerateRoute: AppRoutes.onGenerateRoute,
              home: LoginScreen(),
            );
          }
        },
      ),
    );
  }
}