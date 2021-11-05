import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginState {
  late final GlobalKey<FormState> formState;
  late RxBool isUsernameValid;
  late RxBool isPasswordValid;
  late RxBool isShowingPw;
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;
  late double appBarHeight;

  LoginState() {
    appBarHeight = ScreenUtil().setHeight(100);
    formState = GlobalKey<FormState>();
    isUsernameValid = true.obs;
    isPasswordValid = true.obs;
    isShowingPw = false.obs;
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }
}
