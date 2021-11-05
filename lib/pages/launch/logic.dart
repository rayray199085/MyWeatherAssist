import 'dart:async';

import 'package:my_weather_assist/config/app_shared_key.dart';
import 'package:my_weather_assist/pages/page_service.dart';
import 'package:my_weather_assist/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_weather_assist/utils/string.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'state.dart';

class LaunchLogic extends GetxController {
  final state = LaunchState();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      PageService().preferences = await SharedPreferences.getInstance();
      String token =
          getNonNullString(PageService().preferences.getString(ACCESS_TOKEN));
      if (token.isNotEmpty) {
        PageService().token = token;
        Get.offNamed(Routes.HOME);
      } else {
        Get.offNamed(Routes.LOGIN);
      }
    });
  }
}
