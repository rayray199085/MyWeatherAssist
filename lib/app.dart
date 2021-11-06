import 'package:my_weather_assist/config/app_color.dart';
import 'package:my_weather_assist/config/app_config.dart';
import 'package:my_weather_assist/config/app_font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_weather_assist/routes/app_pages.dart';
import 'package:my_weather_assist/shared/logger/logger_utils.dart';

class MyWeatherAssistApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //prevent rotation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    //for easy loading setup
    EasyLoading.instance
      ..displayDuration = const Duration(seconds: TOAST_DURATION)
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..progressColor = Colors.white
      ..indicatorSize = 50.0
      ..radius = 5.0
      ..fontSize = AppFonts.h5
      ..backgroundColor = Colors.transparent
      ..indicatorColor = AppColors.primaryColor
      ..textColor = Colors.white
      ..maskColor = Colors.black.withOpacity(0.1)
      ..userInteractions = false
      ..boxShadow = [];

    //for adapting screen size & font size
    return ScreenUtilInit(
      designSize: Size(375, 667),
      builder: () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'my_weather_assist',
        theme: ThemeData.light(),
        darkTheme: ThemeData.light(), // disable dark mode theme
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes(),
        builder: EasyLoading.init(
          builder: (BuildContext context, Widget? child) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: MediaQuery(
                //app font size does not change with the system font size
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child ?? Container(),
              ),
            );
          },
        ),
        routingCallback: (routing) {
          print('current route is ${routing?.current}');
        },
        locale: Get.deviceLocale,
        fallbackLocale: Get.deviceLocale,
        enableLog: true,
        logWriterCallback: Logger.write,
        defaultTransition: Transition.native,
        opaqueRoute: Get.isOpaqueRouteDefault,
        popGesture: Get.isPopGestureEnable,
        transitionDuration: Get.defaultTransitionDuration,
      ),
    );
  }
}
