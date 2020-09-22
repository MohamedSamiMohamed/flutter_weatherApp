import 'package:meta/dart2js.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Providers/DateProvider.dart';
import 'pages/location.dart';
import 'pages/home_weather.dart';

void main() {
  runApp(ChangeNotifierProvider<DateProvider>(
      create: (context) => DateProvider(),
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => HomeWeather(),
          '/location': (context) => ChooseLocation(),
        },
      )));
}
