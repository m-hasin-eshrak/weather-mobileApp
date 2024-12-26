// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:weather_today_completed/utils/constants.dart';

import '../services/network.dart';
import 'location_screen.dart';


class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  late String cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'images/ic_back.png',
                      width: 32.0,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 24.0,
                ),
                child: TextField(
                  style: TextStyle(
                    fontFamily: 'Museo Moderno',
                    color: Colors.black,
                  ),
                  decoration: kTextFieldInputDecoration,
                  onChanged: (value) {
                    cityName = value;
                  },
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                ),
                onPressed: () async {
                  // Display loading screen while fetching data
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    barrierDismissible: false,
                  );

                  Future<dynamic> getCityWeatherByName(String cityName) async {
                  final String weatherUrl =
                  "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=a9dd8870cf48aa5ab2ee14e1e6ce2c93&units=metric";

                  NetworkHelper networkHelper = NetworkHelper('$weatherUrl');
                  return await networkHelper.getData();
                  }

                  // Fetch weather data for the entered city
                  var weatherData = await getCityWeatherByName(cityName);

                  // Dismiss the loading screen
                  Navigator.pop(context);

                  // Navigate to LocationScreen with the new weather data
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LocationScreen(
                          locationWeather: weatherData,
                          cityName: cityName,
                        );
                      },
                    ),
                  );
                  // RRRRRRRRRRRRRRRRR
                  // Navigator.pop(context, cityName);
                },

                child: Text(
                  'Search Weather',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

