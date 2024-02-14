import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key, required this.weather, required this.temperature});

  final String weather;
  final String temperature;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Text(weather),
        Text(temperature),

      ]),
    );
  }
}