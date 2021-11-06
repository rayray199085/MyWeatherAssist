import 'dart:async';

import 'package:my_weather_assist/config/app_config.dart';
import 'package:my_weather_assist/entities/weather.dart';
import 'package:my_weather_assist/utils/http_util.dart';

class WeatherApi {
  static Future<WeatherData?> fetchPositionWeatherData({
    required double latitude,
    required double longitude,
  }) async {
    final url =
        'weather?lat=$latitude&lon=$longitude&appid=${AppConfig.apiKey}';
    print(url);
    Map<String, dynamic>? response = await HttpUtil().get(url);

    print('response: ${response.toString()}');
    return response != null ? WeatherData.fromJson(response) : null;
  }

  static Future<WeatherData?> fetchCityNameWeatherData({
    required String cityName,
  }) async {
    final url = 'weather?q=$cityName&appid=${AppConfig.apiKey}';
    print(url);
    Map<String, dynamic>? response = await HttpUtil().get(url);

    print('response: ${response.toString()}');
    return response != null ? WeatherData.fromJson(response) : null;
  }
}
