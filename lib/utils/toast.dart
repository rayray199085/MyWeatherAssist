import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_weather_assist/config/app_config.dart';
import 'package:my_weather_assist/utils/string.dart';

Future<void> showToast(String? text) async {
  String nonNullText = getNonNullString(text);
  if (nonNullText.isNotEmpty) {
    EasyLoading.instance.backgroundColor = Colors.grey.shade600;
    EasyLoading.showToast(nonNullText);
    await Future.delayed(Duration(seconds: TOAST_DURATION));
    EasyLoading.instance.backgroundColor = Colors.transparent;
  }
}
