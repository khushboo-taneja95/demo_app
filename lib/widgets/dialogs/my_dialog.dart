import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tres_connect/gen/assets.gen.dart';

typedef OnPositiveBtnClicked = void Function();
typedef OnNegativeBtnClicked = void Function();

enum Type { SUCCESS, ERROR, WARNING, INFO }

class MyDialog extends StatelessWidget {
  final String title;
  final String message;
  final Type dialogType;
  final OnPositiveBtnClicked onPositiveBtnClicked;
  final OnNegativeBtnClicked onNegativeBtnClicked;
  final String positiveBtnText;
  final String negativeBtnText;
  final bool isSingleBtn;
  final Color positiveBtnColor;
  final Color negativeBtnColor;
  final Color titleColor;
  final Color messageColor;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;

  const MyDialog(
      {super.key,
      required this.title,
      required this.message,
      required this.onPositiveBtnClicked,
      required this.onNegativeBtnClicked,
      this.dialogType = Type.INFO,
      this.positiveBtnText = "OK",
      this.negativeBtnText = "Cancel",
      this.isSingleBtn = false,
      this.positiveBtnColor = Colors.green,
      this.negativeBtnColor = Colors.red,
      this.titleColor = Colors.black,
      this.messageColor = Colors.black,
      this.backgroundColor = Colors.white,
      this.borderColor = Colors.white,
      this.borderWidth = 0});

  @override
  Widget build(BuildContext context) {
    String animationPath = Assets.animations.info;
    // Color borderColor = Colors.blue;
    switch (dialogType) {
      case Type.SUCCESS:
        animationPath = Assets.animations.success;
        // borderColor = Colors.green;
        break;
      case Type.ERROR:
        animationPath = Assets.animations.failure;
        // borderColor = Colors.red;
        break;
      case Type.WARNING:
        animationPath = Assets.animations.warning;
        // borderColor = Colors.orange;
        break;
      case Type.INFO:
        animationPath = Assets.animations.info;
        // borderColor = Colors.blue;
        break;
      default:
        animationPath = Assets.animations.info;
      // borderColor = Colors.blue;
    }
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                border: Border.all(color: borderColor, width: borderWidth)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: titleColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    message,
                    style: TextStyle(
                      fontSize: 14,
                      color: messageColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    isSingleBtn
                        ? const SizedBox()
                        : TextButton(
                            onPressed: onNegativeBtnClicked,
                            child: Text(
                              negativeBtnText,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: negativeBtnColor),
                            )),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                        onPressed: onPositiveBtnClicked,
                        child: Text(positiveBtnText,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: positiveBtnColor))),
                  ],
                )
              ],
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                  width: 60,
                  height: 60,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Lottie.asset(
                    animationPath,
                    repeat: true,
                    reverse: false,
                    animate: true,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
