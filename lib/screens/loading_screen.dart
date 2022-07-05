import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'location_screen.dart';
import 'package:flutter/material.dart';
import 'package:climate_app/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? longitude;
  double? latitude;

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getLoctionWeather();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationData: weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDancingSquare(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
