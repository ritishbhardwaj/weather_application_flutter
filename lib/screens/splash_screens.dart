  import 'dart:convert';
import 'dart:developer';
import 'dart:js_interop';

import 'package:geolocator/geolocator.dart';
  // Weather API key - c6ffee661d487dae28b7f3244285f579

import 'package:flutter/material.dart';


import 'package:http/http.dart' as http;
import 'package:weather_application/constants.dart';
import 'package:weather_application/screens/weather_screen.dart';

class SplashScreen extends StatefulWidget {
   SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _determinePosition().then((position){

       getWeaher(lat: position.latitude , long: position.longitude);
    } ).catchError((e){
      log(e.toString());
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Center(
            child: CircularProgressIndicator(color: Colors.red,backgroundColor: Colors.yellow,)
          ),
      ),
    );
  }


/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> _determinePosition() async {

  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  

  //Ye khud likhna Parhega :))))
  final position = await Geolocator.getCurrentPosition();
  log(position.toString());
  return position;
  
}
Future<void> getWeaher({required double lat , required double long}) async{
  final url= 'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$API_KEY';

  final response= await http.get(Uri.parse(url));

  if (response.statusCode==200){
  final decodedResponse = json.decode(response.body);
  log(decodedResponse.toString());
  final weather = decodedResponse['weather'][0]['main'];
  final temp = decodedResponse['main']['temp'];
  log(weather.toString());
  final cal = (temp - 273); 
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => WeatherScreen(weather: weather, temperature: cal.toStringAsFixed(2))));
}
  // log(response.body.toString());  

}

}