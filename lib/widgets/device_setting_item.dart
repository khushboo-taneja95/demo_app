import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDeviceSettingItem extends StatelessWidget {
  EdgeInsets margin;
  EdgeInsets padding;
  VoidCallback onClick;
  Function(bool)? onChanged;
  double height;
  Color bgColor;
  Color headingTextColor;
  double headingTextSize;
  double keyTextSize;
  String headingText;
  bool isShow;
  bool isSwitchvalue;
  bool isRightArrow;
  bool isRighttext;
  bool issubtext;
  String valuetext;
  FontWeight fontWeight;
  MyDeviceSettingItem({
    super.key,
    this.padding = const EdgeInsets.fromLTRB(5, 5, 5, 0),
    this.margin = const EdgeInsets.fromLTRB(5, 5, 5, 0),
    this.bgColor = Colors.white,
    this.height = 50,
    required this.onClick,
    this.headingTextColor = Colors.black,
    this.onChanged,
    this.headingTextSize = 15,
    this.keyTextSize = 16,
    required this.headingText,
    required this.isShow,
    this.isRightArrow = true,
    this.isRighttext = false,
    this.isSwitchvalue = false,
    this.issubtext = false,
    this.valuetext = "8:00 AM",
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isShow,
      child: InkWell(
        onTap: onClick,
        child: Container(
          width: double.infinity,
          height: 60,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      headingText,
                      style: TextStyle(
                          fontSize: headingTextSize,
                          fontWeight: fontWeight,
                          color: headingTextColor),
                    ),
                    Visibility(
                        visible: issubtext,
                        child: const Text(
                          "Don't remind me from 12:00 noon to 02:00 pm",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.normal),
                        )),
                  ],
                )),
                Row(
                  children: [
                    Visibility(
                        visible: isRighttext,
                        child: Text(valuetext,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.normal))),
                    SizedBox(
                      width: 2,
                    ),
                    isRightArrow
                        ? Icon(Icons.keyboard_arrow_right)
                        : Transform.scale(
                            scale: 0.8,
                            child: CupertinoSwitch(
                              value: isSwitchvalue,
                              onChanged: onChanged,
                            ),
                          ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
