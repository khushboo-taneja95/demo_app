import 'dart:math';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tres_connect/core/bloc/bloc.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/themes/palette.dart';
import 'package:tres_connect/core/utility/DateUtility.dart';
import 'package:tres_connect/core/utility/EncodeUtils.dart';
import 'package:tres_connect/features/group_challenges/data/models/get_challenges_model.dart';
import 'package:tres_connect/features/group_challenges/presentation/challenges_details/bloc/challenges_details_bloc.dart';
import 'package:tres_connect/global_configuration.dart';
import 'package:tres_connect/widgets/my_text_field.dart';
import 'package:tres_connect/widgets/tres_btn.dart';
import 'package:tres_connect/features/group_challenges/presentation/participants/widgets/participants_list.dart';

class ChallengeDetailsPage extends StatelessWidget {
  final GetChallenges challege;

  const ChallengeDetailsPage({
    Key? key,
    required this.challege,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChallengeDetailsBloc()
        ..add(ChallengeDetailsLoadedEvent(
            uid: getIt<GlobalConfiguration>().profile.uID ?? "",
            challengeId: challege.id.toString(),
            isJoined: challege.isJoined ?? false)),
      child: ChallengeDetailsBody(
        challege: challege,
      ),
    );
  }
}

class ChallengeDetailsBody extends StatefulWidget {
  final GetChallenges challege;

  const ChallengeDetailsBody({
    Key? key,
    required this.challege,
  }) : super(key: key);

  @override
  State<ChallengeDetailsBody> createState() => _ChallengeDetailsBodyState();
}

class _ChallengeDetailsBodyState extends State<ChallengeDetailsBody> {
  bool joined = false;
  String? days = '';

