import 'package:my_weather_assist/config/app_color.dart';
import 'package:flutter/material.dart';

class CustomBaseView extends StatefulWidget {
  @override
  _CustomBaseViewState createState() {
    return new _CustomBaseViewState();
  }

  final PreferredSizeWidget appBar;
  final Widget body;
  final Color bgColor;
  final Widget? floatingActionButton;

  CustomBaseView({
    Key? key,
    required this.appBar,
    required this.body,
    this.bgColor = Colors.white,
    this.floatingActionButton,
  }) : super(key: key);
}

class _CustomBaseViewState extends State<CustomBaseView> {
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: widget.appBar,
        body: widget.body,
        backgroundColor: widget.bgColor,
        floatingActionButton: widget.floatingActionButton,
      ),
    );
  }
}
