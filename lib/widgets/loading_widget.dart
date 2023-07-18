import 'package:flutter/material.dart';
import 'package:tres_connect/core/themes/palette.dart';

class LoadingWidget extends StatelessWidget {
  final String? message;
  const LoadingWidget({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(
            strokeWidth: 2,
            color: Palette.green,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(message ?? "Please wait...")
        ],
      ),
    );
  }
}
