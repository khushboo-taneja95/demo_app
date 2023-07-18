import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tres_connect/core/themes/palette.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../global_configuration.dart';
import '../../../data/models/get_all_badges_model.dart';
import 'bloc/all_badges_event.dart';
import 'bloc/all_badges_state.dart';
import 'bloc/all_bagdes_block.dart';

class BadgeScreenDesigns extends StatelessWidget {
  const BadgeScreenDesigns({super.key});

  @override
  Widget build(BuildContext context) {
    //return const BadgeScreenDesign();
    return BlocProvider(
      create: (context) => AllBadgesBloc()
        ..add(GetAllBadgesClicked(
          uid: getIt<GlobalConfiguration>().profile.uID ?? "",
          //uid: 'ac6a5ffb-f2f0-11ec-a1de-42010a940005',
          challengeid: 1,
          pageSize: 100,
          startIndex: 0,
        )),
      child: const Scaffold(
        body: BadgeScreenDesign(),
      ),
    );
  }
}

class BadgeScreenDesign extends StatefulWidget {
  const BadgeScreenDesign({super.key});

  @override
  State<BadgeScreenDesign> createState() => _BadgeScreenDesignState();
}

class _BadgeScreenDesignState extends State<BadgeScreenDesign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "All Badges",
          style: TextStyle(color: Palette.surface),
        ),
        backgroundColor: Colors.black,
      ),
      body: BlocBuilder<AllBadgesBloc, AllBadgesState>(
        builder: (context, state) {
          if (state is AllBadgesLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state is AllBadgesLoaded) {
            return _listofBages(context, state.getAllBadgeByUserId);
          } else {
            return SizedBox(
              width: 500,
              height: 200,
              child: Container(
                color: Colors.transparent,
                child: const Center(
                  child: Text(
                    'Badges not Available',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _listofBages(
      BuildContext context, List<GetAllBadgeByUserId> getAllBadgeByUserId) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Badges",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: getAllBadgeByUserId.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1,
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Image.asset(
                      //   "assets/images/addalarm.png",
                      //   width: 40,
                      //   height: 40,
                      // ),
                      Builder(builder: (context) {
                        String imagUrl =
                            getAllBadgeByUserId[index].image.toString();
                        if (imagUrl.isEmpty) {
                          return Image.asset(
                            "assets/images/addalarm.png",
                            width: 40,
                            height: 40,
                          );
                        } else {
                          return Image.network(
                            imagUrl,
                            fit: BoxFit.contain,
                            height: 40,
                            width: 40,
                          );
                        }
                      }),
                      const SizedBox(height: 10),
                      Builder(builder: (context) {
                        String dist = getAllBadgeByUserId[index]
                            .targetAchieved
                            .toString();
                        String finalDist = dist + ' KM';
                        return Text(
                          finalDist,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        );
                      }),
                      Builder(builder: (context) {
                        String title = getAllBadgeByUserId[index]
                            .challengeTitle
                            .toString();
                        return Text(
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        );
                      })
                    ],
                  ),
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Badges are rewarded for completing challenges & milestones.",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
