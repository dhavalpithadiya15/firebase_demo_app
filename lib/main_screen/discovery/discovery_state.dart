import 'package:equatable/equatable.dart';
import 'package:firebase_demo_app/modal/map_theme_modal.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DiscoveryState extends Equatable {
  final Set<Marker> markers;
  final GoogleMapController? googleMapController;
  final List<MapThemeModal> listOfMapTheme;
  final String selectedValue;

  @override
  List<Object?> get props => [markers, googleMapController, listOfMapTheme,selectedValue];

  const DiscoveryState({
    this.listOfMapTheme = const [],
    this.markers = const {},
    this.googleMapController,
    this.selectedValue="STANDARD",

  });

  DiscoveryState copyWith({
    Set<Marker>? markers,
    GoogleMapController? googleMapController,
    List<MapThemeModal>? listOfMapTheme,
    String? selectedValue,
  }) {
    return DiscoveryState(
      markers: markers ?? this.markers,
      googleMapController: googleMapController ?? this.googleMapController,
      listOfMapTheme: listOfMapTheme ?? this.listOfMapTheme,
      selectedValue: selectedValue ?? this.selectedValue,
    );
  }
}
