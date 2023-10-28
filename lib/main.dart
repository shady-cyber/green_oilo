import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app.dart';
import 'business/connection/backend/di.dart';
import 'business/saved_data/cache_helper.dart';

void main() async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  runApp(
    ScreenUtilInit(
      builder: (child, context) =>
          DevicePreview(enabled: false, builder: (context) => const MyApp()),
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
    ),
  );
  await initializeDependency();
}
