import 'package:meta/dart2js.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Controllers/DateController.dart';
import 'pages/location.dart';
import 'pages/Home.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    getPages: [
      GetPage(name: '/', page: () => HomeWeather()),
      GetPage(
        name: '/locations',
        page: () => ChooseLocation(),
      )
    ],
  ));
}
