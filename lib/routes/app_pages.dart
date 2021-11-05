import 'package:my_weather_assist/pages/home/view.dart';
import 'package:my_weather_assist/pages/launch/view.dart';
import 'package:get/get.dart';
import 'package:my_weather_assist/pages/login/view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LAUNCH;

  static List<GetPage> routes() {
    return [
      GetPage(
          name: Routes.LAUNCH,
          page: () => LaunchPage(),
          transition: Transition.fadeIn),
      GetPage(
          name: Routes.LOGIN,
          page: () => LoginPage(),
          transition: Transition.fadeIn),
      GetPage(
        name: Routes.HOME,
        page: () => HomePage(),
      ),
    ];
  }
}
