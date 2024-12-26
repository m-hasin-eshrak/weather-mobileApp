import 'package:flutter/material.dart';
import '../services/network.dart';
import 'location_screen.dart';
import '../services/location.dart'; // Import the Location class
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  final dynamic locationWeather;

  LoadingScreen({required this.locationWeather});

  @override
  State<StatefulWidget> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();

    // var weatherData;

    try {
      // Fetch weather data using the current location
      var weatherData = await getCityWeather(location.latitude, location.longitude);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LocationScreen(
              locationWeather: weatherData, cityName: '',
            );
          },
        ),
      );
    } catch (e) {
      // Handle errors (e.g., no internet connection, API request failure)
      print('Error: $e');
    }
  }

  //method to get Dhaka weather
  Future<dynamic> getCityWeather(double lat, double lon) async {
    final String weatherUrl =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=a9dd8870cf48aa5ab2ee14e1e6ce2c93&units=metric";

    NetworkHelper networkHelper = NetworkHelper('$weatherUrl');
    return await networkHelper.getData();
  }

  Future<dynamic> getCityWeatherByName(String cityName) async {
    final String weatherUrl =
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=a9dd8870cf48aa5ab2ee14e1e6ce2c93&units=metric"; // Replace 'YOUR_API_KEY' with your OpenWeatherMap API key

    NetworkHelper networkHelper = NetworkHelper('$weatherUrl');
    return await networkHelper.getData();
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
        child: Center(
          child: SpinKitDoubleBounce(
            color: Colors.white,
            size: 100.0,
          ),
        ),
      ),
    );
  }
}
