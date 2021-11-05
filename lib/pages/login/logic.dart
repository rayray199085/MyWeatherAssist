import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:my_weather_assist/config/app_shared_key.dart';
import 'package:my_weather_assist/pages/page_service.dart';
import 'package:my_weather_assist/routes/app_pages.dart';
import 'package:my_weather_assist/utils/toast.dart';

import 'state.dart';

class LoginLogic extends GetxController {
  final state = LoginState();

  void updatePasswordDisplayStatus() {
    state.isShowingPw.value = !state.isShowingPw.value;
  }

  void clickLoginButton() async {
    if (state.formState.currentState!.validate()) {
      EasyLoading.show();
      bool res = await verifyCredentials(
          username: state.usernameController.text,
          password: state.passwordController.text);
      EasyLoading.dismiss();
      if (res) {
        PageService()
            .preferences
            .setString(ACCESS_TOKEN, DateTime.now().toIso8601String());
        Get.offAllNamed(Routes.HOME);
      } else {
        showToast('Username or password is incorrect.');
      }
    }
  }

  Future<bool> verifyCredentials({
    required String username,
    required String password,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    if (username.trim().toLowerCase() != 'blackdog' || password != 'test1234') {
      return false;
    }
    return true;
  }
}
