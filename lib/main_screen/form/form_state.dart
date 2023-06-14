import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../modal/hobbies_modal.dart';

class MyFormState extends Equatable {
  final TextEditingController nameController;
  final TextEditingController numberController;
  final TextEditingController emailController;
  final TextEditingController addressController;
  final TextEditingController pinCodeController;
  final TextEditingController dateOfBirthController;
  final String selectedCountry;
  final String selectedState;
  final String countryCode;
  final String completeNumber;
  final List<String> genderList;
  final String selectedGender;
  final String selectedCity;
  final String selectedDate;
  final List<Hobbies> checkListItems;
  final List<Map<String, dynamic>> selectedCheckListItems;

  @override
  List<Object?> get props => [
        checkListItems,
        selectedDate,
        genderList,
        selectedGender,
        countryCode,
        completeNumber,
        selectedCountry,
        selectedState,
        selectedCity,
        selectedCheckListItems,
      ];

  const MyFormState({
    required this.emailController,
    this.completeNumber = "",
    this.checkListItems = const [],
    this.countryCode = "",
    required this.numberController,
    this.selectedGender = "male",
    required this.nameController,
    this.genderList = const [],
    required this.addressController,
    required this.pinCodeController,
    this.selectedState = "",
    this.selectedCountry = "",
    this.selectedCity = "",
    this.selectedDate = "",
    this.selectedCheckListItems = const [],
    required this.dateOfBirthController,
  });

  MyFormState copyWith({
    TextEditingController? nameController,
    TextEditingController? numberController,
    TextEditingController? emailController,
    TextEditingController? addressController,
    TextEditingController? pinCodeController,
    TextEditingController? dateOfBirthController,
    String? selectedCountry,
    String? selectedState,
    String? countryCode,
    String? completeNumber,
    List<String>? genderList,
    String? selectedGender,
    String? selectedCity,
    String? selectedDate,
    List<Hobbies>? checkListItems,
    List<Map<String, dynamic>>? selectedCheckListItems,
  }) {
    return MyFormState(
      nameController: nameController ?? this.nameController,
      numberController: numberController ?? this.numberController,
      emailController: emailController ?? this.emailController,
      addressController: addressController ?? this.addressController,
      pinCodeController: pinCodeController ?? this.pinCodeController,
      dateOfBirthController: dateOfBirthController ?? this.dateOfBirthController,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedState: selectedState ?? this.selectedState,
      countryCode: countryCode ?? this.countryCode,
      completeNumber: completeNumber ?? this.completeNumber,
      genderList: genderList ?? this.genderList,
      selectedGender: selectedGender ?? this.selectedGender,
      selectedCity: selectedCity ?? this.selectedCity,
      selectedDate: selectedDate ?? this.selectedDate,
      checkListItems: checkListItems ?? this.checkListItems,
      selectedCheckListItems: selectedCheckListItems ?? this.selectedCheckListItems,
    );
  }
}
