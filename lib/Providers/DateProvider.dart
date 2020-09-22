import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/network/DateRequest.dart';
import 'package:provider/provider.dart';

class DateProvider extends ChangeNotifier {
  String city;
  String time;
  bool _isDayTime;
  String location;

  bool get isDayTime => _isDayTime;

  void setIsDayTime(bool isDayTime) {
    _isDayTime = isDayTime;
    notifyListeners();
  }

  void changeTime(String newTime) {
    time = newTime;
    notifyListeners();
  }

  DateProvider({this.city});
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
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
        Provider.of<DateProvider>(context, listen: false)
            .setIsDayTime(tempIsDayTime);
        Provider.of<DateProvider>(context, listen: false)
            .changeTime(DateFormat.jm().format(now));
      } else {
        print('failed');
      }
    } catch (e) {
      print('error occured$e');
    }
  }
}
