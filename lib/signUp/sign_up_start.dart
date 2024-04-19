import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_weather/signUp/cubit/sign_up_cubit.dart';
import 'package:news_weather/signUp/view/sign_up_screen.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (context) => SignUpCubit(),
      child: SignUpScreen(),
    );
  }
}
