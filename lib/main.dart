import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo_app/helper/helper.dart';
import 'package:firebase_demo_app/main_screen/discovery/discovery_cubit.dart';
import 'package:firebase_demo_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import './firebase_options.dart';
import './colors/app_color.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Helper.loadingConfig();

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiscoveryCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Poppins',
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(
              color: AppColor.primaryColor,
            ),
          ),
        ),
        builder: EasyLoading.init(),
        initialRoute: RoutesGenerator.splash,
        onGenerateRoute: RoutesGenerator.generateRoute,
      ),
    );
  }
}
