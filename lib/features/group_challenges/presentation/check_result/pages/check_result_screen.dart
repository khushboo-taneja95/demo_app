import 'package:flutter/material.dart';
import 'package:tres_connect/core/themes/palette.dart';
import 'package:tres_connect/core/utility/DateUtility.dart';
import 'package:tres_connect/core/bloc/bloc.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/global_configuration.dart';
import 'package:tres_connect/features/group_challenges/presentation/check_result/bloc/check_result_bloc.dart';
import 'package:tres_connect/features/group_challenges/presentation/check_result/bloc/check_result_event.dart';
import 'package:tres_connect/features/group_challenges/presentation/check_result/bloc/check_result_state.dart';

class CheckResultScreen extends StatelessWidget {
  CheckResultScreen({super.key, required this.challengeTitle});
  String challengeTitle;

  @override
  Widget build(BuildContext context) {
    return CheckResultBody(
      challengeTitle: challengeTitle,
    );
  }
}

class CheckResultBody extends StatelessWidget {
  CheckResultBody({super.key, required this.challengeTitle});
  String challengeTitle;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckResultBloc()
        ..add(GetCheckResultClicked(
          uid: getIt<GlobalConfiguration>().profile.uID ?? "",
          //uid: 'ac6a5ffb-f2f0-11ec-a1de-42010a940005',
          challengeid: 1,
        )),
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              challengeTitle,
              style: const TextStyle(color: Colors.white),
            ),
            elevation: 0.0,
            backgroundColor: Palette.greenbtn,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: BlocBuilder<CheckResultBloc, CheckResultState>(
            builder: (context, state) {
              if (state is CheckResultLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                );
              } else if (state is CheckResultLoaded) {
                return _loadData(context, state.checkResult);
              } else {
                return const Center(
                  child: Text(
                    'Data not available',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
            },
          )),
    );
  }

  Widget _loadData(BuildContext context, checkResult) {
    return ListView(children: <Widget>[
      Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: ClipPath(
              clipper: ClippingClass(),
              child: Container(
                height: 130.0,
                decoration: const BoxDecoration(color: Palette.greenbtn),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 1),
                      blurRadius: 5,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ],
                  border: Border.all(color: Colors.white, width: 5),
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                ),
                child: Builder(builder: (context) {
                  String imgUrl = checkResult.badgeImage.toString();
                  if (imgUrl == '') {
                    return Image.asset(
                      "assets/images/place_holder.png",
                      width: 40,
                      height: 40,
                      color: Colors.orange,
                      fit: BoxFit.contain,
                    );
                  } else {
                    return Image.network(
                      imgUrl,
                      fit: BoxFit.cover,
                    );
                  }
                }),
              ),
            ),
          )
        ],
      ),
      Container(
        padding: const EdgeInsets.only(top: 32.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                color: Colors.white,
                elevation: 12,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Palette.green.withOpacity(0.2),
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30))),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Target",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            Builder(builder: (context) {
                              String dist =
                                  checkResult.targetAchieved.toString();
                              String finaldist = dist + ' KM';
                              return Text(finaldist);
                            }),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Builder(builder: (context) {
                            String dist = '';
                            dist = checkResult.challengeTarget.toString();
                            print('dist is$dist');
                            if (dist == 'null') {
                              dist = '0';
                            }
                            String finalTarget = dist + ' KM';
                            return Text(finalTarget);
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Card(
                color: Colors.white,
                elevation: 12,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Palette.green.withOpacity(0.2),
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30))),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Time Frame",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            Builder(builder: (context) {
                              String time = DateUtility.parseAndFormatDateTime(
                                  dateTimeString:
                                      checkResult.challengeEnddate.toString(),
                                  inputFormat: "yyyy-MM-dd'T'HH:mm:ss");
                              // checkResult.challengeEnddate.toString();

                              return Text(time);
                            })
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Card(
                color: Colors.white,
                elevation: 12,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Palette.green.withOpacity(0.2),
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30))),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Participants",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            Builder(builder: (context) {
                              String participants =
                                  checkResult.participants.toString();
                              return Text(participants);
                            })
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Card(
                color: Colors.white,
                elevation: 12,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Palette.green.withOpacity(0.2),
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30))),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Earn a badge",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            Text(
                                "It is a long establish fact that a reader will be distracted by the readable content of a page when looking at its layout.")
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(
                height: 2,
                color: Colors.grey,
              ),
              //const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Details",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                        "It is a long establish fact that a reader will be distracted by the readable content of a page when looking at its layout.")
                  ],
                ),
              ),
              /*
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 15,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Card(
                                      color: Colors.white,
                                      elevation: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 80,
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: Palette.green.withOpacity(0.2),
                                                  borderRadius: const BorderRadius.only(
                                                      topRight: Radius.circular(30),
                                                      bottomRight: Radius.circular(30))),
                                              child: Image.asset(
                                                "assets/images/time_frame.png",
                                                width: 35,
                                                height: 35,
                                                color: Palette.green,
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            const Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text("Time Frame",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black)),
                                                  Text("01 Dec - 30 Dec ")
                                                ],
                                              ),
                                            ),
                                            const Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text("100KM"),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                                */
            ],
          ),
        ),
      )
    ]);
  }
}

class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 80);
    path.quadraticBezierTo(
      size.width / 4,
      size.height,
      size.width / 2,
      size.height,
    );
    path.quadraticBezierTo(
      size.width - (size.width / 4),
      size.height,
      size.width,
      size.height - 80,
    );
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
