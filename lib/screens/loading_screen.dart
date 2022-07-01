import 'package:climate_app/services/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // LocationPermission permission = await Geolocator.requestPermission();
  //LocationPermission permission = await Geolocator.checkPermission();
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurLocation();
    print(location.laongitude);
    print(location.latitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            print('Pressed.....\n');
            // getLocation();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
