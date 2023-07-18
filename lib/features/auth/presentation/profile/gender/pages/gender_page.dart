import 'package:flutter/material.dart';
import 'package:tres_connect/core/routes/routes.dart';
import 'package:tres_connect/core/themes/palette.dart';

import 'package:tres_connect/core/bloc/bloc.dart';
import 'package:tres_connect/features/auth/presentation/profile/gender/bloc/gender_bloc.dart';

class GenderPage extends StatelessWidget {
  final bool isEditing;
  const GenderPage({Key? key, required this.isEditing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GenderBloc(),
      child: GenderBody(
        isEditing: isEditing,
      ),
    );
  }
}

class GenderBody extends StatelessWidget {
  final bool isEditing;
  const GenderBody({super.key, required this.isEditing});

  @override
  Widget build(BuildContext context) {
    return BlocListener<GenderBloc, GenderState>(
      listener: (context, state) {
        if (state is GenderSaved) {
          if (isEditing) {
            Navigator.pop(context);
          } else {
            Navigator.pushNamed(context, Routes.profileWeight,
                arguments: {"gender": state.gender, "isEditing": false});
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Gender',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        InkWell(
                            onTap: () {
                              context
                                  .read<GenderBloc>()
                                  .add(SaveGenderBtnClicked("Male"));
                            },
                            child: Image.asset("assets/images/user_male.png")),
                        const SizedBox(
                          height: 25,
                        ),
                        const Text("Male",
                            style: TextStyle(
                                color: Palette.secondaryColor1,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        InkWell(
                            onTap: () {
                              context
                                  .read<GenderBloc>()
                                  .add(SaveGenderBtnClicked("Female"));
                              // Navigator.pushNamed(context, Routes.profileWeight,
                              //     arguments: {"gender": "Female"});
                            },
                            child:
                                Image.asset("assets/images/user_female.png")),
                        const SizedBox(
                          height: 25,
                        ),
                        const Text("Female",
                            style: TextStyle(
                                color: Palette.secondaryColor1,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
