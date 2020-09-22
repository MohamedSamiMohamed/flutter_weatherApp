import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CountryItem {
  String location;
  String _time;

  String get time => _time;

  set time(String time) {
    _time = time;
  }

  String flag;
  String url;
  bool isDayTime;
  CountryItem({this.location, this.flag, this.url});
}
