import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeState {
  late RxBool enabledPosition;
  late final TextEditingController cityNameController;
  HomeState() {
    enabledPosition = false.obs;
    cityNameController = TextEditingController();
  }
}
