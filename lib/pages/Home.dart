import 'package:flutter/material.dart';
import 'package:weather_app/Controllers/DateController.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:weather_app/pages/location.dart';

class HomeWeather extends StatefulWidget {
  @override
  _HomeWeatherState createState() => _HomeWeatherState();
}

class _HomeWeatherState extends State<HomeWeather> {
  final DateController controller = Get.put(DateController());
  Map data = {};
  String location = 'Africa/Cairo';
  DateController date = DateController(city: 'Cairo');
  void setupTime() async {
    await date.getDate(location, context);
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    if (data != null) {
      date = DateController(city: data['city']);
      location = data['location'];
      controller.changeTime('');
    }
    setupTime();
    String image;
    return Obx(() {
      if (controller.time.value == '') {
        return Scaffold(
          backgroundColor: Colors.blue,
          body: Center(
            child: SpinKitRotatingCircle(
              color: Colors.white,
              size: 50,
            ),
          ),
        );
      } else {
        if (controller.isDayTime.value) {
          image = 'day.png';
        } else {
          image = 'night.png';
        }
        return Scaffold(
          body: SafeArea(
              child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$image'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
              child: Column(
                children: <Widget>[
                  FlatButton.icon(
                    onPressed: () {
                      Get.to(ChooseLocation());
                    },
                    icon: Icon(
                      Icons.edit_location,
                      color: Colors.grey[300],
                    ),
                    label: Text(
                      'Edit location',
                      style: TextStyle(
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        date.city,
                        style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 2,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(() {
                    return Text(
                      '${controller.time}',
                      style: TextStyle(fontSize: 66),
                    );
                  }),
                ],
              ),
            ),
          )),
        );
      }
    });
  }
}
