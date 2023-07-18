import 'package:flutter/material.dart';
import 'package:tres_connect/core/utility/ColorUtils.dart';
import 'package:tres_connect/core/themes/palette.dart';

class MyButton extends StatelessWidget {
  final EdgeInsets padding;
  final VoidCallback onClick;
  final double height;
  final Color bgColor;
  final Color textColor;
  final double textSize;
  final String text;

  const MyButton(
      {super.key,
      required this.text,
      this.padding = const EdgeInsets.fromLTRB(5, 5, 5, 5),
      this.bgColor = Palette.greenbtn,
      this.height = 50,
      required this.onClick,
      this.textColor = Colors.white,
      this.textSize = 18});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: InkWell(
        onTap: onClick,
        child: Container(
          height: height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: bgColor),
          child: Center(
              child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: textSize),
          )),
        ),
      ),
    );
  }
}

class MyButton2 extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final EdgeInsets padding;
  final Color backgroundColor;
  final bool isProgress;
  final Color textColor;
  final Color? shadowColor;
  final double width;
  final EdgeInsets margin;
  final double borderRadius;
  final int percentage;

  MyButton2({
    required this.text,
    required this.onTap,
    this.width = double.infinity,
    this.backgroundColor = Palette.greenbtn,
    this.isProgress = false,
    this.textColor = Colors.white,
    this.percentage = 100,
    this.padding = const EdgeInsets.all(10.0),
    this.margin = EdgeInsets.zero,
    this.shadowColor,
    this.borderRadius = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: margin,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius)),
      child: InkWell(
        onTap: () {
          if (isProgress && percentage != 100) {
            debugPrint(
                "Please wait. Button is disabled while content is loading");
            return;
          }
          onTap();
          debugPrint("Click action");
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                tween: Tween<double>(
                  begin: 0,
                  end: percentage / 100,
                ),
                builder: (context, value, _) => LinearProgressIndicator(
                  minHeight: 50,
                  value: value,
                  color: Palette.primaryColor,
                  backgroundColor: ColorUtils.lighten(Palette.primaryColor),
                ),
              ),
            ),
            Center(
                child: Text(text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ))),
          ],
        ),
      ),
    );
  }
}
