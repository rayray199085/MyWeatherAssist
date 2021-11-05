import 'package:my_weather_assist/config/app_border.dart';
import 'package:my_weather_assist/config/app_color.dart';
import 'package:my_weather_assist/config/app_font.dart';
import 'package:my_weather_assist/pages/login/logic.dart';
import 'package:my_weather_assist/pages/login/state.dart';
import 'package:my_weather_assist/utils/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget passwordLogin({
  required LoginState state,
  required LoginLogic logic,
}) {
  return Form(
    key: state.formState,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Please Login',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: ScreenUtil().setSp(AppFonts.h3),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(20),
        ),
        TextFormField(
          style: TextStyle(
            color: Colors.black,
            fontSize: ScreenUtil().setSp(AppFonts.h5),
          ),
          validator: (value) {
            if (getNonNullString(value).isEmpty) {
              state.isUsernameValid.value = false;
              return 'Username is required.';
            }
            state.isUsernameValid.value = true;
            return null;
          },
          controller: state.usernameController,
          cursorColor:
              state.isUsernameValid.value ? Colors.black : AppColors.errorColor,
          decoration: _getInputDecoration(
            label: 'Username',
            isValid: state.isUsernameValid.value,
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(10),
        ),
        TextFormField(
          style: TextStyle(
            color: Colors.black,
            fontSize: ScreenUtil().setSp(AppFonts.h5),
          ),
          validator: (value) {
            if (getNonNullString(value).isEmpty) {
              state.isPasswordValid.value = false;
              return 'Password is required.';
            }
            state.isPasswordValid.value = true;
            return null;
          },
          controller: state.passwordController,
          cursorColor:
              state.isPasswordValid.value ? Colors.black : AppColors.errorColor,
          decoration: _getInputDecoration(
            label: 'Password',
            isValid: state.isPasswordValid.value,
            suffixIcon: GestureDetector(
              child: Icon(
                state.isShowingPw.value
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.grey1,
                size: ScreenUtil().setSp(AppFonts.h3),
              ),
              onTap: logic.updatePasswordDisplayStatus,
            ),
          ),
          obscureText: !state.isShowingPw.value,
        ),
        SizedBox(
          height: ScreenUtil().setHeight(10),
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primaryColor,
                  minimumSize: Size(0, ScreenUtil().setHeight(40)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  if (state.formState.currentState!.validate()) {
                    logic.clickLoginButton();
                  }
                },
                child: RichText(
                  text: TextSpan(
                    text: 'LOGIN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(AppFonts.h4),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: ScreenUtil().setHeight(10),
        ),
        RichText(
          text: TextSpan(
            text:
                'This application is only available to existing MyWeatherAssist customers who must use their Username and Password to gain access.',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: ScreenUtil().setSp(AppFonts.h6),
            ),
          ),
        ),
      ],
    ),
  );
}

InputDecoration _getInputDecoration({
  required String label,
  required bool isValid,
  Widget? suffixIcon,
}) {
  return InputDecoration(
    contentPadding: EdgeInsets.symmetric(
      horizontal: 12,
      vertical: ScreenUtil().setHeight(15),
    ),
    errorMaxLines: 3,
    labelText: label,
    labelStyle: TextStyle(
      color: (isValid) ? AppColors.grey1 : AppColors.errorColor,
      fontSize: ScreenUtil().setSp(AppFonts.h5),
    ),
    errorStyle: TextStyle(
      color: AppColors.errorColor,
      fontSize: ScreenUtil().setSp(AppFonts.h6),
    ),
    enabledBorder: defaultBorder,
    focusedBorder: defaultBorder,
    focusedErrorBorder: defaultErrorBorder,
    errorBorder: defaultErrorBorder,
    suffixIcon: suffixIcon,
  );
}
