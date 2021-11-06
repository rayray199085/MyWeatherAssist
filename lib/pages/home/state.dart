import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_weather_assist/entities/weather.dart';

class HomeState {
  late RxBool enabledPosition;
  late final TextEditingController cityNameController;
  late Rx<WeatherData?> weatherData;
  HomeState() {
    enabledPosition = false.obs;
    cityNameController = TextEditingController();
    weatherData = Rx(null);
  }
}
