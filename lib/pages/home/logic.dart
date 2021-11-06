import 'package:get/get.dart';
import 'package:my_weather_assist/api/weather_api.dart';
import 'package:my_weather_assist/config/app_shared_key.dart';
import 'package:my_weather_assist/entities/weather.dart';
import 'package:my_weather_assist/pages/page_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_weather_assist/routes/app_pages.dart';
import 'package:my_weather_assist/utils/toast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'state.dart';

typedef void PositionCallback(Position pos);

class HomeLogic extends GetxController {
  final HomeState state = HomeState();

  @override
  void onReady() {
    super.onReady();
    getCurrentPosition((pos) async {
      EasyLoading.show();
      WeatherData? weatherData = await WeatherApi.fetchPositionWeatherData(
              latitude: pos.latitude, longitude: pos.longitude)
          .catchError((e) {
        print(e.toString());
        showToast(e.toString());
      });
      EasyLoading.dismiss();
      if (weatherData != null) {}
    });
  }

  void searchCityNameWeather() async {
    EasyLoading.show();
    WeatherData? weatherData = await WeatherApi.fetchCityNameWeatherData(
            cityName: state.cityNameController.text.trim())
        .catchError((e) {
      print(e.toString());
      showToast(e.toString());
    });
    EasyLoading.dismiss();
    if (weatherData != null) {}
  }

  Future<void> logout() async {
    PageService().preferences.setString(ACCESS_TOKEN, '');
    EasyLoading.show();
    await Future.delayed(Duration(seconds: 1));
    EasyLoading.dismiss();
    Get.offNamed(Routes.LOGIN);
  }

  Future<void> getCurrentPosition(PositionCallback callback) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showToast('Location services are disabled.');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showToast('Location permissions are denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showToast(
          'Location permissions are permanently denied, we cannot request permissions.');
      return;
    }
    state.enabledPosition.value = true;
    Position position = await Geolocator.getCurrentPosition();
    callback(position);
  }
}
