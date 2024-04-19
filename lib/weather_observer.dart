import 'dart:developer';

import 'package:bloc/bloc.dart';

class WeatherObserver extends BlocObserver {
  const WeatherObserver();

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    log('${bloc.runtimeType} $change');
  }
}
