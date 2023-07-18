import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tres_connect/features/auth/domain/entities/user_profile_info_entity.dart';
import 'package:tres_connect/features/auth/presentation/profile/age/bloc/age_bloc.dart';
import 'package:tres_connect/core/themes/palette.dart';
import 'package:tres_connect/core/routes/routes.dart';

import '../../../../../../core/utility/DateUtility.dart';

class AgePage extends StatelessWidget {
  final String types;
  final DateTime defaultValue;
  final bool isEditing;
  final String dob;
  const AgePage(
      {required this.types,
      required this.defaultValue,
      this.isEditing = false,
      required this.dob,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AgeBloc(),
      child: Scaffold(
        body: AgeBody(
          type: types,
          selectedDate: defaultValue,
          isEditing: isEditing,
          dob: dob,
        ),
      ),
    );
  }
}

class AgeBody extends StatelessWidget {
  final String type;
  final bool isEditing;
  final String dob;
  DateTime selectedDate = DateTime.now();
  AgeBody(
      {super.key,
      required this.type,
      required this.selectedDate,
      this.isEditing = false,
      required this.dob});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AgeBloc, AgeState>(
      listener: (context, state) {
        if (state is AgeSaved) {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.dashboard, (route) => false);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: const Text(
              'Age',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  context.read<AgeBloc>().add(SaveAgeBtnClicked(DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day)));
                },
                child: Text(
                  isEditing ? 'Save' : 'NEXT',
                  style: TextStyle(
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
                    SizedBox(
                      height: 200,
                      child: Builder(builder: (context) {
                        print('date of birth is$dob');
                        String y = DateUtility.formatDateTime(
                            dateTime: DateTime.parse(dob),
                            outputFormat: "yyyy");
                        String m = DateUtility.formatDateTime(
                            dateTime: DateTime.parse(dob), outputFormat: "MM");
                        String d = DateUtility.formatDateTime(
                            dateTime: DateTime.parse(dob), outputFormat: "dd");
                        return CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          initialDateTime: DateTime(
                              int.parse(y), int.parse(m), int.parse(d)),
                          minimumDate: DateTime(DateTime.now().year - 100,
                              DateTime.now().month, DateTime.now().day),
                          maximumDate: DateTime.now(),
                          onDateTimeChanged: (DateTime newDateTime) {
                            selectedDate = newDateTime;
                          },
                        );
                      }),
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

  void navigateToNextPage(BuildContext context, UserProfileEntiry? profile) {
    String routeName = Routes.login;
    if (profile == null) {
      routeName = Routes.login;
    } else {
      if (profile.weight == null || profile.weight == 0) {
        routeName = Routes.profileWeight;
      } else if (profile.height == null || profile.height == 0) {
        routeName = Routes.profileHeight;
      } else if (profile.dateOfBirth == null || profile.dateOfBirth!.isEmpty) {
        routeName = Routes.profileAge;
      }
    }
    Navigator.pushNamed(context, routeName);
  }
}
