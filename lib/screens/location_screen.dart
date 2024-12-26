import 'package:flutter/material.dart';
import 'package:weather_today_completed/utils/constants.dart';
import '../utils/custom_paint.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({required this.locationWeather, required this.cityName});

  final locationWeather;
  final String cityName;

  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {

  String cityName = "Dhaka";

  int temperature = 0;
  int minTemperature = 0;
  int maxTemperature = 0;
  double windSpeed = 0.0;
  int humidity = 0;

  // late String cityName;
  // LocationScreenState(this.cityName);

  // String cityName = "Dhaka";

  @override
  void initState() {
    super.initState();

    // cityName = widget.cityName; // Set the cityName from the parameter
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();

      // Add the following lines to extract additional information
      double minTemp = weatherData['main']['temp_min'];
      double maxTemp = weatherData['main']['temp_max'];
      double wind = weatherData['wind']['speed'].toDouble();
      int humidityPercentage = weatherData['main']['humidity'];

      minTemperature = minTemp.toInt();
      maxTemperature = maxTemp.toInt();
      windSpeed = wind;
      humidity = humidityPercentage;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.09),
              BlendMode.darken,
            ),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 16.0),
              Padding(
                padding: EdgeInsets.only(
                  top: 24,
                  left: 16.0,
                  right: 16.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '$temperature°',
                        style: kTempTextStyle,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        // final selectedCityName = await Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return CityScreen();
                        //     },
                        //   ),
                        // );
                        //
                        // if (selectedCityName != null &&
                        //     selectedCityName is String) {
                        //   setState(() {
                        //     cityName = selectedCityName;
                        //   });
                        //   //use city name
                        // }
                        // Navigator.pop(context, cityName);
                      },
                      child: Image.asset(
                        'images/ic_current_location.png',
                        width: 32.0,
                      ),
                    ),
                    SizedBox(width: 24.0),
                    GestureDetector(
                      onTap: () async {
                        final selectedCityName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CityScreen();
                            },
                          ),
                        );

                        if (selectedCityName != null &&
                            selectedCityName is String) {
                          setState(() {
                            cityName = selectedCityName;
                          });

                          // Navigator.pop(context, cityName);
                        }
                        Navigator.pop(context, cityName);
                      },
                      child: Image.asset(
                        'images/ic_search.png',
                        width: 32.0,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 16.0),
                    Image.asset(
                      'images/ic_location_pin.png',
                      width: 24.0,
                      height: 24.0,
                    ),
                    SizedBox(width: 10),
                    Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Text(
                        cityName,
                        textAlign: TextAlign.center,
                        style: kSmallTextStyle.copyWith(
                          fontSize: 16.0,
                          color: Colors.black45,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 190,
                child: CustomPaint(
                  painter: MyCustomPaint(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 24.0,
                          bottom: 24.0,
                        ),
                        child: Text(
                          'Weather Today',
                          style: kConditionTextStyle.copyWith(fontSize: 16.0),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ConditionRow(
                            icon: 'images/ic_temp.png',
                            title: 'Min Temp',
                            value: '$minTemperature°',
                          ),
                          ConditionRow(
                            icon: 'images/ic_wind_speed.png',
                            title: 'Wind Speed',
                            value: '${windSpeed.toStringAsFixed(1)} Km/h',
                          ),
                          ConditionRow(
                            icon: 'images/ic_temp.png',
                            title: 'Max Temp',
                            value: '$maxTemperature°',
                          ),
                          ConditionRow(
                            icon: 'images/ic_humidity.png',
                            title: 'Humidity',
                            value: '$humidity%',
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ConditionRow extends StatelessWidget {
  final String icon;
  final String title;
  final String value;

  const ConditionRow({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          icon,
          width: 24.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          child: Text(
            title,
            style: kConditionTextStyleSmall,
          ),
        ),
        Text(
          value,
          style: kConditionTextStyle,
        ),
      ],
    );
  }
}
