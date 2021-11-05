import 'package:my_weather_assist/config/app_color.dart';
import 'package:my_weather_assist/config/app_font.dart';
import 'package:my_weather_assist/pages/login/components/password_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'logic.dart';
import 'state.dart';

class LoginPage extends StatelessWidget {
  final LoginLogic logic = Get.put(LoginLogic());
  final LoginState state = Get.find<LoginLogic>().state;

  @override
  Widget build(BuildContext context) {
    double availableHeight = Get.mediaQuery.size.height -
        state.appBarHeight -
        Get.mediaQuery.padding.top -
        Get.mediaQuery.padding.bottom -
        20;
    return Listener(
      onPointerDown: (_) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(state.appBarHeight),
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  title: RichText(
                    text: TextSpan(
                      text: 'MyWeatherAssist',
                      style: GoogleFonts.donegalOne(
                        textStyle: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: ScreenUtil().setSp(AppFonts.h1),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  toolbarHeight: state.appBarHeight,
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              width: Get.width * 0.8,
              height: availableHeight,
              padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(10),
              ),
              alignment: Alignment.center,
              child: Obx(
                () => passwordLogin(state: state, logic: logic),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
