import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo_app/main_screen/form/form_state.dart';
import 'package:firebase_demo_app/modal/form_modal.dart';
import 'package:firebase_demo_app/modal/user_modal.dart';
import 'package:firebase_demo_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import '../../modal/hobbies_modal.dart';

class MyFormCubit extends Cubit<MyFormState> {
  MyFormCubit()
      : super(
          MyFormState(
            nameController: TextEditingController(),
            numberController: TextEditingController(),
            emailController: TextEditingController(),
            addressController: TextEditingController(),
            pinCodeController: TextEditingController(),
            dateOfBirthController: TextEditingController(),
          ),
        ) {
    addGenderList();
    addItemsToCheckList();

    print("FORM CUBIT CALLED");
  }

  void addGenderList() {
    List<String> tempGenderList = List.from(state.genderList);
    tempGenderList = ["male", "female"];
    emit(state.copyWith(genderList: tempGenderList));
  }

  void genderOnChange(String gender) {
    emit(state.copyWith(selectedGender: gender));
    print(state.selectedGender);
  }

  Future<void> fillData() async {
    EasyLoading.show();
    QuerySnapshot<Map<String, dynamic>> querySnapShot =
        await FirebaseFirestore.instance.collection("users_data").where("uid", isEqualTo: FirebaseAuth.instance.currentUser?.uid).get();
    querySnapShot.docs.map((e) => e.data()).toList().forEach((element) {
      state.nameController.text = element['name'];
      state.numberController.text = element['phoneNumber'];
      state.emailController.text = element['email'];
    });
    EasyLoading.dismiss();
    print(state.nameController.text);
  }

  Future<void> editData(String documentId) async {
    print("===$documentId");
    QuerySnapshot<Map<String, dynamic>> querySnapShot =
        await FirebaseFirestore.instance.collection("form_data").where("documentId", isEqualTo: documentId).get();
    querySnapShot.docs.map((e) => e.data()).toList().forEach((element) {
      state.nameController.text = element['name'];
      state.numberController.text = element['phoneNumber'];
      state.emailController.text = element['email'];
      state.dateOfBirthController.text = element['dateOfBirth'];
      List<Hobbies> temList = List.from(state.checkListItems);
      List<Map<String, dynamic>> list = element['hobbies'].cast<Map<String, dynamic>>();
      state.pinCodeController.text = element['address']['pinCode'];
      state.addressController.text = element['address']['addressLine'];
      for (var i in list) {
        var index = temList.indexWhere((temListElement) => temListElement.tittle == i['tittle']);
        temList[index] = temList[index].copyWith(isSelected: true);
      }
      print(element['address']['state']);
      emit(
        state.copyWith(
            selectedGender: element['gender'],
            checkListItems: temList,
            selectedCountry: element['address']['country'],
            selectedState: element['address']['state'],
            selectedCity: element['address']['city']),
      );
    });
  }

  void onChangeCountryCode(CountryCode value) {
    emit(state.copyWith(countryCode: value.dialCode));
    print(state.countryCode);
  }

  void clearNumber() {
    return state.numberController.clear();
  }

  void onChangeCountry(String country) {
    emit(state.copyWith(selectedCountry: country));
    print(state.selectedCountry);
  }

  void onChangeState(String value) {
    emit(state.copyWith(selectedState: value));
    print(state.selectedState);
  }

  void onChangeCity(String value) {
    emit(state.copyWith(selectedCity: value));
    print(state.selectedCity);
  }

  Future<void> showDatePickerDialog(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2040),
    ).then(
      (value) async {
        print(value);
        if (value != null) {
          String date = DateFormat("dd-MM-yyyy").format(value);
          state.dateOfBirthController.text = date;
          emit(state.copyWith(selectedDate: date));
          print(state.selectedDate);
        } else {
          print("DATE IS NOT SELECTED");
        }
      },
    );
  }

  void addItemsToCheckList() {
    List<Hobbies> temList = List.from(state.checkListItems);
    temList = [
      const Hobbies(isSelected: false, tittle: "Reading"),
      const Hobbies(isSelected: false, tittle: "Playing"),
      const Hobbies(isSelected: false, tittle: "Dancing"),
      const Hobbies(isSelected: false, tittle: "Travelling"),
      const Hobbies(isSelected: false, tittle: "Cooking"),
    ];
    emit(state.copyWith(checkListItems: temList));
  }

  void onChangeCheckBox(int index) {
    List<Hobbies> temList = List.from(state.checkListItems);
    List<Hobbies> selectedTempList = List.from(state.checkListItems);
    temList[index] = temList[index].copyWith(isSelected: !temList[index].isSelected);
    print(temList[index]);
    emit(state.copyWith(checkListItems: temList));
    selectedTempList = temList.where((element) => element.isSelected).map((e) => e).toList();
    List<Map<String, dynamic>> temp = selectedTempList.map((e) {
      return {
        "tittle": e.tittle,
        "isSelected": e.isSelected,
      };
    }).toList();
    print(temp.runtimeType);
    emit(state.copyWith(selectedCheckListItems: temp));
    print(state.selectedCheckListItems);
  }

  Future<void> submitForm(BuildContext context, String? documentId) async {
    EasyLoading.show();

    if (documentId == null) {
      DocumentReference collectionReference = FirebaseFirestore.instance.collection("form_data").doc();

      var addFormData = FormModal(
        uid: FirebaseAuth.instance.currentUser?.uid ?? "",
        name: state.nameController.text,
        documentId: collectionReference.id,
        gender: state.selectedGender,
        email: state.emailController.text,
        phoneNumber: state.pinCodeController.text,
        dateOfBirth: state.selectedDate,
        hobbies: state.selectedCheckListItems,
        address: Address(
          addressLine: state.addressController.text,
          country: state.selectedCountry,
          state: state.selectedState,
          city: state.selectedState,
          pinCode: state.pinCodeController.text,
        ),
      );
      print(addFormData.toMap());
      await collectionReference.set(addFormData.toMap()).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Form submited success")));
        EasyLoading.dismiss();
        Navigator.pushReplacementNamed(context, RoutesGenerator.mainScreen);
      });
    } else {
      DocumentReference collectionReferenceUpdate = FirebaseFirestore.instance.collection("form_data").doc(documentId);

      var updateFormData = FormModal(
        uid: FirebaseAuth.instance.currentUser?.uid ?? "",
        name: state.nameController.text,
        documentId: collectionReferenceUpdate.id,
        gender: state.selectedGender,
        email: state.emailController.text,
        phoneNumber: state.pinCodeController.text,
        dateOfBirth: state.selectedDate,
        hobbies: state.selectedCheckListItems,
        address: Address(
          addressLine: state.addressController.text,
          country: state.selectedCountry,
          state: state.selectedState,
          city: state.selectedState,
          pinCode: state.pinCodeController.text,
        ),
      );
      collectionReferenceUpdate.update(updateFormData.toMap()).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Form Updated success")));
        EasyLoading.dismiss();
        Navigator.pushReplacementNamed(context, RoutesGenerator.mainScreen);
      });
    }
  }
}
