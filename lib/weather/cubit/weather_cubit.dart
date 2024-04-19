import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WeatherCubit extends Cubit<String> {
  WeatherCubit() : super('');

  Future<void> getWeather(String cityName) async {
    try {
      final response = await http.get(Uri.parse(
          'http://api.weatherapi.com/v1/current.json?key=ab84e46f1800404ca33103611241504&q=${cityName}&aqi=no'));
      if (response.statusCode == 200) {
        final weatherData = jsonDecode(response.body);
        final temperature = weatherData['current']['temp_c'];
        emit('$temperature °C');
        _storeCityName(cityName);
      } else {
        emit('');
      }
    } catch (e) {
      emit('Error: $e');
    }
  }

  Future<void> _storeCityName(String cityName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('cityName', cityName);
  }

  Future<String?> getSavedCityName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('cityName');
  }
}
