import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
   WeatherScreen({super.key, required this.weather, required this.temperature});

  final String weather;
  final String temperature;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final cityNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: cityNameController,
              ),
            ),
          Text(widget.weather),
          Text(widget.temperature),
          ElevatedButton(
            onPressed: () {
              print(cityNameController.text);
            }, 
            child:Text("Print City Name") ),
        
        ]),
      ),
    );
  }
}