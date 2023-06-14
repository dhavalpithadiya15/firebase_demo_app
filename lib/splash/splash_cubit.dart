
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../splash/splash_state.dart';
class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState()){
    onSplashInit();
  }

  Future<void> onSplashInit() async {
    SplashState.preferences = await SharedPreferences.getInstance();
    bool? temp = SplashState.preferences.getBool("showOnboard")??true;
    bool? tempLoginSuccess = SplashState.preferences.getBool("loginSuccess")??false;
    emit(state.copyWith(showOnboard: temp,loginSuccess: tempLoginSuccess));

    print("${state.loginSuccess}${state.showOnboard}");


  }
}