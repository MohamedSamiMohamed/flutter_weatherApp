import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/network/DateRequest.dart';
import 'package:get/get.dart';

class DateController extends GetxController {
  String city;
  var time = ''.obs;
  var isDayTime = false.obs;
  String location;

  void setIsDayTime(var isDayTime) {
    this.isDayTime.value = isDayTime;
    update();
  }

  void changeTime(var newTime) {
    this.time.value = newTime;
    update();
  }

  DateController({this.city});
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
  }

  Future<void> getDate(city, BuildContext context) async {
    isLoading = true;
    try {
      Response response = await DateRequest(city: city).getDate();
      if (response.statusCode == 200) {
        isLoading = false;
        Map data = jsonDecode(response.body);
        print(data);
        String dateTime = data['utc_datetime'];
        String offset = data['utc_offset'].substring(1, 3);
        DateTime now = DateTime.parse(dateTime);
        now = now.add(Duration(hours: int.parse(offset)));
        bool tempIsDayTime = now.hour > 6 && now.hour < 18 ? true : false;
        Get.find<DateController>().setIsDayTime(tempIsDayTime);
        Get.find<DateController>().changeTime(DateFormat.jm().format(now));
      } else {
        print('failed');
      }
    } catch (e) {
      print('error occured$e');
    }
  }
}
