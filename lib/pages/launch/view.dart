import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_weather_assist/components/custom_base_view.dart';

import 'logic.dart';
import 'state.dart';

class LaunchPage extends StatelessWidget {
  final LaunchLogic logic = Get.put(LaunchLogic());
  final LaunchState state = Get.find<LaunchLogic>().state;

  @override
  Widget build(BuildContext context) {
    return CustomBaseView(
      bgColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Container(),
      ),
    );
  }
}
