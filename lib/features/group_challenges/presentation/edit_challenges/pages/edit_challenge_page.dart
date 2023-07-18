import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/themes/palette.dart';
import 'package:tres_connect/core/utility/DateUtility.dart';
import 'package:tres_connect/core/utility/utils.dart';
import 'package:tres_connect/features/group_challenges/data/datasources/create_challenges_remote_data_source.dart';
import 'package:tres_connect/features/group_challenges/data/models/update_challenges_models.dart';
import 'package:tres_connect/global_configuration.dart';
import 'package:tres_connect/widgets/tres_btn.dart';
import 'dart:io';

class EditChallengePage extends StatefulWidget {
  final String? challengesName;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? targetName;
  final String challengeId;
  final String? challengesDetails;
  final String? groupUid;
  final String? groupName;

  const EditChallengePage({
    super.key,
    this.challengesName,
    this.startDate,
    this.endDate,
    required this.challengeId,
    this.targetName,
    this.challengesDetails,
    this.groupName,
    this.groupUid,
  });

  @override
  State<EditChallengePage> createState() => _EditChallengePageState();
}

class _EditChallengePageState extends State<EditChallengePage> {
  Future<UpdateChallengeModels>? _futureUpdateChallengesModels;
  TextEditingController challengesNameController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController targetNameController = TextEditingController();
  TextEditingController challengesDetailsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? file;

  Map<String, dynamic>? firstBadge = null;
  Map<String, dynamic>? secondBadge = null;
  Map<String, dynamic>? thirdBadge = null;
  Map<String, dynamic>? completionBadge = null;

  @override
  void initState() {
    print(widget.challengeId);
    print(widget.challengesName);
    print(widget.endDate);
    print(widget.endDate);
    if (widget.challengesName != null) {
      challengesNameController.text = widget.challengesName!.toString();
    }

    if (widget.startDate != null) {
      startDateController = TextEditingController(
          text: DateUtility.formatDateTime(
              dateTime: widget.startDate!, outputFormat: "dd-MMM-yyyy"));
    }
    if (widget.endDate != null) {
      endDateController = TextEditingController(
          text: DateUtility.formatDateTime(
              dateTime: widget.endDate!, outputFormat: "dd-MMM-yyyy"));
    }
    if (widget.targetName != null) {
      targetNameController.text = widget.targetName!.toString();
    }
    if (widget.challengesDetails != null) {
      challengesDetailsController.text = widget.challengesDetails!.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Edit Challenge ",
          style: TextStyle(color: Palette.surface),
        ),
        backgroundColor: Colors.black,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Challenge Name",
                    style: TextStyle(fontSize: 16, color: Palette.darkgrey),
                  )),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: challengesNameController,
                decoration: const InputDecoration(
                  hintText: "Title",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Start Date",
                    style: TextStyle(fontSize: 16, color: Palette.darkgrey),
                  )),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: startDateController,
                keyboardType: TextInputType.datetime,
                onChanged: (value) {},
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now().add(const Duration(days: 365)));
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('dd-MMM-yyyy').format(pickedDate);
                    setState(() {
                      startDateController.text = formattedDate;
                    });
                  } else {}
                },
                decoration: const InputDecoration(
                    hintText: "Start Date",
                    suffixIcon: Icon(Icons.calendar_today),
                    suffixIconColor: Palette.secondaryColor1),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "End Date",
                    style: TextStyle(fontSize: 16, color: Palette.darkgrey),
                  )),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: endDateController,
                keyboardType: TextInputType.datetime,
                onChanged: (value) {},
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100));
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('dd-MMM-yyyy').format(pickedDate);
                    setState(() {
                      endDateController.text = formattedDate;
                    });
                  } else {}
                },
                decoration: const InputDecoration(
                    hintText: "End Date",
                    suffixIcon: Icon(Icons.calendar_today),
                    suffixIconColor: Palette.secondaryColor1),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Target",
                    style: TextStyle(fontSize: 16, color: Palette.darkgrey),
                  )),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: targetNameController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Target Name",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Challenge Details",
                    style: TextStyle(fontSize: 16, color: Palette.darkgrey),
                  )),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: challengesDetailsController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: "",
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              MyButton(
                text: "Update Challenge",
                bgColor: Palette.greenbtn,
                onClick: () {
                  CreateChallengesRemoteDataSourceImpl()
                      .challengeUpdate(
                    challengeType: 'GROUP',
                    createdBy: getIt<GlobalConfiguration>().profile.uID ?? "",
                    challengeTitle: challengesNameController.text.toString(),
                    challengeTarget: targetNameController.text.toString(),
                    challengeStartDate: startDateController.text,
                    challengeEndDate: endDateController.text,
                    challengeDetails:
                        challengesDetailsController.text.toString(),
                    creationDate: DateTime.now().toIso8601String(),
                    challengeId: widget.challengeId,
                  )
                      .then((value) {
                    if (value.status == 1) {
                      Navigator.pop(context, {"refresh": true});
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ManageChallengesScreens(
                      //               groupName: widget.groupName,
                      //               groupUid: widget.groupUid,
                      //             )));
                    } else {
                      Utils.showSnackBar(context, value.challengeUpdate!);
                    }
                  });
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
