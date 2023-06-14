import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class LoginState extends Equatable {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool showPassword;
  final bool isUserLoginSuccess;

  @override
  List<Object?> get props => [emailController,passwordController,showPassword,isUserLoginSuccess];

  const LoginState({
    this.showPassword=true,
    required this.emailController,
    required this.passwordController,
    this.isUserLoginSuccess=false,
  });

  LoginState copyWith({
    TextEditingController? emailController,
    TextEditingController? passwordController,
    bool? showPassword,
    bool? isUserLoginSuccess,
  }) {
    return LoginState(
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      showPassword: showPassword ?? this.showPassword,
      isUserLoginSuccess: isUserLoginSuccess ?? this.isUserLoginSuccess,
    );
  }
}
