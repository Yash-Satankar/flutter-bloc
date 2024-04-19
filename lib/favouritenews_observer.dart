import 'dart:developer';

import 'package:bloc/bloc.dart';

class FavouriteNewsObserver extends BlocObserver {
  const FavouriteNewsObserver();

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    log('${bloc.runtimeType} $change');
  }
}
