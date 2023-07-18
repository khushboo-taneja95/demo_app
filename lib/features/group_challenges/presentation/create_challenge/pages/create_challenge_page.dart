import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tres_connect/core/bloc/bloc.dart';
import 'package:tres_connect/core/themes/palette.dart';
import 'package:tres_connect/core/utility/DateUtility.dart';
import 'package:tres_connect/features/group_challenges/presentation/create_challenge/bloc/create_challenges_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/utility/utils.dart';
import 'package:tres_connect/features/group_challenges/presentation/create_challenge/widgets/upload_badges.dart';
import 'package:tres_connect/global_configuration.dart';
import 'package:tres_connect/widgets/my_dialog.dart';
import 'package:tres_connect/widgets/tres_btn.dart';
import 'package:image/image.dart' as img;

class CreateChallengePage extends StatefulWidget {
  final File? file;
  final String? challengesName;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? targetName;
  final String? challengesDetails;
  final String groupName;
  final String groupUid;

  const CreateChallengePage(
      {super.key,
      this.file,
      this.challengesName,
      this.startDate,
      this.endDate,
      this.targetName,
      this.challengesDetails,
      required this.groupName,
      required this.groupUid});

  @override
  State<CreateChallengePage> createState() => _CreateChallengePageState();
}

class _CreateChallengePageState extends State<CreateChallengePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateChallengeBloc(),
      child: CreateChallengeBody(
        Rank: '',
        groupName: widget.groupName,
        groupUid: widget.groupUid,
      ),
    );
  }
}

class CreateChallengeBody extends StatefulWidget {
  final String groupName;
  final String groupUid;
  const CreateChallengeBody({
    super.key,
    required this.groupName,
    required this.groupUid,
    required this.Rank,
  });
  final String Rank;

  @override
  State<CreateChallengeBody> createState() => _CreateChallengeBodyState();
}

class _CreateChallengeBodyState extends State<CreateChallengeBody> {
  late File? _imageFile = null;
  String imagePath = "";
  TextEditingController challengesNameController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController targetNameController = TextEditingController();
  TextEditingController challengesDetailsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? file;

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  Map<String, dynamic>? firstBadge = null;
  Map<String, dynamic>? secondBadge = null;
  Map<String, dynamic>? thirdBadge = null;
  Map<String, dynamic>? completionBadge = null;

  @override
  void initState() {
    startDateController.text = "";
    endDateController.text = "";
    // if (kDebugMode) {
    //   loadTestData();
    // }

    super.initState();
  }

