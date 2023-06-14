import 'package:equatable/equatable.dart';

class MapThemeModal extends Equatable{
  final String image;

  final String name;

  const MapThemeModal({
    required this.image,
    required this.name,
  });

  MapThemeModal copyWith({
    String? image,
    bool? isSelected,
    String? name,
  }) {
    return MapThemeModal(
      image: image ?? this.image,
      name: name ?? this.name,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [image,name];
}
