import 'package:flutter/material.dart';
import 'package:horizontal_picker/horizontal_picker.dart';

import 'package:tres_connect/core/bloc/bloc.dart';
import 'package:tres_connect/core/themes/palette.dart';
import 'package:tres_connect/features/auth/presentation/profile/height/bloc/height_bloc.dart';

import 'package:tres_connect/core/routes/routes.dart';

class HeightPage extends StatelessWidget {
  final String types;
  final int defaultValue;
  final bool isEditing;
  const HeightPage(
      {required this.types,
      this.defaultValue = 50,
      this.isEditing = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HeightBloc(),
      child: Scaffold(
        body: HeightBody(
          type: types,
          defaultValue: defaultValue,
          isEditing: isEditing,
        ),
      ),
    );
  }
}

class HeightBody extends StatelessWidget {
  final String type;
  final int defaultValue;
  final bool isEditing;
  int selectedHeight = 157;
  HeightBody(
      {super.key,
      required this.type,
      required this.defaultValue,
      required this.isEditing});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HeightBloc, HeightState>(
      listener: (context, state) {
        if (state is HeightSaved) {
          if (isEditing) {
            Navigator.pop(context);
          } else {
            Navigator.pushNamed(context, Routes.profileAge,
                arguments: {"gender": type, "isEditing": isEditing});
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: const Text(
              'Height',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  context.read<HeightBloc>().add(SaveHeightBtnClicked(
                      selectedHeight,
                      isEditing: isEditing));
                },
                child: Text(
                  isEditing ? 'Save' : 'NEXT',
                  style: const TextStyle(
                      color: Palette.secondaryColor1,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ]),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                          "App is based on body height,calculate your daily walking distance",
                          style: TextStyle(
                              color: Palette.surfaceDark,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    if (type == "Female")
                      Expanded(
                          child: Image.asset(
                        "assets/images/user_female.png",
                      ))
                    else
                      Expanded(
                          child: Image.asset(
                        "assets/images/user_male.png",
                      )),
                    const SizedBox(
                      height: 25,
                    ),
                    HorizontalPicker(
                      minValue: 20,
                      maxValue: 300,
                      divisions: 140,
                      height: 60,
                      suffix: " CM",
                      showCursor: false,
                      backgroundColor: Palette.secondaryColor1,
                      activeItemTextColor: Colors.white,
                      passiveItemsTextColor: Colors.grey,
                      onChanged: (value) {
                        selectedHeight = value.toInt();
                      },
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
