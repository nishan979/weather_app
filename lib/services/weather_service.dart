import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_model.dart';

class WeatherService {
  static const String baseUrl =
      "https://api.openweathermap.org/data/2.5/weather";
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final response =
        //await http.get(Uri.parse('$BASE_URL?q=$cityName&apiKey&units=metric'));
        await http
            .get(Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch weather data");
    }
  }

  Future<String> getCurrentCity() async {
    // get permission from user
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // fetch the current location
    Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100, // in meters
    ));
    // desiredAccuracy: LocationAccuracy.high,
    // timeLimit: Duration(seconds: 5));

    // convert the location into a list of placemark objects
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    // extract the current city from the first placemark
    String? city = placemarks[0].locality;

    return city ?? "";
  }
}
