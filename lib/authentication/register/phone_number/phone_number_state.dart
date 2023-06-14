import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneNumberState extends Equatable {
  final TextEditingController numberController;
  final String countryCode;
  final String completeNumber;
  final GlobalKey<FormState> formKey;
  final bool otpSendSuccess;
  final String verificationId;
  @override
  List<Object?> get props => [numberController, countryCode, completeNumber,otpSendSuccess,verificationId];

  const PhoneNumberState({
    this.otpSendSuccess=false,
    required this.formKey,
    required this.numberController,
    this.countryCode = '+91',
    this.completeNumber = '',
    this.verificationId='',

  });

  PhoneNumberState copyWith({
    TextEditingController? numberController,
    String? countryCode,
    String? completeNumber,
    MaskTextInputFormatter? maskTextInputFormatter,
    GlobalKey<FormState>? formKey,
    bool? otpSendSuccess,
    String? verificationId,
  }) {
    return PhoneNumberState(
      numberController: numberController ?? this.numberController,
      countryCode: countryCode ?? this.countryCode,
      completeNumber: completeNumber ?? this.completeNumber,
      formKey: formKey ?? this.formKey,
      otpSendSuccess: otpSendSuccess ?? this.otpSendSuccess,
      verificationId: verificationId ?? this.verificationId,
    );
  }
}