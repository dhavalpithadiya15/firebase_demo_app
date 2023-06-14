import 'package:bloc/bloc.dart';
import 'package:firebase_demo_app/main_screen/discovery/discovery_state.dart';
import 'package:firebase_demo_app/modal/map_theme_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DiscoveryCubit extends Cubit<DiscoveryState> {
  DiscoveryCubit() : super(const DiscoveryState()) {
    addThemeList();
  }

  void onAddMarkerButtonPressed(LatLng latLng) {
    var tempSet = List<Marker>.from(state.markers).toSet();
    tempSet.add(
      Marker(markerId: const MarkerId(""), position: latLng, infoWindow: InfoWindow(title: latLng.toString())),
    );

    emit(state.copyWith(markers: tempSet));
  }

  Future<void> initController(GoogleMapController controller) async {
    var tempController = controller;
    print("==TEMP CONTROLLER=> ${tempController}");
    emit(state.copyWith(googleMapController: tempController));
    print("====STATE CONTROLLER => ${state.googleMapController}");
  }

  Future<void> changeTheme() async {
    EasyLoading.show();
    var darkMapStyle = await rootBundle.loadString("assets/map_styles/night.json");
    EasyLoading.dismiss();
    var temp = state.googleMapController;
    temp?.setMapStyle(darkMapStyle);
  }

  void addThemeList() {
    List<MapThemeModal> tempList = List.from(state.listOfMapTheme);
    tempList = [
      const MapThemeModal(image: "assets/images/standard_map.png", name: "STANDARD"),
      const MapThemeModal(image: "assets/images/silver_map.png", name: "SILVER"),
      const MapThemeModal(image: "assets/images/retro_map.png", name: "RETRO"),
      const MapThemeModal(image: "assets/images/night_map.png", name: "NIGHT"),
      const MapThemeModal(image: "assets/images/dark_map.png", name: "DARK"),
      const MapThemeModal(image: "assets/images/aubergine_map.png", name: "AUBERGINE"),
    ];
    emit(state.copyWith(listOfMapTheme: tempList));
  }

  Future<void> onChangeTheme(String value, BuildContext context) async {
    emit(state.copyWith(selectedValue: value));
    print(value);
    switch (state.selectedValue) {
      case "STANDARD":
        var standardStyle = await rootBundle.loadString("assets/map_styles/standard.json");
        state.googleMapController?.setMapStyle(standardStyle).then((value) {
          Navigator.pop(context);
        });
        break;
      case "SILVER":
        var silverStyle = await rootBundle.loadString("assets/map_styles/silver.json");
        state.googleMapController?.setMapStyle(silverStyle).then((value) {
          Navigator.pop(context);
        });
        break;
      case "RETRO":
        var retroStyle = await rootBundle.loadString("assets/map_styles/retro.json");
        state.googleMapController?.setMapStyle(retroStyle).then((value) {
          Navigator.pop(context);
        });
        break;
      case "NIGHT":
        var nightStyle = await rootBundle.loadString("assets/map_styles/night.json");
        state.googleMapController?.setMapStyle(nightStyle).then((value) {
          Navigator.pop(context);
        });
        break;
      case "DARK":
        var darkStyle = await rootBundle.loadString("assets/map_styles/dark.json");
        state.googleMapController?.setMapStyle(darkStyle).then((value) {
          Navigator.pop(context);
        });
        break;
      case "AUBERGINE":
        var aubergineStyle = await rootBundle.loadString("assets/map_styles/aubergine.json");
        state.googleMapController?.setMapStyle(aubergineStyle).then((value) {
          Navigator.pop(context);
        });
        break;
      default:
        var standardStyle = await rootBundle.loadString("assets/map_styles/standard.json");


    }
  }
}
