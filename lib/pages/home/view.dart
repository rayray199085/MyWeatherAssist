import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_weather_assist/components/custom_base_view.dart';
import 'package:my_weather_assist/config/app_border.dart';
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
        bottom: PreferredSize(
          preferredSize: Size(
            Get.mediaQuery.size.width,
            ScreenUtil().setHeight(40),
          ),
          child: Container(
            margin: EdgeInsets.all(5),
            child: TextField(
              controller: state.cityNameController,
              cursorColor: Colors.black,
              keyboardType: TextInputType.text,
              onSubmitted: (_) {
                logic.searchCityNameWeather();
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.grey1,
                  size: ScreenUtil().setSp(AppFonts.h2),
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: ScreenUtil().setHeight(5),
                ),
                enabledBorder: defaultBorder,
                focusedBorder: defaultBorder,
                focusedErrorBorder: defaultErrorBorder,
                errorBorder: defaultErrorBorder,
              ),
            ),
          ),
        ),
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
