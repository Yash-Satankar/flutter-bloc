import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_weather/news/news.dart';
import 'package:news_weather/weather/cubit/weather_cubit.dart';

class CityName extends StatefulWidget {
  const CityName({super.key});

  @override
  State<CityName> createState() => _CityNameState();
}

TextEditingController cityName = TextEditingController();

class _CityNameState extends State<CityName> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("City Name"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Text(
              "Your city name",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                controller: cityName,
              ),
            ),
            BlocBuilder<WeatherCubit, String>(
              builder: (context, state) {
                return ElevatedButton(
                    onPressed: () {
                      context.read<WeatherCubit>().getWeather(cityName.text);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsView(
                            cityname: cityName.text,
                          ),
                        ),
                      );
                    },
                    child: Text("Submit"));
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsView(
                      cityname: cityName.text,
                    ),
                  ),
                );
              },
              child: Text("Skip"),
            ),
          ],
        ),
      ),
    );
  }
}
