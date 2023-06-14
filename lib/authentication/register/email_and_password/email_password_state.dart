import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class EmailPasswordState extends Equatable {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isUserRegisteredSuccess;
  final bool showPassword;


  @override
  List<Object?> get props => [showPassword,emailController,passwordController,isUserRegisteredSuccess];

  const EmailPasswordState({

    this.showPassword=true,
    this.isUserRegisteredSuccess=false,
    required this.emailController,
    required this.passwordController,

  });

  EmailPasswordState copyWith({
    TextEditingController? emailController,
    TextEditingController? passwordController,
    bool? isUserRegisteredSuccess,
    bool? showPassword,

  }) {
    return EmailPasswordState(
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      isUserRegisteredSuccess: isUserRegisteredSuccess ?? this.isUserRegisteredSuccess,
      showPassword: showPassword ?? this.showPassword,
    );
  }
}