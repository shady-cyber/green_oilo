import 'package:flutter/material.dart';
import '../styles/strings/app/app_strings.dart';
import 'app_routes.dart';

class AppRoutes {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static Route? onGenerateRoute(RouteSettings routeSettings) {
    //////////////////////////Auth//////////////////////////////
    switch (routeSettings.name) {
      // case Routes.onboarding:
      //   return MaterialPageRoute(builder: (context) {
      //     return OnboardingScreen();
      //   });

      // case Routes.initialRoute:
      //   return MaterialPageRoute(builder: (context) {
      //     return CacheHelper.getData(key: "emailRemeber") != null
      //         ? CacheHelper.getData(key: "type") == 'Coach'
      //             ? LayoutCoach(currentIndex: 0)
      //             : LayoutTrainee(currentIndex: 0)
      //         : const SplashScreen();
      //     //  return const SplashScreen();
      //   });
      // case Routes.splash:
      //   return MaterialPageRoute(builder: (context) {
      //     return const SplashScreen();
      //   });
      // case Routes.login:
      //   return MaterialPageRoute(builder: (context) {
      //     return LoginScreen(
      //       withError: false,
      //       hidePassword: false,
      //       obscureText: false,
      //     );
      //   });
      //
      // case Routes.updateEmail:
      //   return MaterialPageRoute(builder: (context) {
      //     final Map<String, dynamic> arguments =
      //         routeSettings.arguments as Map<String, dynamic>;
      //     final loginCubit = arguments['loginCubit'];
      //     final oldEmail = arguments['oldEmail'];
      //     return UpdateEmailScreen(
      //       loginCubit: loginCubit,
      //       oldEmail: oldEmail,
      //     );
      //   });
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: ((context) => const Scaffold(
              body: Center(
                child: Text(AppStrings.noRouteFound),
              ),
            )));
  }
}
