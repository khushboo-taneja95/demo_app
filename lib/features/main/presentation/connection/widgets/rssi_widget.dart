import 'package:flutter/material.dart';

class RssiIconWidget extends StatelessWidget {
  int rssi;
  RssiIconWidget({super.key, required this.rssi});

  @override
  Widget build(BuildContext context) {
    String image = "";
    if (rssi > -50) {
      image = "assets/images/signal_five.png";
    } else if (rssi > -60) {
      image = "assets/images/signal_four.png";
    } else if (rssi > -70) {
      image = "assets/images/signal_three.png";
    } else if (rssi > -80) {
      image = "assets/images/signal_two.png";
    } else if (rssi > -90) {
      image = "assets/images/signal_one.png";
    } else {
      image = "assets/images/signal_zero.png";
    }
    return Image.asset(
      image,
      width: 30,
      height: 30,
      fit: BoxFit.contain,
    );
  }
}
