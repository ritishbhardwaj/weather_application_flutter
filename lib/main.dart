


import 'package:flutter/material.dart';
import 'package:weather_application/screens/splash_screens.dart';

void main(){
  runApp(WeatherApp());
}


class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: SplashScreen(),

    );
  }
}