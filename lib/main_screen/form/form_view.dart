import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_demo_app/colors/app_color.dart';
import 'package:firebase_demo_app/custom_widgets/custom_button.dart';
import 'package:firebase_demo_app/custom_widgets/custom_phone_text_field.dart';
import 'package:firebase_demo_app/custom_widgets/custom_text_field.dart';
import 'package:firebase_demo_app/custom_widgets/tittle_text.dart';
import 'package:firebase_demo_app/main_screen/form/form_cubit.dart';
import 'package:firebase_demo_app/main_screen/form/form_state.dart';
import 'package:firebase_demo_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormView extends StatelessWidget {
  final String? documentId;

  const FormView({Key? key, this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("====${documentId}");
    return BlocProvider(
      create: (context) => MyFormCubit()..editData(documentId ?? ""),
      child: Builder(builder: (context) {
        return BlocBuilder<MyFormCubit, MyFormState>(
          builder: (context, state) {
            return SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TittleText(text: "Fill your Details"),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Name:", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
                      CustomTextField(
                        labelText: "Your name",
                        controller: context.read<MyFormCubit>().state.nameController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Gender:", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
                      Row(
                        children: context
                            .watch<MyFormCubit>()
                            .state
                            .genderList
                            .map(
                              (e) => Expanded(
                                child: RadioListTile(
                                  visualDensity:
                                      const VisualDensity(horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity),
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  activeColor: AppColor.primaryColor,
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(e),
                                  value: e,
                                  groupValue: context.read<MyFormCubit>().state.selectedGender,
                                  onChanged: (value) {
                                    BlocProvider.of<MyFormCubit>(context).genderOnChange(value ?? "");
                                  },
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Phone number:", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
                      CustomPhoneTextField(
                        onChangeCountryCode: (value) => BlocProvider.of<MyFormCubit>(context).onChangeCountryCode(value),
                        controller: context.read<MyFormCubit>().state.numberController,
                        onPressedClearField: () => BlocProvider.of<MyFormCubit>(context).clearNumber(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Email:", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
                      CustomTextField(
                        labelText: "Enter your email",
                        controller: context.read<MyFormCubit>().state.emailController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Date of Birth:", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
                      CustomTextField(
                        onTap: () => BlocProvider.of<MyFormCubit>(context).showDatePickerDialog(context),
                        iconButton: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.calendar_month),
                        ),
                        readOnly: true,
                        labelText: "Select your date of birth",
                        controller: context.read<MyFormCubit>().state.dateOfBirthController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Select your hobbies:",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: state.checkListItems.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return CheckboxListTile(
                            activeColor: AppColor.primaryColor,
                            contentPadding: EdgeInsets.zero,
                            title: Text(state.checkListItems[index].tittle),
                            value: state.checkListItems[index].isSelected,
                            onChanged: (value) {
                              BlocProvider.of<MyFormCubit>(context).onChangeCheckBox(index);
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Address:",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                      ),
                      CustomTextField(
                        labelText: "123 test street",
                        controller: context.read<MyFormCubit>().state.addressController,
                      ),
                      BlocBuilder<MyFormCubit, MyFormState>(
                        builder: (context, state) {
                          return CSCPicker(
                            showStates: true,
                            showCities: true,
                            flagState: CountryFlag.DISABLE,
                            dropdownDecoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: AppColor.primaryColor),
                              ),
                            ),
                            disabledDropdownDecoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: AppColor.primaryColor),
                              ),
                            ),
                            countrySearchPlaceholder: "Country",
                            stateSearchPlaceholder: "State",
                            cityDropdownLabel: "*City",
                            countryDropdownLabel: "*Country",
                            stateDropdownLabel: "*State",
                            disableCountry: false,
                            citySearchPlaceholder: "*City",
                            onCityChanged: (value) => BlocProvider.of<MyFormCubit>(context).onChangeCity(value ?? ""),
                            selectedItemStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            dropdownHeadingStyle: const TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
                            dropdownItemStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            dropdownDialogRadius: 10.0,
                            searchBarRadius: 10.0,
                            onCountryChanged: (value) => BlocProvider.of<MyFormCubit>(context).onChangeCountry(value),
                            onStateChanged: (value) => BlocProvider.of<MyFormCubit>(context).onChangeState(value ?? ""),
                          );
                        },
                      ),
                      CustomTextField(labelText: "Postal/Zip code", controller: context.read<MyFormCubit>().state.pinCodeController),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: CustomButton(
                          onTap: () async {
                            BlocProvider.of<MyFormCubit>(context).submitForm(context, documentId);
                          },
                          text: documentId != null ? "Update" : "Submit",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
