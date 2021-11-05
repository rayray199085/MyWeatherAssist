import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_weather_assist/components/custom_base_view.dart';
import 'package:my_weather_assist/config/app_color.dart';
import 'package:my_weather_assist/config/app_font.dart';

import 'logic.dart';

class HomePage extends StatelessWidget {
  final logic = Get.put(HomeLogic());
  final state = Get.find<HomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return CustomBaseView(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: RichText(
          text: TextSpan(
            text: 'Home',
            style: TextStyle(
              color: AppColors.appbarColor,
              fontSize: ScreenUtil().setSp(AppFonts.h2),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.only(right: 15),
            ),
            onPressed: logic.logout,
            child: RichText(
              text: TextSpan(
                text: 'Logout',
                style: TextStyle(
                  color: AppColors.appbarColor,
                  fontSize: ScreenUtil().setSp(AppFonts.h5),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
