import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/routes/routes.dart';
import 'package:tres_connect/core/utility/ColorUtils.dart';
import 'package:tres_connect/core/utility/EncodeUtils.dart';
import 'package:tres_connect/core/utility/utils.dart';
import 'package:tres_connect/features/group_challenges/presentation/participants/bloc/participants_bloc.dart';
import 'package:tres_connect/global_configuration.dart';

class WinnerParticipants extends StatelessWidget {
  final String challegeId;
  final String challengeTitle;
  const WinnerParticipants(
      {super.key, required this.challegeId, required this.challengeTitle});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ParticipantsBloc()
        ..add(ParticipantClicked(
            pagesize: "3",
            id: challegeId,
            search: "",
            challengeId: challegeId,
            uid: getIt<GlobalConfiguration>().profile.uID ?? "")),
      child: WinnerParticipantsScreen(
        challengeTitle: challengeTitle,
        challegeId: challegeId,
      ),
    );
  }
}

class WinnerParticipantsScreen extends StatelessWidget {
  WinnerParticipantsScreen(
      {super.key, required this.challengeTitle, required this.challegeId});
  final String challengeTitle;
  final String challegeId;
  ScreenshotController WinnerParticipantsScreenshotsController =
      ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ParticipantsBloc, ParticipantState>(
        builder: (context, state) {
          if (state is ParticipantLoading) {
            return const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            );
          } else if (state is ParticipantLoaded) {
            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height,
                    ),
                    child: Screenshot(
                      controller: WinnerParticipantsScreenshotsController,
                      child: Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                          colors: [
                            Colors.purple,
                            Colors.purple,
                            Colors.purple,
                            Colors.purple
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0, 0, 0.6, 1],
                        )),
                        // color: Colors.purple,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.grey,
                                      )),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Leader Board",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          challengeTitle,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await WinnerParticipantsScreenshotsController
                                              .capture(
                                                  delay: const Duration(
                                                      milliseconds: 10))
                                          .then((Uint8List? image) async {
                                        if (image != null) {
                                          final directory =
                                              await getTemporaryDirectory();
                                          final imagePath = await File(
                                                  '${directory.path}/winner.png')
                                              .create();
                                          await imagePath.writeAsBytes(image);
                                          await Share.shareFiles(
                                              [imagePath.path]);
                                        }
                                      });
                                    },
                                    child: const Icon(
                                      Icons.share,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                state.getParticipants.length == 2 ||
                                        state.getParticipants.length == 3
                                    ? SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .33,
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              top: 250, left: 14),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 60,
                                                height: 60,
                                                child: CircleAvatar(
                                                  radius: 28,
                                                  backgroundColor: Colors.pink,
                                                  child: Builder(
                                                      builder: (context) {
                                                    return getImageWidget(
                                                        null,
                                                        state.getParticipants[1]
                                                            .fullname
                                                            .toString());
                                                  }),
                                                ),
                                              ),
                                              Builder(builder: (context) {
                                                state.getParticipants;
                                                String name = state
                                                    .getParticipants[1].fullname
                                                    .toString();
                                                return Text(
                                                  name,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                );
                                              }),
                                              const CircleAvatar(
                                                radius: 13,
                                                backgroundColor: Colors.amber,
                                                child: Text(
                                                  "2",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 25),
                                                width: 60,
                                                height: 150,
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    gradient:
                                                        const LinearGradient(
                                                      colors: [
                                                        Colors.purple,
                                                        Colors.white,
                                                        Colors.white,
                                                        Colors.purple
                                                      ],
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      stops: [0, 0, 0.6, 1],
                                                    ),
                                                    color: Colors.white
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    15),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    0),
                                                            topLeft:
                                                                Radius.circular(
                                                                    15),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    0))),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                                state.getParticipants.length == 1 ||
                                        state.getParticipants.length == 2 ||
                                        state.getParticipants.length == 3
                                    ? Builder(builder: (context) {
                                        state.getParticipants;
                                        String name = state
                                            .getParticipants[0].fullname
                                            .toString();
                                        return SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .33,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "assets/images/crown-solid.png",
                                                width: 60,
                                                height: 60,
                                              ),
                                              SizedBox(
                                                width: 80,
                                                height: 80,
                                                child: CircleAvatar(
                                                  radius: 38,
                                                  backgroundColor: Colors.pink,
                                                  child: getImageWidget(
                                                      null,
                                                      state.getParticipants[0]
                                                          .fullname
                                                          .toString()),
                                                ),
                                              ),
                                              Text(
                                                name,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 18),
                                              ),
                                              const CircleAvatar(
                                                radius: 17,
                                                backgroundColor: Colors.amber,
                                                child: Text(
                                                  "1",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 50),
                                                width: 60,
                                                height: 150,
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    gradient:
                                                        const LinearGradient(
                                                      colors: [
                                                        Colors.purple,
                                                        Colors.white,
                                                        Colors.white,
                                                        Colors.purple
                                                      ],
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      stops: [0, 0, 0.6, 1],
                                                    ),
                                                    color: Colors.white
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    15),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    0),
                                                            topLeft:
                                                                Radius.circular(
                                                                    15),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    0))),
                                              ),
                                            ],
                                          ),
                                        );
                                      })
                                    : const SizedBox(),
                                state.getParticipants.length == 3
                                    ? Builder(builder: (context) {
                                        state.getParticipants;
                                        String name = state
                                            .getParticipants[2].fullname
                                            .toString();
                                        return SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .33,
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                top: 250, right: 14),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 60,
                                                  height: 60,
                                                  child: getImageWidget(
                                                      null,
                                                      state.getParticipants[2]
                                                          .fullname
                                                          .toString()),
                                                ),
                                                Text(
                                                  name,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                ),
                                                const CircleAvatar(
                                                  radius: 13,
                                                  backgroundColor: Colors.amber,
                                                  child: Text(
                                                    "3",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 25),
                                                  width: 60,
                                                  height: 150,
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      gradient:
                                                          const LinearGradient(
                                                        colors: [
                                                          Colors.purple,
                                                          Colors.white,
                                                          Colors.white,
                                                          Colors.purple
                                                        ],
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                        stops: [0, 0, 0.6, 1],
                                                      ),
                                                      color: Colors.white
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              topRight: Radius
                                                                  .circular(15),
                                                              bottomRight: Radius
                                                                  .circular(0),
                                                              topLeft: Radius
                                                                  .circular(15),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      0))),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      })
                                    : const SizedBox()
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: Container(
                color: Colors.purple.shade600,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, Routes.participantsListScreen,
                          arguments: {"challengeId": challegeId});
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.purple.shade300),
                      child: const Center(
                          child: Text(
                        "View All Participants",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Winners"),
                centerTitle: true,
              ),
              body: const Center(
                child: Text("Something went wrong"),
              ),
            );
          }
        },
      ),
    );
  }

  Widget getImageWidget(String? imageUrl, String name) {
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return Image.network(
        imageUrl,
        height: 60,
        width: 60,
        fit: BoxFit.cover,
      );
    } else {
      return Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              color: ColorUtils.generateColorFromString(
                  EncodeUtils.decodeBase64(
                      getIt<GlobalConfiguration>().profile.firstName)),
              borderRadius: const BorderRadius.all(Radius.circular(60))),
          child: Center(
              child: Text(
            Utils.getInitials(name),
            style: const TextStyle(color: Colors.white, fontSize: 15),
            textAlign: TextAlign.center,
          )));
    }
  }
}
