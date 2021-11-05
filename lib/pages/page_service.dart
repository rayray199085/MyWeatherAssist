import 'package:shared_preferences/shared_preferences.dart';

class PageService {
  static final PageService _singleton = new PageService._internal();

  factory PageService() {
    return _singleton;
  }

  PageService._internal();
  String token = '';
  late SharedPreferences preferences;
}
