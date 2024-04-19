import 'dart:developer';

import 'package:bloc/bloc.dart';

class NewsObserver extends BlocObserver {
  const NewsObserver();

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    log('${bloc.runtimeType} $change');
  }
}
