import 'package:flutter/material.dart';

class NoChartWidget extends StatelessWidget {
  final String message;
  final double height;
  const NoChartWidget(
      {Key? key, this.message = "No data available", this.height = 100})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Center(
        child: Text(
          message,
          style: const TextStyle(
              color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 12),
        ),
      ),
    );
  }
}
