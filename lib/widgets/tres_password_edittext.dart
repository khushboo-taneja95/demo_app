import 'package:flutter/material.dart';

import 'package:tres_connect/core/themes/palette.dart';
import 'package:tres_connect/core/utility/utils.dart';

class MyPasswordEditText extends StatelessWidget {
  IconData? iconData;
  IconData? suffixicon;
  Color iconcolor;
  String hint;
  Color enablebordercolor;
  Color focusbordercolor;
  bool isshow;
  bool isobscureText;
  Color textcolor;
  TextEditingController controller;

  MyPasswordEditText(
      {super.key,
      required this.iconData,
      required this.iconcolor,
      required this.hint,
      required this.isshow,
      required this.controller,
      this.enablebordercolor = Palette.lineGrey,
      this.focusbordercolor = Palette.lineGrey,
      this.textcolor = Colors.black,
      required this.isobscureText,
      required this.suffixicon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          validator: (value) {
            Utils.validateEmail(value);
          },
          controller: controller,
          obscureText: isobscureText,
          decoration: InputDecoration(
            prefixIcon: Icon(
              iconData,
              color: iconcolor,
            ),
            suffixIconConstraints:
                const BoxConstraints(minHeight: 10, minWidth: 10),
            suffixIcon: Visibility(
              visible: isshow,
              child: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  suffixicon,
                  color: Palette.secondaryColor1,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  // setState(() {
                  //   _passwordVisible = !_passwordVisible;
                  // });
                },
              ),
            ),
            hintText: hint,
            contentPadding: const EdgeInsets.all(15),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: focusbordercolor, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: enablebordercolor, width: 1),
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
