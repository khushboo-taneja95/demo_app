import 'package:flutter/material.dart';

class BasicDialog extends StatelessWidget {
  final String title;
  final String description;
  final TextStyle? textStyle;
  final VoidCallback? onOkPressed;

  const BasicDialog(
      {super.key,
      required this.title,
      required this.description,
      this.textStyle,
      this.onOkPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              description,
              style: textStyle,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onOkPressed ??
              () {
                Navigator.of(context).pop();
              },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