  // void loadTestData() {
  //   challengesNameController.text = "Test Challenge";
  //   startDateController.text = DateUtility.formatDateTime(
  //       dateTime: DateTime.now(), outputFormat: "yyyy-MM-dd");
  //   endDateController.text = DateUtility.formatDateTime(
  //       dateTime: DateTime.now().add(const Duration(days: 7)),
  //       outputFormat: "yyyy-MM-dd");
  //   targetNameController.text = "25";
  //   challengesDetailsController.text = "Test Details";
  // }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateChallengeBloc, CreateChallengeState>(
      listener: (ctx, state) {
        if (state is CreateChallengesLoaded) {
          showDialog(
              context: context,
              builder: (context) => BasicDialog(
                    title: "Challenge Created Successfully",
                    onOkPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context, {"refresh": true});
                    },
                    description: '',
                  ));
        } else if (state is CreateChallengeError) {
          showDialog(
              context: context,
              builder: (context) => BasicDialog(
                    title: "Fail to upload new challenges",
                    onOkPressed: () {
                      Navigator.pop(context, {"refresh": true});
                    },
                    description: '',
                  ));
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            "Create Challenge",
            style: TextStyle(color: Palette.surface),
          ),
          backgroundColor: Colors.black,
        ),
        body: BlocBuilder<CreateChallengeBloc, CreateChallengeState>(
            builder: (context, state) {
          if (state is CreateChallengeLoading) {
            return const Center(
                child: CircularProgressIndicator(
              strokeWidth: 2,
            ));
          } else if (state is CreateChallengeInitial) {
            return BlocBuilder<CreateChallengeBloc, CreateChallengeState>(
              builder: (context, state) {
                if (state is CreateChallengeLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  );
                } else if (state is CreateChallengeInitial) {
                  return GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(children: [
                            const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Challenge Name",
                                  style: TextStyle(
                                      fontSize: 16, color: Palette.darkgrey),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter challenge name';
                                }
                              },
                              controller: challengesNameController,
                              decoration: const InputDecoration(
                                hintText: "Enter Challenge Name",
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Start Date",
                                  style: TextStyle(
                                      fontSize: 16, color: Palette.darkgrey),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please select start date';
                                }
                              },
                              readOnly: true,
                              controller: startDateController,
                              keyboardType: TextInputType.datetime,
                              onChanged: (value) {},
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 365)));
                                if (pickedDate != null) {
                                  startDate = pickedDate;
                                  String formattedDate =
                                      DateFormat('dd-MMM-yyyy')
                                          .format(pickedDate);
                                  setState(() {
                                    startDateController.text = formattedDate;
                                  });
                                } else {}
                              },
                              decoration: const InputDecoration(
                                  hintText: "Select Start Date",
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
                                  style: TextStyle(
                                      fontSize: 16, color: Palette.darkgrey),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please select end date';
                                }
                              },
                              readOnly: true,
                              controller: endDateController,
                              keyboardType: TextInputType.datetime,
                              onChanged: (value) {},
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate:
                                        startDate.add(const Duration(days: 2)),
                                    firstDate:
                                        startDate.add(const Duration(days: 2)),
                                    lastDate: DateTime(2100));
                                if (pickedDate != null) {
                                  endDate = pickedDate;
                                  String formattedDate =
                                      DateFormat('dd-MMM-yyyy')
                                          .format(pickedDate);
                                  setState(() {
                                    endDateController.text = formattedDate;
                                  });
                                } else {}
                              },
                              decoration: const InputDecoration(
                                  hintText: "Select End Date",
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
                                  style: TextStyle(
                                      fontSize: 16, color: Palette.darkgrey),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter target name';
                                }
                              },
                              keyboardType: TextInputType.number,
                              controller: targetNameController,
                              decoration: const InputDecoration(
                                hintText: "Enter Target",
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Upload Badges",
                                  style: TextStyle(
                                      fontSize: 16, color: Palette.darkgrey),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 180,
                              child: GridView.count(
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,
                                childAspectRatio: (2 / 1),
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      final data = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const UploadBadgeDesign(
                                            forRank: 1,
                                          ),
                                        ),
                                      );
                                      setState(() {
                                        firstBadge = data;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: firstBadge == null
                                          ? DottedBorder(
                                              borderType: BorderType.RRect,
                                              radius: const Radius.circular(10),
                                              dashPattern: const [10, 10],
                                              color: Colors.grey,
                                              strokeWidth: 2,
                                              child: const Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.add),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("1"),
                                                        Text(
                                                          "st",
                                                          style: TextStyle(
                                                              fontSize: 9),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text("Winner"),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Image.network(
                                              firstBadge!['badgeImage']),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      final data = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const UploadBadgeDesign(
                                            forRank: 2,
                                          ),
                                        ),
                                      );
                                      setState(() {
                                        secondBadge = data;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: secondBadge == null
                                          ? DottedBorder(
                                              borderType: BorderType.RRect,
                                              radius: const Radius.circular(10),
                                              dashPattern: const [10, 10],
                                              color: Colors.grey,
                                              strokeWidth: 2,
                                              child: const Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.add),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("2"),
                                                        Text(
                                                          "nd",
                                                          style: TextStyle(
                                                              fontSize: 9),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text("Winner"),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Image.network(
                                              secondBadge!['badgeImage']),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      final data = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const UploadBadgeDesign(
                                            forRank: 3,
                                          ),
                                        ),
                                      );
                                      setState(() {
                                        thirdBadge = data;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: thirdBadge == null
                                          ? DottedBorder(
                                              borderType: BorderType.RRect,
                                              radius: const Radius.circular(10),
                                              dashPattern: const [10, 10],
                                              color: Colors.grey,
                                              strokeWidth: 2,
                                              child: const Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.add),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("3"),
                                                        Text(
                                                          "rd",
                                                          style: TextStyle(
                                                              fontSize: 9),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text("Winner"),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Image.network(
                                              thirdBadge!['badgeImage']),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      final data = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const UploadBadgeDesign(
                                            forRank: -1,
                                          ),
                                        ),
                                      );
                                      setState(() {
                                        completionBadge = data;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: completionBadge == null
                                          ? DottedBorder(
                                              borderType: BorderType.RRect,
                                              radius: const Radius.circular(10),
                                              dashPattern: const [10, 10],
                                              color: Colors.grey,
                                              strokeWidth: 2,
                                              child: const Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.add),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            "Completion Badge"),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Image.network(
                                              completionBadge!['badgeImage']),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Challenge Details",
                                  style: TextStyle(
                                      fontSize: 16, color: Palette.darkgrey),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter challenge details';
                                }
                              },
                              maxLines: 5,
                              controller: challengesDetailsController,
                              decoration: const InputDecoration(
                                hintText: "Enter Challenge Details",
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            InkWell(onTap: () async {
                              if (Platform.isIOS) {
                                _showPopupDialog();
                              } else {
                                final pickedFile = await FilePicker.platform
                                    .pickFiles(
                                        type: FileType.custom,
                                        allowedExtensions: ['jpg', 'png']);
                                if (pickedFile != null &&
                                    pickedFile.files.isNotEmpty) {
                                  setState(() {
                                    file = File(pickedFile.files.single.path!);
                                  });
                                }
                              }
                            }, child: Builder(builder: (context) {
                              if (file == null) {
                                return DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(20),
                                  dashPattern: const [10, 10],
                                  color: Colors.grey,
                                  strokeWidth: 2,
                                  padding: const EdgeInsets.all(6),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12)),
                                    child: SizedBox(
                                      height: 140,
                                      width: double.infinity,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Image.asset(
                                                "assets/images/upload.png",
                                                height: 80,
                                                width: 80,
                                              ),
                                              const Text("Upload Image")
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Image.file(
                                  file!,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                );
                              }
                            })),
                            const SizedBox(
                              height: 15,
                            ),
                            MyButton(
                                text: "Create Challenge",
                                bgColor: Palette.greenbtn,
                                onClick: () {
                                  if (file == null) {
                                    Utils.showToast("Please upload image");
                                    return;
                                  }
                                  if (startDate.isAfter(endDate)) {
                                    Utils.showToast(
                                        "Start date should be less than end date");
                                    return;
                                  }
                                  if (DateUtility.diffInDays(
                                          endDate, startDate) <
                                      2) {
                                    Utils.showToast(
                                        "Challenge should be of minimum 2 days");
                                    return;
                                  }
                                  if (_formKey.currentState?.validate() ==
                                      true) {
                                    context
                                        .read<CreateChallengeBloc>()
                                        .add(CreateChallengeClicked(
                                          challengeDetails:
                                              challengesDetailsController.text
                                                  .toString(),
                                          challengeEndDate:
                                              endDateController.text.toString(),
                                          challengeImage: file,
                                          challengeStartDate:
                                              startDateController.text
                                                  .toString(),
                                          challengeTarget: targetNameController
                                              .text
                                              .toString(),
                                          challengeTitle:
                                              challengesNameController.text
                                                  .toString(),
                                          challengeType: 'GROUP',
                                          createdBy:
                                              getIt<GlobalConfiguration>()
                                                      .profile
                                                      .uID ??
                                                  "",
                                          creationDate:
                                              DateTime.now().toIso8601String(),
                                          badge_completion:
                                              completionBadge?["badgeId"]
                                                      .toString() ??
                                                  "",
                                          badge_one: firstBadge?["badgeId"]
                                                  .toString() ??
                                              "",
                                          badge_three: thirdBadge?["badgeId"]
                                                  .toString() ??
                                              "",
                                          badge_two: secondBadge?["badgeId"]
                                                  .toString() ??
                                              "",
                                          group_name: widget.groupName,
                                          group_uid: widget.groupUid,
                                        ));
                                  }
                                }),
                            const SizedBox(
                              height: 30,
                            )
                          ]),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            );
          } else if (state is CreateChallengeLoaded) {
            return const Center(child: Text("Challenge created successfully"));
          } else {
            return const SizedBox();
          }
        }),
      ),
    );
  }

  Future<void> _showPopupDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose an option'),
          actions: [
            TextButton(
              onPressed: () {
                _takePhoto(ImageSource.gallery);
                Navigator.of(context).pop();
              },
              child: const Text('Gallery'),
            ),
            TextButton(
              onPressed: () {
                _takePhoto(ImageSource.camera);
                Navigator.of(context).pop();
              },
              child: const Text('Camera'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _takePhoto(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
        source: source, imageQuality: 25, maxHeight: 1024, maxWidth: 1024);
    if (pickedFile == null) return;
    final img.Image? capturedImage =
        img.decodeImage(await File(pickedFile.path).readAsBytes());
    if (capturedImage == null) return;
    final img.Image orientedImage = img.bakeOrientation(capturedImage);
    final image =
        await File(pickedFile.path).writeAsBytes(img.encodeJpg(orientedImage));
    //final File croppedImage = await cropImage(File(pickedFile.path));
    setState(() {
      imagePath = pickedFile.path;
      _imageFile = image;
      file = image;
    });
  }
}
