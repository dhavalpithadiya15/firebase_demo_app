import 'package:country_picker/country_picker.dart';
import 'package:firebase_demo_app/main_screen/discovery/discovery_cubit.dart';
import 'package:firebase_demo_app/main_screen/discovery/discovery_state.dart';
import 'package:firebase_demo_app/main_screen/form/form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DiscoveryView extends StatelessWidget {
  const DiscoveryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746,
    );
    return Scaffold(
      body: BlocBuilder<DiscoveryCubit, DiscoveryState>(
        builder: (context, state) {
          return Stack(
            children: [
              GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  print("=========${controller}");
                  BlocProvider.of<DiscoveryCubit>(context).initController(controller);
                  print("==${state.googleMapController}");
                },
                markers: state.markers,
                buildingsEnabled: true,
                compassEnabled: true,
                initialCameraPosition: _kGooglePlex,
                onTap: (argument) {
                  BlocProvider.of<DiscoveryCubit>(context).onAddMarkerButtonPressed(argument);
                },
                indoorViewEnabled: true,
              ),
              Positioned(
                right: 15,
                top: 15,
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          insetPadding: EdgeInsets.all(15),
                          title: const Text("Change Map Theme"),
                          alignment: Alignment.center,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          content: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Wrap(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              direction: Axis.horizontal,
                              runSpacing: 5,
                              spacing: 5,
                              children: List.generate(state.listOfMapTheme.length, (index) {
                                print(index);
                                return Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(state.listOfMapTheme[index].image),
                                    ),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      BlocBuilder<DiscoveryCubit, DiscoveryState>(
                                        builder: (context, state) {
                                          return Positioned(
                                            top: 0,
                                            left: 0,
                                            child: Radio(
                                              value: state.listOfMapTheme[index].name,
                                              groupValue: state.selectedValue,
                                              onChanged: (value) {
                                                print(value);
                                                BlocProvider.of<DiscoveryCubit>(context).onChangeTheme(value!, context);
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        child: Text(
                                          state.listOfMapTheme[index].name,
                                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 13),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: const CircleAvatar(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
