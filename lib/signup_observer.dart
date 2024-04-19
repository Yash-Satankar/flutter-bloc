import 'dart:developer';

import 'package:bloc/bloc.dart';

class SignUpObserver extends BlocObserver {
  const SignUpObserver();

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    log('${bloc.runtimeType} $change');
  }
}
