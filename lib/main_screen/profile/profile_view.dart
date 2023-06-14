import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  List image = [
    "assets/images/standard_map.png",
    "assets/images/silver_map.png",
    "assets/images/retro_map.png",
    "assets/images/night_map.png",
    "assets/images/dark_map.png",
    "assets/images/aubergine_map.png",
  ];
  List name = ["STANDARD", "SILVER", "RETRO", "NIGHT", "DARK", "AUBERGINE"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Wrap(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          direction: Axis.horizontal,
          runSpacing: 5,
          spacing: 5,
          children: List.generate(image.length, (index) {
            return Container(
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(image[index]),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Checkbox(
                      shape: const CircleBorder(),
                      side: MaterialStateBorderSide.resolveWith(
                        (states) => const BorderSide(
                          width: 1.0,
                          color: Colors.white,
                        ),
                      ),
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Text(
                      name[index],
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
