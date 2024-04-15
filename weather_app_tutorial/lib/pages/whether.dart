import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_app_tutorial/consts.dart';

class WhetherPage extends StatefulWidget {
  const WhetherPage({super.key});

  @override
  State<WhetherPage> createState() => _WhetherPageState();
}

class _WhetherPageState extends State<WhetherPage> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);

  Weather? _currentWeather;
  List<Weather>? _forecast;

//initState
  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    final currentWeather = await _wf.currentWeatherByCityName("Pune");
    final forecast = await _wf.fiveDayForecastByCityName("Pune");
    setState(() {
      _currentWeather = currentWeather;
      _forecast = _filterForecast(forecast);
    });
  }

  List<Weather> _filterForecast(List<Weather> forecast) {
    final Map<int, Weather> filteredForecast = {};
    forecast.forEach((weather) {
      final day = weather.date!.day;
      if (!filteredForecast.containsKey(day)) {
        filteredForecast[day] = weather;
      }
    });
    return filteredForecast.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Whether",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    if (_currentWeather == null || _forecast == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _locationHeader(_currentWeather!.areaName ?? ""),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          _dateTimeInfo(_currentWeather!.date!),
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.05,
          // ),
          _weatherIcon(_currentWeather!.weatherIcon,
              _currentWeather!.weatherDescription),
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.02,
          // ),
          _currentTemp(
              _currentWeather!.temperature!.celsius!.toStringAsFixed(0)),
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.00,
          // ),
          _extraInfo(_currentWeather!),
          _buildForecast(_forecast!),
        ],
      ),
    );
  }

  Widget _locationHeader(String areaName) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        areaName,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _dateTimeInfo(DateTime date) {
    return Column(
      children: [
        Text(
          DateFormat("h:mm a").format(date),
          style: const TextStyle(
            fontSize: 35,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "${DateFormat("EEEE").format(date)}, ${DateFormat("d.M.y").format(date)}",
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget _weatherIcon(String? icon, String? description) {
    return Column(
      children: [
        Image.network(
          "http://openweathermap.org/img/wn/$icon@4x.png",
          height: 200,
          width: 200,
          errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
        ),
        Text(
          description ?? "",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget _currentTemp(String temp) {
    return Text(
      "$temp° C",
      style: const TextStyle(
        color: Colors.black,
        fontSize: 90,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _extraInfo(Weather weather) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Max: ${weather.tempMax!.celsius!.toStringAsFixed(0)}° C",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              Text(
                "Min: ${weather.tempMin!.celsius!.toStringAsFixed(0)}° C",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Wind: ${weather.windSpeed!.toStringAsFixed(0)} m/s",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              Text(
                "Humidity: ${weather.humidity!.toStringAsFixed(0)}%",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildForecast(List<Weather> forecast) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: forecast.length,
        itemBuilder: (context, index) {
          final day = forecast[index];
          return _buildForecastItem(day);
        },
      ),
    );
  }

  Widget _buildForecastItem(Weather day) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        padding: const EdgeInsets.all(8),
        width: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              DateFormat("EEEE").format(day.date!),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Image.network(
              "http://openweathermap.org/img/wn/${day.weatherIcon}@2x.png",
              height: 40,
              width: 40,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
            ),
            Text(
              "${day.temperature!.celsius!.toStringAsFixed(0)}° C",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
