import 'package:flutter/material.dart';
import 'package:weather_app/Providers/DateProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeWeather extends StatefulWidget {
  @override
  _HomeWeatherState createState() => _HomeWeatherState();
}

class _HomeWeatherState extends State<HomeWeather> {
  Map data = {};
  String location = 'Africa/Cairo';
  DateProvider date = DateProvider(city: 'Cairo');
  void setupTime() async {
    await date.getDate(location, context);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    if (data != null) {
      date = DateProvider(city: data['city']);
      location = data['location'];
      Provider.of<DateProvider>(context, listen: false).changeTime(null);
    }
    setupTime();
    return Consumer<DateProvider>(builder: (context, dateProvider, child) {
      if (dateProvider.time == null) {
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
        String image = dateProvider.isDayTime ? 'day.png' : 'night.png';
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
                      Navigator.pushNamed(context, '/location');
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
                  Text(
                    dateProvider.time,
                    style: TextStyle(fontSize: 66),
                  )
                ],
              ),
            ),
          )),
        );
      }
    });
  }
}
