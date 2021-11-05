import 'package:get/get.dart';
import 'package:my_weather_assist/config/app_shared_key.dart';
import 'package:my_weather_assist/pages/page_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_weather_assist/routes/app_pages.dart';

import 'state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();

  Future<void> logout() async {
    PageService().preferences.setString(ACCESS_TOKEN, '');
    EasyLoading.show();
    await Future.delayed(Duration(seconds: 1));
    EasyLoading.dismiss();
    Get.offNamed(Routes.LOGIN);
  }
}
