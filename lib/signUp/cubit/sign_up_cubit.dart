import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<AuthState> {
  SignUpCubit() : super(InitialState());

  void signUp(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    emit(AuthenticatedState(name));
  }

  void getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name') ?? '';
    emit(AuthenticatedState(name));
  }
}
