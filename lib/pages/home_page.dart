import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    DateTime now = DateTime.now();
    String shortMonth = DateFormat('MMM').format(now);
    String dayOfWeek = DateFormat('EEEE').format(now);

    return Scaffold(
      // background color for gif
      // backgroundColor: Colors.black.withOpacity(0.5),

      // background color for solid color

      backgroundColor: const Color.fromARGB(255, 15, 84, 153),

      // body: Stack(
      //   children: [
      //     const VideoBackground(),
      //     Align(
      //       alignment: Alignment.center,
      //       child: bodyPart()),
      //   ],
      // ),

      //IMAGE CHECKS
      // for gif or image in the background
      // body: Container(
      //   decoration: BoxDecoration(
      //     image: DecorationImage(

      //       image: AssetImage("assets/gif/storm.gif"),
      //       fit: BoxFit.cover,
      //       opacity: 0.5,
      //       colorFilter: ColorFilter.mode(
      //           const Color.fromARGB(255, 1, 7, 44).withValues(alpha: 0.8),
      //           BlendMode.dstATop),
      //     ),
      //   ),
      //   child: Align(
      //     alignment: Alignment.center,
      //     child: bodyPart(),
      //   ),
      // ),

      body: bodyPart2(),
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
  //

  bodyPart2() {
    return Column(
      children: [
        // 70% of heifht is green and 30% is white
        Expanded(
          flex: 7,
          child: Container(
            color: Colors.green,
            child: Column(
              children: [
                // city name on the top left corner
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
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

                // today date and time under the  city name
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, size: 13, color: Colors.white),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        "Today,  ${DateTime.now().hour}:${DateTime.now().minute}",
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                //big lottie animation
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Lottie.asset(
                        getWeatherAnimation(_weather?.mainCondition),
                        height: 300,
                        width: 300),
                  ),
                ),
                // temperature on the left bottom corner
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: Text(
                      _weather != null
                          ? '${_weather!.temperature.round()}°'
                          : 'Loading...',
                      style: TextStyle(
                          fontSize: 85,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                // weather conditions under the temperature on the left bottom corner and add something to the right bottom corner
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _weather != null
                            ? _weather!.mainCondition
                            : 'Loading...',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "NISHAN",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // 30% of height is white which can be scroll up
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                // top left text weather now
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.wb_sunny, size: 13, color: Colors.black),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        "Weather Now",
                        style: TextStyle(fontSize: 17, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                // on the first line there will be 'C icon and feels like weather on the top left corner and on the right there will be wind with same style.. and on the second line there will be min and max temp on the left and pressure on the right
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // icon and feels like
                        Row(
                          children: [
                            Icon(Icons.wb_sunny, size: 20, color: Colors.black),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              "Feels Like: ${_weather?.feelsLike.round()}°C",
                              style: TextStyle(fontSize: 17, color: Colors.black),
                            ),
                          ],
                        ),
                        // wind
                        Row(
                          children: [
                            Icon(Icons.directions, size: 20, color: Colors.black),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              "Wind: ${_weather?.windSpeed.round()} km/h",
                              style: TextStyle(fontSize: 17, color: Colors.black),
                            ),
                          ],
                        ),
                        
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

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

              // ############### WEATHER DETAILS HERE ###############
              // ############### main temperature start ###############
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
              // ############### main temperature end ###############
              // ### main city start
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
              // ### main city end

              /// ### gap start
              Expanded(
                flex: 1,
                child: Text(""),
              ),
              // ### gap end
              // ### weather description start
              //weatherDescription(),
            ],
          ),
        ),
      ),
    );
  }

  Expanded weatherDescription() {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // feels like
            Container(
              height: 30,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Expanded(
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
            ),
            SizedBox(
              height: 5,
            ),

            // min and max temp
            Container(
              height: 25,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _weather != null
                            ? "Min temp ${_weather!.minTemperature}°"
                            : "Loading...",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      Text(
                        _weather != null
                            ? "${_weather!.maxTemperature}° temp maX"
                            : "Loading...",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //pressure
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Expanded(
                flex: 1,
                child: Text(
                  "${_weather?.pressure} hPa",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),

            // humidity
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Expanded(
                flex: 1,
                child: Text(
                  "${_weather?.humidity} %",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),

            // wind speed and degree in a row
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Wind speed ${_weather?.windSpeed}",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    Text(
                      "${_weather?.winDegree} deg winD",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
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
    );
  }
}
