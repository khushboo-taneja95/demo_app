import 'package:flutter/material.dart';
import 'package:tres_connect/core/themes/palette.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: const Center(child: Text("sdkfhksdjhfksdhfsd")),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          elevation: 0,
          backgroundColor: Colors.deepPurple,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Palette.challengeCircleColor,
            ),
            child: const Icon(
              Icons.directions_run,
              size: 45,
            ),
          ),
        ),
      ),
    );
  }
}
