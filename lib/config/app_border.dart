import 'package:my_weather_assist/config/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const OutlineInputBorder defaultBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: AppColors.grey2,
  ),
  borderRadius: BorderRadius.all(
    Radius.circular(10),
  ),
);

const OutlineInputBorder defaultErrorBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: AppColors.errorColor,
  ),
  borderRadius: BorderRadius.all(
    Radius.circular(10),
  ),
);

const UnderlineInputBorder contactBorder = UnderlineInputBorder(
  borderSide: BorderSide(
    color: AppColors.grey2,
  ),
);

const UnderlineInputBorder contactErrorBorder = UnderlineInputBorder(
  borderSide: BorderSide(
    color: AppColors.errorColor,
  ),
);
