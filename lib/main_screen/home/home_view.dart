import 'package:firebase_demo_app/colors/app_color.dart';
import 'package:firebase_demo_app/custom_widgets/custom_bottom_nav.dart';
import 'package:firebase_demo_app/helper/helper.dart';
import 'package:firebase_demo_app/main_screen/form/form_cubit.dart';
import 'package:firebase_demo_app/main_screen/form/form_view.dart';
import 'package:firebase_demo_app/main_screen/home/home_cubit.dart';
import 'package:firebase_demo_app/main_screen/home/home_state.dart';
import 'package:firebase_demo_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../main_screen_cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getAllFromData(),
      child: Builder(builder: (context) {
        return Scaffold(
          body: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return ListView.builder(
                itemCount: state.listOfForm.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.listOfForm[index].name),
                    subtitle: Text(state.listOfForm[index].email),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {

                            Navigator.pushNamed(context, RoutesGenerator.form,arguments: state.listOfForm[index].documentId);
                          },
                          icon: const Icon(Icons.update,color: Colors.green),
                        ),

                        IconButton(
                          onPressed: () {

                          BlocProvider.of<HomeCubit>(context).deleteData(state.listOfForm[index].documentId);
                          },
                          icon: const Icon(Icons.delete,color: Colors.red,),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        );
      }),
    );
  }
}