  @override
  void initState() {
    super.initState();

    //Second approach
    calculateDays(widget.challege.challengeEnddate.toString(),
            widget.challege.challengeStartdate.toString())
        .then((value) {
      print("DateTime: ${DateTime.now()}");
      print("challengeEnddate: ${widget.challege.challengeEnddate.toString()}");

      setState(() {
        if (value == '1') {
          calculateInHours(widget.challege.challengeEnddate.toString(),
                  widget.challege.challengeStartdate.toString())
              .then((value) {
            print(value.toString());
            setState(() {
              days = '$value Hours.';
            });
            return value;
          });
        } else {
          days = '$value Days.';
        }
      });
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChallengeDetailsBloc, ChallengeDetailsState>(
      listener: (context, state) {},
      child: BlocBuilder<ChallengeDetailsBloc, ChallengeDetailsState>(
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              Navigator.pop(context, joined);
              return false;
            },
            child: Scaffold(
                backgroundColor: Colors.grey[200],
                appBar: AppBar(
                  title: Text(
                    widget.challege.challengeTitle.toString(),
                    style: const TextStyle(color: Palette.surface),
                  ),
                  actions: [
                    // state is ChallengeDetailsLoaded && state.isJoined
                    //     ? InkWell(
                    //         onTap: () {
                    //           _modalBottomSheetMenu(context);
                    //         },
                    //         child: const Row(
                    //           children: [
                    //             Icon(
                    //               Icons.add,
                    //               color: Colors.white,
                    //               size: 14,
                    //             ),
                    //             Text(
                    //               "Add",
                    //               style: TextStyle(
                    //                   fontSize: 13, color: Colors.white),
                    //             ),
                    //             SizedBox(
                    //               width: 10,
                    //             )
                    //           ],
                    //         ),
                    //       )
                    //     : const SizedBox(),
                  ],
                  backgroundColor: Colors.black,
                ),
                body: BlocBuilder<ChallengeDetailsBloc, ChallengeDetailsState>(
                  builder: (context, state) {
                    if (state is ChallengeDetailsLoaded ||
                        state is ChallengeDetailsInitial) {
                      return SingleChildScrollView(
                        child: Stack(
                          children: [
                            widget.challege.challengeImage != null &&
                                    widget.challege.challengeImage!.isNotEmpty
                                ? Image.network(
                                    widget.challege.challengeImage.toString(),
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height *
                                        .25,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    "assets/images/place_holder.png",
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height *
                                        .25,
                                    fit: BoxFit.cover,
                                  ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 140),
                                    padding: const EdgeInsets.fromLTRB(
                                        0, 10, 10, 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(13),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: const Offset(0, 17),
                                          blurRadius: 23,
                                          spreadRadius: -13,
                                          color: Palette.secondaryColor1
                                              .withOpacity(0.2),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        state is ChallengeDetailsLoaded &&
                                                state.isJoined
                                            ? BlocBuilder<ChallengeDetailsBloc,
                                                ChallengeDetailsState>(
                                                builder: (context, state) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  "Welcome ${EncodeUtils.decodeBase64(getIt<GlobalConfiguration>().profile.firstName)}",
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .black)),
                                                              Text(
                                                                  "Great to have you on board ! \nEnd in ${days} ")
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 20),
                                                        Builder(
                                                            builder: (context) {
                                                          double percent = 0;
                                                          try {
                                                            percent = (widget
                                                                        .challege
                                                                        .distance ??
                                                                    0) /
                                                                (widget.challege
                                                                        .target ??
                                                                    0);
                                                          } catch (e) {
                                                            debugPrint(
                                                                e.toString());
                                                          }

                                                          return Container(
                                                            child:
                                                                CircularPercentIndicator(
                                                              radius: 42.0,
                                                              lineWidth: 4.0,
                                                              animation: true,
                                                              percent: min(
                                                                  percent, 1),
                                                              center: Center(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Container(
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                              "${widget.challege.distance} KM",
                                                                              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
                                                                          const Divider(
                                                                            endIndent:
                                                                                10,
                                                                            indent:
                                                                                10,
                                                                            height:
                                                                                0,
                                                                          ),
                                                                          Text(
                                                                              "${widget.challege.target?.toStringAsFixed(0)}KM",
                                                                              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10)),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              circularStrokeCap:
                                                                  CircularStrokeCap
                                                                      .round,
                                                              progressColor: Palette
                                                                  .progressColor,
                                                            ),
                                                          );
                                                        })
                                                      ],
                                                    ),
                                                  );
                                                },
                                              )
                                            : const SizedBox(),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Container(
                                              width: 80,
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: Palette.green
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  30),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  30))),
                                              child: Image.asset(
                                                "assets/images/bullseye.png",
                                                width: 35,
                                                height: 35,
                                                color: Palette.green,
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Text("Target",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black)),
                                                  Text(widget.challege.target
                                                      .toString())
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          children: [
                                            Container(
                                              width: 80,
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: Palette.green
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  30),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  30))),
                                              child: Image.asset(
                                                "assets/images/time_frame.png",
                                                width: 35,
                                                height: 35,
                                                color: Palette.green,
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Text("Time Frame",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black)),
                                                  Text(
                                                    "${DateUtility.parseAndFormatDateTime(dateTimeString: widget.challege.challengeStartdate, inputFormat: "yyyy-MM-dd'T'HH:mm:ss", outputFormat: "dd MMM yyyy")} - ${DateUtility.parseAndFormatDateTime(dateTimeString: widget.challege.challengeEnddate, inputFormat: "yyyy-MM-dd'T'HH:mm:ss", outputFormat: "dd MMM yyyy")}",
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ParticipantsPage(
                                                  challengeId: widget
                                                      .challege.id
                                                      .toString(),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 80,
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    color: Palette.green
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    30),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    30))),
                                                child: Image.asset(
                                                  "assets/images/participants.png",
                                                  width: 35,
                                                  height: 35,
                                                  color: Palette.green,
                                                ),
                                              ),
                                              const SizedBox(width: 20),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Text("Participants",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black)),
                                                    Text(
                                                        "${widget.challege.participants} Participants")
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Expanded(
                                                              child: Text(
                                                                "Earn a badge",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topRight,
                                                                  child: Icon(Icons
                                                                      .close)),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        const Divider(),
                                                        ConstrainedBox(
                                                            constraints:
                                                                BoxConstraints(
                                                              maxHeight: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.4,
                                                            ),
                                                            child: widget
                                                                    .challege
                                                                    .badges!
                                                                    .isNotEmpty
                                                                ? ListView
                                                                    .separated(
                                                                    shrinkWrap:
                                                                        true,
                                                                    itemCount: widget
                                                                        .challege
                                                                        .badges!
                                                                        .length,
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                                context,
                                                                            int index) {
                                                                      return Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              widget.challege.badges!.elementAt(index).rank == -1
                                                                                  ? const Text("Completion Badge")
                                                                                  : Row(
                                                                                      children: [
                                                                                        Text(
                                                                                          widget.challege.badges!.elementAt(index).rank.toString(),
                                                                                        ),
                                                                                        Builder(builder: (context) {
                                                                                          String rank = widget.challege.badges!.elementAt(index).rank.toString();
                                                                                          if (widget.challege.badges!.elementAt(index).rank == 1) {
                                                                                            rank = 'st';
                                                                                          } else if (widget.challege.badges!.elementAt(index).rank == 2) {
                                                                                            rank = 'nd';
                                                                                          } else if (widget.challege.badges!.elementAt(index).rank == 3) {
                                                                                            rank = 'rd';
                                                                                          }

                                                                                          return Text(
                                                                                            rank,
                                                                                            style: TextStyle(fontSize: 9),
                                                                                          );
                                                                                        }),
                                                                                        const SizedBox(
                                                                                          width: 5,
                                                                                        ),
                                                                                        const Text("Winner"),
                                                                                      ],
                                                                                    ),
                                                                            ],
                                                                          ),
                                                                          Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(5),
                                                                              boxShadow: [
                                                                                BoxShadow(
                                                                                  offset: const Offset(0, 1),
                                                                                  blurRadius: 5,
                                                                                  color: Colors.black.withOpacity(0.3),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            child:
                                                                                ConstrainedBox(
                                                                              constraints: const BoxConstraints(
                                                                                minHeight: 40,
                                                                                maxWidth: 40,
                                                                              ),
                                                                              child: Image.network(
                                                                                widget.challege.badges?.elementAt(index).badgeImage ?? "",
                                                                                width: 40,
                                                                                height: 40,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                    separatorBuilder:
                                                                        (BuildContext
                                                                                context,
                                                                            int index) {
                                                                      return const Divider();
                                                                    },
                                                                  )
                                                                : const Text(
                                                                    " Badge is Not Available")),
                                                      ],
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 80,
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    color: Palette.green
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    30),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    30))),
                                                child: Image.asset(
                                                  "assets/images/earn_badge.png",
                                                  width: 35,
                                                  height: 35,
                                                  color: Palette.green,
                                                ),
                                              ),
                                              const SizedBox(width: 20),
                                              const Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text("Earn a badge",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black)),
                                                    Text(
                                                        "You will earn a badge for completing this challenge. Click to see the badge.")
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const Divider(
                                          height: 2,
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                "Details",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                              Text(widget.challege
                                                      .challengeDetails ??
                                                  "")
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (state is ChallengeDetailsError) {
                      return Center(child: Text(state.message));
                    } else if (state is ChallengeDetailsLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      );
                    }
                  },
                ),
                bottomNavigationBar:
                    state is ChallengeDetailsLoaded && state.isJoined
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: MyButton(
                              text: "Leave Challenge",
                              bgColor: Palette.red,
                              onClick: () {
                                leavePopUp(context);
                              },
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Builder(builder: (context) {
                              //  Text(
                              //    "${DateUtility.parseAndFormatDateTime(dateTimeString: widget.challege.challengeStartdate, inputFormat: "yyyy-MM-dd'T'HH:mm:ss", outputFormat: "dd MMM yyyy")} - ${DateUtility.parseAndFormatDateTime(dateTimeString: widget.challege.challengeEnddate, inputFormat: "yyyy-MM-dd'T'HH:mm:ss", outputFormat: "dd MMM yyyy")}",
                              //     )
                              DateTime startDate = DateUtility.parseDateTime(
                                  dateTimeString:
                                      widget.challege.challengeStartdate ?? "",
                                  format: "yyyy-MM-ddT00:00:00");
                              if (startDate.isAfter(DateTime.now())) {
                                return MyButton(
                                  text:
                                      "Starts on ${DateUtility.formatDateTime(dateTime: startDate, outputFormat: "dd MMM")}",
                                  bgColor: Colors.grey,
                                  onClick: () {
                                    //_joinChallengedClicked();
                                  },
                                );
                              } else {
                                return MyButton(
                                  text: "Join Challenge",
                                  bgColor: Palette.greenbtn,
                                  onClick: () {
                                    _joinChallengedClicked();
                                  },
                                );
                              }
                            }),
                          )),
          );
        },
      ),
    );
  }

  leavePopUp(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Ok"),
      onPressed: () {
        context.read<ChallengeDetailsBloc>().add(LeaveChallengeClicked(
            challengeId: widget.challege.id.toString(),
            participantUid: getIt<GlobalConfiguration>().profile.uID ?? ""));
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      content: const Text("Are you sure you want to leave challenges?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _joinChallengedClicked() {
    // print("BACKEND");
    // print(widget.challege.challengeEnddate);
    // print("DATETIME NOW");
    // print(DateTime.now());
    context.read<ChallengeDetailsBloc>().add(ChallengeDetailsClicked(
        challengeId: widget.challege.id.toString(),
        uid: getIt<GlobalConfiguration>().profile.uID ?? ""));
    joined = true;
  }
}

void _modalBottomSheetMenu(BuildContext context) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (builder) {
        return Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Enter Distance Details",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Daily Steps",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MyTextField(
                            labelText: "Enter Steps",
                            keyboardType: TextInputType.phone,
                            onChanged: (text) {}),
                        const SizedBox(
                          height: 10,
                        ),
                        const Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "OR",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 15),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Distance Covered",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MyTextField(
                            labelText: "Enter Distance",
                            keyboardType: TextInputType.phone,
                            onChanged: (text) {}),
                        const SizedBox(
                          height: 20,
                        ),
                        MyButton(text: "Save", onClick: () {}),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        );
      });
}

Future<String> calculateDays(String startDate, String endDate) async {
  DateTime dt1 = DateTime.parse(startDate);
  DateTime dt2 = DateTime.parse(endDate);
  Duration diff = dt1.difference(dt2);
  return diff.inDays.toString();
}

Future<String> calculateInHours(String startDate, String endDate) async {
  DateTime dt1 = DateTime.parse(startDate);
  DateTime dt2 = DateTime.parse(endDate);
  Duration diff = dt1.difference(dt2);
  return diff.inHours.toString();
}
