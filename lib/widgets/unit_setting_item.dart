import 'package:flutter/material.dart';
import 'package:tres_connect/core/themes/palette.dart';

class MyUnitSettingItem extends StatelessWidget {
  EdgeInsets padding;
  VoidCallback onClickKey;
  VoidCallback onClickKey1;
  double height;
  Color bgColor;
  Color headingTextColor;
  double headingTextSize;
  double keyTextSize;
  String headingText;
  String keyText;
  String keyText1;
  Color keyTextcolor;
  Color keyTextcolor1;
  //bool isShow;
  MyUnitSettingItem({
    super.key,
    this.padding = const EdgeInsets.fromLTRB(5, 5, 5, 0),
    this.bgColor = Colors.white,
    this.height = 50,
    required this.onClickKey,
    required this.onClickKey1,
    this.headingTextColor = Colors.white,
    this.keyTextcolor = Palette.darkgrey,
    this.keyTextcolor1 = Palette.darkgrey,
    this.headingTextSize = 16,
    this.keyTextSize = 16,
    required this.headingText,
    required this.keyText,
    required this.keyText1,
    //required this.isShow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              headingText,
              style: TextStyle(
                  fontSize: headingTextSize, fontWeight: FontWeight.normal),
            ),
            Row(
              children: [
                InkWell(
                  onTap: onClickKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      keyText,
                      style: TextStyle(
                          fontSize: keyTextSize,
                          fontWeight: FontWeight.bold,
                          color: keyTextcolor),
                    ),
                  ),
                ),
                InkWell(
                  onTap: onClickKey1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      keyText1,
                      style: TextStyle(
                          fontSize: keyTextSize,
                          fontWeight: FontWeight.bold,
                          color: keyTextcolor1),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
