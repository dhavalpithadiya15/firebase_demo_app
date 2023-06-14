import 'package:equatable/equatable.dart';
class Hobbies extends Equatable {
  final String tittle;
  final bool isSelected;

  @override
  List<Object?> get props => [tittle, isSelected];

  const Hobbies({
    this.tittle = "",
    this.isSelected = false,
  });

  Hobbies copyWith({
    String? tittle,
    bool? isSelected,
  }) {
    return Hobbies(
      tittle: tittle ?? this.tittle,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tittle': tittle,
      'isSelected': isSelected,
    };
  }

  factory Hobbies.fromMap(Map<String, dynamic> map) {
    return Hobbies(
      tittle: map['tittle'] as String,
      isSelected: map['isSelected'] as bool,
    );
  }
}
