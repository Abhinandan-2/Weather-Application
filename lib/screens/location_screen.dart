import 'package:flutter/material.dart';
import 'package:climate_app/utilities/constants.dart';
import 'package:climate_app/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  @override
  final locationData;

  LocationScreen({this.locationData});

  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  WeatherModel weatherModel = WeatherModel();

  int? temperature;
  String? weatherIcon;
  String? message;
  String? name;

  void initState() {
    super.initState();
    updateUI(widget.locationData);
  }

  void updateUI(dynamic weatherData) {
    setState(
      () {
        if (weatherData == null) {
          temperature = 0;
          weatherIcon = 'Error';
          message = 'Enable to get weather data';
          name = '';
          return;
        }
        var id = weatherData['weather'][0]['id'];
        double temp = weatherData['main']['temp'];
        temperature = temp.toInt();
        name = weatherData['name'];
        weatherIcon = weatherModel.getWeatherIcon(id);
        message = weatherModel.getMessage(temperature!);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weatherModel.getLoctionWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if (typedName != null) {
                        var weatherData =
                            await weatherModel.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon!,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$message in $name!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
