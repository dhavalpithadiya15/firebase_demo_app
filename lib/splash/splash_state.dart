import 'package:shared_preferences/shared_preferences.dart';

class SplashState {
  static late final SharedPreferences preferences;
  final bool showOnboard;
  final bool loginSuccess;

  const SplashState({
    this.showOnboard=true,
    this.loginSuccess=false,
  });

  SplashState copyWith({
    bool? showOnboard,
    bool? loginSuccess,
  }) {
    return SplashState(
      showOnboard: showOnboard ?? this.showOnboard,
      loginSuccess: loginSuccess ?? this.loginSuccess,
    );
  }
}