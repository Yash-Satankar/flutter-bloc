import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_weather/favouritenews_observer.dart';
import 'package:news_weather/news/news.dart';
import 'package:news_weather/signUp/view/sign_up_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'FavouriteNews/cubit/favourite_news_cubit.dart';
import 'news/cubit/nav_cubit.dart';
import 'news_observer.dart';
import 'signUp/cubit/sign_up_cubit.dart';
import 'weather/cubit/weather_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var name = prefs.getString("name");
  Bloc.observer = NewsObserver();
  Bloc.observer = FavouriteNewsObserver();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<FavouriteNewsCubit>(
          create: (context) => FavouriteNewsCubit(),
        ),
        BlocProvider<NewsCubit>(
          create: (context) => NewsCubit(),
        ),
        BlocProvider<NavBarCubit>(
          create: (context) => NavBarCubit(),
        ),
        BlocProvider<WeatherCubit>(
          create: (context) => WeatherCubit(),
        ),
        BlocProvider<SignUpCubit>(
          create: (context) => SignUpCubit(),
        ),
      ],
      child: AdaptiveTheme(
        light: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          colorSchemeSeed: Colors.blue,
        ),
        dark: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          colorSchemeSeed: Colors.blue,
        ),
        initial: savedThemeMode ?? AdaptiveThemeMode.light,
        builder: (theme, darkTheme) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          darkTheme: darkTheme,
          home: name == null
              ? SignUpScreen()
              : NewsView(
                  cityname: '',
                ),
        ),
        debugShowFloatingThemeButton: false,
      ),
    ),
  );
}
