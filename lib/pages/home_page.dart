import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // api key
  final _weatherService = WeatherService("0a24bc171246be68c21cdc135f97dbdc");

  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    // get the current city
    String cityName = await _weatherService.getCurrentCity();
    // get weather for city

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    // any error

    catch (error) {
      print("Error fetching weather: $error");
    }
  }

  // weather animation
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null || mainCondition.isEmpty) {
      return 'assets/sunny.json';
    }
    String condition = mainCondition.toLowerCase();
    if (condition.contains('cloud')) return 'assets/cloud.json';
    if (condition.contains('mist') || condition.contains('fog')) {
      return 'assets/cloud.json';
    }
    if (condition.contains('smoke') ||
        condition.contains('haze') ||
        condition.contains('dust')) {
      return 'assets/cloud.json';
    }
    if (condition.contains('rain') || condition.contains('drizzle')) {
      return 'assets/rain.json';
    }
    if (condition.contains('thunder')) return 'assets/thunder.json';
    if (condition.contains('clear')) return 'assets/sunny.json';

    return 'assets/sunny.json';
  }

  // init state
  @override
  void initState() {
    super.initState();

    // fetch weather when the app loads
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 56, 38, 50),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SafeArea(
            child: Center(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on, size: 20, color: Colors.white),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          _weather?.cityName ?? "Loading City..",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // ############### WEATHER ANIMATION HERE ###############
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Lottie.asset(
                          getWeatherAnimation(_weather?.mainCondition),
                          height: 200,
                          width: 200),
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Text(
                        _weather != null
                            ? '${_weather!.temperature.round()}°C'
                            : 'Loading...',
                        style: TextStyle(
                            fontSize: 80,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 70,
                  // ),

                  // ##### commenting for testing purposes
                  Expanded(
                    flex: 1,
                    child: Text(""),
                  ),

                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          // feels like
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Text(
                                _weather != null
                                    ? "Feels like: ${_weather!.feelsLike.toStringAsFixed(1)}°C"
                                    : "Loading...",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),

                          // min and max temp
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _weather != null
                                      ? "Min temp ${_weather!.minTemperature}°"
                                      : "Loading...",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                                Text(
                                  _weather != null
                                      ? "Min temp ${_weather!.maxTemperature}°"
                                      : "Loading...",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   height: 10,
                          // ),

                          //pressure
                          Expanded(
                            flex: 1,
                            child: Text(
                              "${_weather?.pressure} hPa",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),

                          // humidity
                          Expanded(
                            flex: 1,
                            child: Text(
                              "${_weather?.humidity} %",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ),
                          // SizedBox(
                          //   height: 10,
                          // ),

                          // wind speed and degree in a row
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Wind speed ${_weather?.windSpeed}",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                                Text(
                                  "${_weather?.winDegree} deg winD",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          // SizedBox
                         SizedBox(
                            height: 5,
                          ),
                          Expanded(child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Made with ❤️ by ", style: TextStyle(color: Colors.white),),
                              Text("Nishan", style: TextStyle(color: Colors.blue),)
                            ],
                          ))
                        ],
                      ),
                    ),
                  ),

                  // #### end of commenting

                  // current time and date

                  // sunrise and sunset

                  // city name

                  // weather animation

                  // SizedBox(
                  //   height: 60,
                  // ),

                  // temperature

                  // SizedBox(
                  //   height: 20,
                  // ),

                  // weather condition
                  // Text(_weather?.mainCondition ?? "")
                ],
              ),
            ),
          ),
        ));
  }
}
