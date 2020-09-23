import 'package:flutter/material.dart';
import 'package:weather_app/models/CountryItem.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<CountryItem> locations = [
    CountryItem(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    CountryItem(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    CountryItem(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    CountryItem(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    CountryItem(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    CountryItem(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    CountryItem(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    CountryItem(
        url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text("choose a location"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
            onTap: () {
              Navigator.popAndPushNamed(context, '/', arguments: {
                'city': locations[index].location,
                'location': locations[index].url,
              });
            },
            title: Text(
              locations[index].location,
            ),
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/${locations[index].flag}'),
            ),
          ));
        },
      ),
    );
  }
}
