import 'package:flutter/material.dart';
import 'package:tres_connect/core/themes/palette.dart';
import 'package:tres_connect/core/utility/utils.dart';

class MyEditText extends StatelessWidget{

  IconData? iconData;
  Color iconcolor;
  String hint;
  Color enablebordercolor;
  Color focusbordercolor;
  Color textcolor;
  TextEditingController controller;

  MyEditText(
      {super.key,
        required this.iconData,
      required this.iconcolor,
      required this.hint,
      required this.controller,
      this.enablebordercolor = Palette.lineGrey,
      this.focusbordercolor = Palette.secondaryColor1,
      this.textcolor = Colors.black,
        });

  @override
  Widget build(BuildContext context) {
   return Column(
     children: [
       TextFormField(
         validator: (value) {
           Utils.validateEmail(value);
         },
         controller: controller,
         decoration: InputDecoration(
           prefixIcon:  Icon(
             iconData,
             color:iconcolor,
           ),

           hintText: hint,
           contentPadding: const EdgeInsets.all(15),
           focusedBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(50),
             borderSide:  BorderSide(
                 color: focusbordercolor, width: 1),
           ),
           enabledBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(50),
             borderSide:
              BorderSide(color:enablebordercolor, width: 1),
           ),
         ),
       ),
       const SizedBox(
         height: 10,
       ),
     ],
   );
  }

}