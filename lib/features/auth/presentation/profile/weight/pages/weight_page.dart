import 'package:flutter/material.dart';
import 'package:horizontal_picker/horizontal_picker.dart';

import 'package:tres_connect/core/bloc/bloc.dart';
import 'package:tres_connect/core/routes/routes.dart';
import 'package:tres_connect/core/themes/palette.dart';
import 'package:tres_connect/features/auth/presentation/profile/weight/bloc/weight_bloc.dart';

class WeightPage extends StatelessWidget {
  final String types;
  final int defaultWeight;
  final bool isEditing;
  const WeightPage(
      {required this.types,
      this.defaultWeight = 50,
      this.isEditing = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeightBloc(),
      child: Scaffold(
        body: WeightBody(
          type: types,
          selectedWeight: defaultWeight,
          isEditing: isEditing,
        ),
      ),
    );
  }
}

class WeightBody extends StatelessWidget {
  final String type;
  int selectedWeight = 50;
  final bool isEditing;
  WeightBody(
      {super.key,
      required this.type,
      required this.selectedWeight,
      required this.isEditing});

  @override
  Widget build(BuildContext context) {
    return BlocListener<WeightBloc, WeightState>(
      listener: (context, state) {
        if (state is WeightSaved) {
          if (isEditing) {
            Navigator.pop(context);
          } else {
            Navigator.pushNamed(context, Routes.profileHeight,
                arguments: {"gender": type, "isEditing": false});
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Weight',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                context.read<WeightBloc>().add(
                    SaveWeightBtnClicked(selectedWeight, isEditing: isEditing));
              },
              child: Text(
                isEditing ? 'Save' : 'NEXT',
                style: const TextStyle(
                    color: Palette.secondaryColor1,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
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
                          "App is based on body weight,calculate your daily calorie burn-up",
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
                              "assets/images/user_female_weighing.png"))
                    else
                      Expanded(
                          child: Image.asset(
                              "assets/images/user_male_weighing.png")),
                    const SizedBox(
                      height: 25,
                    ),
                    HorizontalPicker(
                      minValue: 20,
                      maxValue: 300,
                      divisions: 140,
                      height: 60,
                      suffix: " KG",
                      showCursor: false,
                      backgroundColor: Palette.secondaryColor1,
                      activeItemTextColor: Colors.white,
                      passiveItemsTextColor: Colors.grey,
                      onChanged: (value) {
                        selectedWeight = value.toInt();
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
