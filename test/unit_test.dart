import 'package:flutter_test/flutter_test.dart';
import 'package:my_weather_assist/api/weather_api.dart';
import 'package:my_weather_assist/entities/weather.dart';

void main() {
  test('load weather data with latitude and longitude', () async {
    WeatherData? weatherData = await WeatherApi.fetchPositionWeatherData(
            latitude: -37.48, longitude: 145.3)
        .catchError((e) {
      print(e.toString());
    });
    expect(weatherData != null, weatherData != null);
  });

  test('load weather data with city name', () async {
    WeatherData? weatherData =
        await WeatherApi.fetchCityNameWeatherData(cityName: 'Sydney')
            .catchError((e) {
      print(e.toString());
    });
    expect(weatherData != null, weatherData != null);
  });
}
