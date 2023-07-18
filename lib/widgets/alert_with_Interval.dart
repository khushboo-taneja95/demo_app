import 'package:flutter/material.dart';

class MultipleRowRadioWidget extends StatefulWidget {
  final List<String> options;
  final String titleMessage;
  final String? selectedButton;

  const MultipleRowRadioWidget(
      {Key? key,
      required this.options,
      required this.titleMessage,
      this.selectedButton})
      : super(key: key);

  @override
  _MultipleRowRadioWidgetState createState() => _MultipleRowRadioWidgetState();
}

class _MultipleRowRadioWidgetState extends State<MultipleRowRadioWidget> {
  late String selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.selectedButton == null
        ? widget.options.first
        : widget.selectedButton!;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(widget.titleMessage),
        content: SizedBox(
          width: 100,
          height: 300,
          child: Column(children: [
            SizedBox(
              height: 250,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.options.length,
                itemBuilder: (BuildContext context, int index) {
                  final option = widget.options[index];
                  return RadioListTile(
                    title: Text(option),
                    value: option,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value as String;
                        //print("selected value is:$selectedOption");
                      });
                    },
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 185),
              child: SizedBox(
                  width: double.maxFinite,
                  child: InkWell(
                      onTap: () {
                        //print("selected value is:$selectedOption");
                        Navigator.pop(context, {"value": selectedOption});
                      },
                      child: const Text(
                        'ok',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ))),
            )
          ]),
        ));
  }
}
