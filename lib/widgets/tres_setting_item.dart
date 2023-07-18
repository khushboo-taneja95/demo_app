import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:tres_connect/core/themes/palette.dart';

class MySettingItem extends StatelessWidget{
  EdgeInsets padding;
  VoidCallback onClick;
  double height;
  Color bgColor;
  Color textColor;
  Color batterytextColor;
  Color batteryimageColor;
  Color imageColor;
  double textSize;
  double batterytextSize;
  String text;
  String image;
  String batteryimage;
  String batterytext;
  bool isbattery;
  bool ishealthmonitoring;

  MySettingItem(
      {super.key,
        required this.text,
        required this.padding ,
        this.bgColor = Palette.greenbtn,
        this.height = 60,
        this.isbattery = false,
        this.ishealthmonitoring = false,
        required this.image,
        required this.onClick,
        required this.textColor ,
        required this.imageColor ,
        this.textSize = 16,
        this.batterytextSize = 16,
        this.batterytextColor = Palette.darkgrey,
        this.batteryimageColor = Palette.darkgrey,
        this.batteryimage = "assets/images/setting_datashare.png",
        this.batterytext = "",
      });

  @override
  Widget build(BuildContext context) {
   return InkWell(
     onTap: onClick,
     child: Column(
       children: [
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 8.0),
           child: Container(
             height: 0.5,
             color: Palette.secondaryColor1,
           ),
         ),
         Padding(
           padding: padding,
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Expanded(
                 child: Row(
                   children: [
                     Image.asset(
                       image,
                       height: 20,
                       width: 20,
                       color: imageColor,
                     ),
                     const SizedBox(
                       width: 15,
                     ),
                     Text(
                       text,
                       style: TextStyle(
                           fontSize: textSize, color: textColor),
                     )
                   ],
                 ),
               ),
               Visibility(
                 visible: isbattery,
                 child: Row(
                   children: [
                     Image.asset(
                       batteryimage,
                       height: 20,
                       width: 20,
                       color: batteryimageColor,
                     ),
                     const SizedBox(
                       width: 5,
                     ),
                     Text(
                       batterytext,
                       style: TextStyle(
                           fontSize: batterytextSize, color: batterytextColor),
                     )
                   ],
                 ),
               ),
               Visibility(
                 visible: ishealthmonitoring,
                 child: Transform.scale(scale: 0.8,
                   child: CupertinoSwitch(
                     value: true,
                     onChanged: (value) {

                     },
                   ),
                 ),
               ),
             ],
           ),
         ),
       ],
     ),
   );
  }
}