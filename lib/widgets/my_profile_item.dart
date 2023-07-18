import 'package:flutter/material.dart';

import 'package:tres_connect/core/themes/palette.dart';
import 'package:tres_connect/gen/assets.gen.dart';

class MyProfileItem extends StatelessWidget {
  EdgeInsets padding;
  VoidCallback onClick;
  double height;
  String keyText;
  bool isVerified;
  String valueText;
  MyProfileItem({
    super.key,
    this.padding = const EdgeInsets.fromLTRB(5, 5, 5, 0),
    required this.onClick,
    this.height = 55,
    required this.keyText,
    this.isVerified = false,
    required this.valueText,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        color: Colors.white,
        height: height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 150,
                  child: Text(
                    keyText,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  )),
              Expanded(
                child: Row(
                  children: [
                    Visibility(
                        visible: isVerified,
                        child: Assets.images.checkGreen.image(
                          height: 15,
                          width: 15,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      valueText,
                      style: TextStyle(
                          fontSize: 15,
                          color: Palette.divider,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
