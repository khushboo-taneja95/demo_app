import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/routes/routes.dart';
import 'package:tres_connect/core/themes/palette.dart';
import 'package:tres_connect/core/utility/DateUtility.dart';
import 'package:tres_connect/features/group_challenges/data/models/get_challenges_model.dart';
import 'package:tres_connect/features/group_challenges/presentation/past_challenges/bloc/past_challenges_bloc.dart';
import 'package:tres_connect/global_configuration.dart';

class PastChallengesPage extends StatelessWidget {
  const PastChallengesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PastChallengesBloc()
        ..add(LoadPastChallengesEvent(
            uid: getIt<GlobalConfiguration>().profile.uID ?? "")),
      child: const PastChallengesBody(),
    );
  }
}

class PastChallengesBody extends StatelessWidget {
  const PastChallengesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: DefaultTabController(
        length: 4,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                height: 45,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(25.0)),
                child: TabBar(
                  indicator: BoxDecoration(
                      color: Palette.secondaryColor1,
                      borderRadius: BorderRadius.circular(25.0)),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(
                      text: 'ALL',
                    ),
                    Tab(
                      text: 'GLOBAL',
                    ),
                    Tab(
                      text: 'CORPORATE',
                    ),
                    Tab(
                      text: 'GROUP',
                    )
                  ],
                ),
              ),
              Expanded(
                  child: TabBarView(
                children: [
                  allPastChallengesList(),
                  globalList(),
                  corporateList(),
                  groupList(),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget allPastChallengesList() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<PastChallengesBloc, PastChallengesState>(
        builder: (context, state) {
          if (state is PastChallengesLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state is PastChallengesLoaded) {
            return CustomScrollView(
              slivers: [
                state.globalChallenges.isNotEmpty
                    ? SliverToBoxAdapter(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Palette.secondaryColor1.withOpacity(0.2),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          width: double.infinity,
                          height: 40,
                          padding: const EdgeInsets.only(left: 15, top: 10.0),
                          child: const Text(
                            'Global',
                            style: TextStyle(
                                color: Palette.secondaryColor1,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                      )
                    : const SliverToBoxAdapter(),
                getChallengeList(state.globalChallenges),
                state.corporateChallenges.isNotEmpty
                    ? SliverToBoxAdapter(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Palette.secondaryColor1.withOpacity(0.2),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          width: double.infinity,
                          height: 40,
                          padding: const EdgeInsets.only(left: 15, top: 10.0),
                          child: const Text(
                            'Corporate',
                            style: TextStyle(
                                color: Palette.secondaryColor1,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                      )
                    : const SliverToBoxAdapter(),
                getChallengeList(state.corporateChallenges),
                state.groupChallenges.isNotEmpty
                    ? SliverToBoxAdapter(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Palette.secondaryColor1.withOpacity(0.2),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          width: double.infinity,
                          height: 40,
                          padding: const EdgeInsets.only(left: 15, top: 10.0),
                          child: const Text(
                            'Group',
                            style: TextStyle(
                                color: Palette.secondaryColor1,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                      )
                    : const SliverToBoxAdapter(),
                getChallengeList(state.groupChallenges),
              ],
            );
          } else if (state is PastChallengesError) {
            return const SizedBox();
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget globalList() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<PastChallengesBloc, PastChallengesState>(
        builder: (context, state) {
          if (state is PastChallengesLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state is PastChallengesLoaded) {
            return CustomScrollView(
              slivers: [
                getChallengeList(state.globalChallenges),
              ],
            );
          } else if (state is PastChallengesError) {
            return const SizedBox();
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget corporateList() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<PastChallengesBloc, PastChallengesState>(
        builder: (context, state) {
          if (state is PastChallengesLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state is PastChallengesLoaded) {
            return CustomScrollView(
              slivers: [
                getChallengeList(state.corporateChallenges),
              ],
            );
          } else if (state is PastChallengesError) {
            return const SizedBox();
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget groupList() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<PastChallengesBloc, PastChallengesState>(
        builder: (context, state) {
          if (state is PastChallengesLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state is PastChallengesLoaded) {
            return CustomScrollView(
              slivers: [
                getChallengeList(state.groupChallenges),
              ],
            );
          } else if (state is PastChallengesError) {
            return const SizedBox();
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget getChallengeList(List<GetChallenges> challenges) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, Routes.challengeDetailsScreen);
            },
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        "${challenges.elementAt(index).challengeImage}",
                        width: 125,
                        height: 81,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 180,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${challenges.elementAt(index).challengeTitle}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "${DateUtility.diffInDays(DateUtility.parseDateTime(dateTimeString: challenges.elementAt(index).challengeEnddate ?? "", format: "yyyy-MM-ddT00:00:00"), DateUtility.parseDateTime(dateTimeString: challenges.elementAt(index).challengeStartdate ?? "", format: "yyyy-MM-ddT00:00:00"))} days",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            Text(
                              "${challenges.elementAt(index).target} KM",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                            ),
                            InkWell(
                              onTap: () {
                                if (challenges.elementAt(index).rank! >= 1 &&
                                    challenges.elementAt(index).rank! < 4) {
                                  Navigator.pushNamed(
                                      context, Routes.winnerParticipants,
                                      arguments: {
                                        "challengeId": challenges
                                            .elementAt(index)
                                            .id
                                            .toString(),
                                        "challengeTitle": challenges
                                            .elementAt(index)
                                            .challengeTitle,
                                      });
                                } else {
                                  Navigator.pushNamed(
                                      context, Routes.checkResultScreens,
                                      arguments: {
                                        "challengeTitle": challenges
                                            .elementAt(index)
                                            .challengeTitle,
                                      });
                                }
                              },
                              child: CircleAvatar(
                                  radius: 17,
                                  backgroundColor: Colors.orange,
                                  child: Image.asset(
                                    "assets/images/crown-solid.png",
                                    color: Colors.white,
                                    width: 20,
                                    height: 20,
                                  )),
                            ),
                          ],
                        ),
                        Text(
                          "Your rank is #${challenges.elementAt(index).rank} of ${challenges.elementAt(index).participants} Participants",
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: const CircleAvatar(
                                radius: 17,
                                backgroundColor: Colors.red,
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                )),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }, childCount: challenges.length),
    );
  }
}
