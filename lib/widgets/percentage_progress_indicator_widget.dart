import 'package:flutter/material.dart';
import 'package:tres_connect/core/themes/palette.dart';

class PercentageProgressBar extends StatefulWidget {
  final double percentage;

  const PercentageProgressBar({required this.percentage});

  @override
  _PercentageProgressBarState createState() => _PercentageProgressBarState();
}

class _PercentageProgressBarState extends State<PercentageProgressBar>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    // _animationController = AnimationController(
    //   duration: const Duration(milliseconds: 500),
    //   vsync: this,
    // );
    // _animation = Tween<Color?>(
    //   begin: Colors.red,
    //   end: Colors.green,
    // ).animate(_animationController);

    // _animationController.animateTo(widget.percentage / 100);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: double.infinity,
      margin: const EdgeInsets.all(15),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        tween: Tween<double>(
          begin: 0,
          end: widget.percentage / 100,
        ),
        builder: (context, value, _) => LinearProgressIndicator(
          minHeight: 50,
          value: value,
          color: Palette.green,
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}
