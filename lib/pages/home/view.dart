import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_weather_assist/components/custom_base_view.dart';
import 'package:my_weather_assist/config/app_border.dart';
import 'package:my_weather_assist/config/app_color.dart';
import 'package:my_weather_assist/config/app_font.dart';
import 'package:my_weather_assist/utils/string.dart';

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
                hintStyle: TextStyle(
                  color: AppColors.grey1,
                  fontSize: ScreenUtil().setSp(AppFonts.h5),
                ),
                hintText: 'Enter city name',
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
      body: Obx(() {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: state.weatherData.value != null
                ? _getWeatherContent()
                : RichText(
                    text: TextSpan(
                      text: 'Please enter the city name you want to search.',
                      style: TextStyle(
                        color: AppColors.grey1,
                        fontSize: ScreenUtil().setSp(AppFonts.h4),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
          ),
        );
      }),
    );
  }

  Widget _getWeatherContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text:
                  'Weather today in ${getNonNullString(state.weatherData.value!.name)}',
              style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(AppFonts.h4),
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(10),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: state.weatherData.value!.main != null
                      ? '${getTemperature(state.weatherData.value!.main!.temp ?? 0)}\n'
                      : '',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(AppFonts.h0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text:
                      state.weatherData.value!.main != null ? 'Feels like' : '',
                  style: TextStyle(
                    color: AppColors.grey1,
                    fontSize: ScreenUtil().setSp(AppFonts.h4),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
            ),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: state.weatherData.value!.weather != null &&
                          state.weatherData.value!.weather!.isNotEmpty
                      ? '${getNonNullString(state.weatherData.value!.weather!.first.main)}'
                      : '',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(AppFonts.h2),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ]),
            ),
          ],
        ),
        SizedBox(
          height: ScreenUtil().setHeight(15),
        ),
        _labelItem(
          label: 'High / Low',
          text: state.weatherData.value!.main != null
              ? '${getTemperature(state.weatherData.value!.main!.tempMax ?? 0)}/'
                  '${getTemperature(state.weatherData.value!.main!.tempMin ?? 0)}'
              : '',
        ),
        _labelItem(
          label: 'Humidity',
          text: state.weatherData.value!.main != null
              ? '${state.weatherData.value!.main!.humidity ?? 0}%'
              : '',
        ),
        _labelItem(
          label: 'Pressure',
          text: state.weatherData.value!.main != null
              ? '${state.weatherData.value!.main!.pressure ?? 0} mb'
              : '',
        ),
        _labelItem(
          label: 'Visibility',
          text: _getDistanceText(state.weatherData.value!.visibility),
        ),
        _labelItem(
          label: 'Wind',
          text: state.weatherData.value!.wind != null
              ? '${state.weatherData.value!.wind!.speed ?? 0} km/h'
              : '',
        ),
      ],
    );
  }

  String _getDistanceText(int? distance) {
    num dis = (distance ?? 0).toDouble() / 1000;
    if (dis < 1) {
      return '${(dis * 100).round()} m';
    }
    return '${dis.toStringAsFixed(2)} km';
  }

  Widget _labelItem({required String label, required String? text}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(5)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: '$label: ',
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: ScreenUtil().setSp(
                      AppFonts.h5,
                    ),
                    fontWeight: FontWeight.bold),
              ),
            ]),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: getNonNullString(text),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(
                        AppFonts.h5,
                      ),
                      fontWeight: FontWeight.normal),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  String getTemperature(double? absTemp) {
    return '${((absTemp ?? 0) - 273.15).toInt().toString()}°';
  }
}
