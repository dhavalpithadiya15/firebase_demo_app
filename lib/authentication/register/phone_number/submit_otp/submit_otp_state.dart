import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class SubmitOtpState extends Equatable{

  final TextEditingController submitOtpController;
  final bool submitOtpSuccess;

  @override
  List<Object?> get props => [submitOtpSuccess];

  const SubmitOtpState({
    required this.submitOtpController,
    this.submitOtpSuccess=false,
  });

  SubmitOtpState copyWith({
    TextEditingController? submitOtpController,
    bool? submitOtpSuccess,
  }) {
    return SubmitOtpState(
      submitOtpController: submitOtpController ?? this.submitOtpController,
      submitOtpSuccess: submitOtpSuccess ?? this.submitOtpSuccess,
    );
  }
}