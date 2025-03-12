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
      
      backgroundColor: Colors.black.withOpacity(0.5),
      // body: Stack(
      //   children: [
      //     const VideoBackground(),
      //     Align(
      //       alignment: Alignment.center,
      //       child: bodyPart()),
      //   ],
      // ),

      //IMAGE CHECKS


      body: Container(
        
        decoration: BoxDecoration(
          image: DecorationImage(
            // add blur in image

            image: AssetImage("assets/gif/storm.gif"),
            fit: BoxFit.cover,
            opacity: 0.5,
            colorFilter: ColorFilter.mode(
                const Color.fromARGB(255, 1, 7, 44).withOpacity(0.5), BlendMode.dstATop),
          ),

        ),
        
        child: Align(
          alignment: Alignment.center,
          child: bodyPart(),
        ),
      ),
    );
  }
 
 //FOR TESTING ONLY
  // Padding bodyPart() {
  //   return Padding(
  //     padding: const EdgeInsets.all(5.0),
  //     child: SafeArea(
  //       child: Center(
  //         child: Text("Dhakkitiki"),
  //       ),
  //     ),
  //   );
  // }

  

   Padding bodyPart() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SafeArea(
        
        child: Center(
          
          child: Column(
           
            children: [
              
              // ############### WEATHER ANIMATION HERE ###############
              Expanded(
                flex: 2,
                child: Center(
                  child: Lottie.asset(
                      getWeatherAnimation(_weather?.mainCondition),
                      height: 300,
                      width: 300),
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
                        fontSize: 85,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on, size: 13, color: Colors.white),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      _weather?.cityName ?? "Loading City..",
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  ],
                ),
              ),

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
                            style: TextStyle(fontSize: 14, color: Colors.white),
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
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            Text(
                              _weather != null
                                  ? "${_weather!.maxTemperature}° temp maX"
                                  : "Loading...",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ],
                        ),
                      ),

                      //pressure
                      Expanded(
                        flex: 1,
                        child: Text(
                          "${_weather?.pressure} hPa",
                          style: TextStyle(fontSize: 14, color: Colors.white),
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
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),

                      // wind speed and degree in a row
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Wind speed ${_weather?.windSpeed}",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            Text(
                              "${_weather?.winDegree} deg winD",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 2,
                            )
                          ],
                        ),
                        child: Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Text(
                              //   "Made with ❤️ by ",
                              //   style: TextStyle(color: Colors.white),
                              // ),
                              Text(
                                "NISHAN",
                                style: TextStyle(color: Colors.blue),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


