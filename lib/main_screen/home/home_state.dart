import 'package:equatable/equatable.dart';

import '../../modal/form_modal.dart';

class HomeState extends Equatable {
  final List<FormModal> listOfForm;


  @override
  List<Object?> get props => [listOfForm];

  const HomeState({
     this.listOfForm=const[],
  });

  HomeState copyWith({
    List<FormModal>? listOfForm,
  }) {
    return HomeState(
      listOfForm: listOfForm ?? this.listOfForm,
    );
  }
}
