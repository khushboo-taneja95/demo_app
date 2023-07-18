import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tres_connect/core/bloc/bloc.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/themes/palette.dart';
import 'package:tres_connect/core/usecase/usecase.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TestBody(),
    );
  }
}

class TestBody extends StatelessWidget {
  TestBody({super.key});

  final cityTextEditingController = TextEditingController();
  final departureDateController = TextEditingController();
  final returnDateController = TextEditingController();

  bool isVisible = false;
  String groupValue = "reason3";
  final barBGColor = Palette.cautiousColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Test Screen"),
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text(
                "Go",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Column(
        children: [ElevatedButton(onPressed: () {}, child: const Text("Test"))],
      ),
    );
  }
}
