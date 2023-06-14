import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo_app/main_screen/form/form_cubit.dart';
import 'package:firebase_demo_app/main_screen/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../modal/form_modal.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void getAllFromData() async {
    EasyLoading.show();
    List<FormModal> temList = List.from(state.listOfForm);
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("form_data").get();
    EasyLoading.dismiss();
    temList = snapshot.docs.map((e) => FormModal.fromMap(e)).toList();
    emit(state.copyWith(listOfForm: temList));
    print(temList.map((e) => e.toMap()).toList());
  }

  Future<void> deleteData(String? documentId) async {
    if (documentId != null) {
      EasyLoading.show();
      DocumentReference collectionReference = FirebaseFirestore.instance.collection("form_data").doc(documentId);
      await collectionReference.delete();
      getAllFromData();

    }
  }
}
