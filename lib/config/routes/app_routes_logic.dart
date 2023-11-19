import 'package:flutter/material.dart';
import '../../screens/persentation/home/home_screen.dart';
import '../../screens/persentation/login/login_screen.dart';
import '../../screens/persentation/splash/splash_screen.dart';
import '../styles/strings/app/app_strings.dart';
import 'app_routes.dart';

class AppRoutes {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static Route? onGenerateRoute(RouteSettings routeSettings) {
    //////////////////////////Auth//////////////////////////////
    switch (routeSettings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (context) {
          return SplashScreen();
        });

      case Routes.initialRoute:
        return MaterialPageRoute(builder: (context) {
          return SplashScreen();
            // CacheHelper.getData(key: "emailRemeber") != null
            //   ? CacheHelper.getData(key: "type") == 'Coach'
            //       ? LayoutCoach(currentIndex: 0)
            //       : LayoutTrainee(currentIndex: 0)
            //   : const
            // SplashScreen();
          //  return const SplashScreen();
        });
      case Routes.home:
        return MaterialPageRoute(builder: (context) {
              final Map<String, dynamic> arguments =
              routeSettings.arguments as Map<String, dynamic>;
              final homeCubit = arguments['generalCubit'];
              final state = arguments['state'];
              return HomeScreen(
                homeCubit: homeCubit,
                state: state,
              );
            });
    //////////////////////////Auth//////////////////////////////
      case Routes.login:
        return MaterialPageRoute(builder: (context) {
          return LoginScreen(
          );
        });
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
