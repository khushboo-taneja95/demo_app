import 'package:flutter/material.dart';
import 'package:tres_connect/core/bloc/bloc.dart';
import 'package:tres_connect/core/routes/routes.dart';
import 'package:tres_connect/core/themes/palette.dart';
import 'package:tres_connect/core/utility/DateUtility.dart';
import 'package:tres_connect/features/group_challenges/data/models/get_challenges_model.dart';
import 'package:tres_connect/features/group_challenges/presentation/challenges_details/pages/challenges_details.dart';
import 'package:tres_connect/features/group_challenges/presentation/challenges_list/bloc/ongoing_challenges_bloc.dart';
import 'package:tres_connect/features/group_challenges/presentation/challenges_list/widgets/past_challenges_widget.dart';
import 'package:tres_connect/features/group_challenges/presentation/past_challenges/pages/past_challenges_screen.dart';

class ChallengeListPage extends StatelessWidget {
  const ChallengeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OnGoingChallengeBloc()..add(const OnGoingChallengeLoadEvent()),
      child: const Scaffold(
        body: ChallengeListBody(),
      ),
    );
  }
}

class ChallengeListBody extends StatefulWidget {
  const ChallengeListBody({Key? key}) : super(key: key);
  @override
  _ChallengeListBodyState createState() => _ChallengeListBodyState();
}

class _ChallengeListBodyState extends State<ChallengeListBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Challenge",
              style: TextStyle(color: Palette.surface),
            ),
            backgroundColor: Colors.black,
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 45,
                child: TabBar(
                  labelColor: Palette.secondaryColor1,
                  unselectedLabelColor: Colors.black,
                  indicatorColor: Colors.transparent,
                  tabs: [
                    Tab(
                      text: 'Ongoing Challenges',
                    ),
                    Tab(
                      text: 'Past Challenges',
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: TabBarView(
                children: [ongoingChallenges(), const PastChallengesPage()],
              ))
            ],
          )),
    );
  }

  Widget ongoingChallenges() {
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
                  allOnGoingChallengesList(),
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

  Widget allOnGoingChallengesList() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<OnGoingChallengeBloc, OnGoingChallengeState>(
        builder: (context, state) {
          if (state is OnGoingChallengeLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state is OnGoingChallengeLoaded) {
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
                getOnGoingChallengesList(context, state.globalChallenges),
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
                getOnGoingChallengesList(context, state.corporateChallenges),
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
                getOnGoingChallengesList(context, state.groupChallenges),
              ],
            );
          } else if (state is OnGoingChallengeError) {
            return const SizedBox();
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget getOnGoingChallengesList(
      BuildContext context, List<GetChallenges> challenges) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: InkWell(
            onTap: () async {
              final data = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChallengeDetailsPage(
                    challege: challenges[index],
                  ),
                ),
              );
              if (data) {
                BlocProvider.of<OnGoingChallengeBloc>(context)
                    .add(const OnGoingChallengeLoadEvent());
              }
            },
            child: Card(
              child: Row(
                children: [
                  challenges[index].challengeImage != null &&
                          challenges[index].challengeImage!.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              minHeight: 80,
                              maxWidth: 125,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                challenges[index].challengeImage.toString(),
                                width: 125,
                                height: 81,
                              ),
                            ),
                          ),
                        )
                      : Image.asset(
                          "assets/images/place_holder.png",
                          width: 125,
                          height: 81,
                        ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${challenges[index].challengeTitle}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          DateUtility.parseAndFormatDateTime(
                              dateTimeString:
                                  challenges[index].challengeEnddate,
                              inputFormat: "yyyy-MM-dd'T'HH:mm:ss"),
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        const SizedBox(height: 5),
                        challenges.elementAt(index).groupName!.isNotEmpty ||
                                challenges.elementAt(index).groupName == null
                            ? Row(
                                children: [
                                  const Icon(
                                    Icons.groups,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      '${challenges[index].groupName}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        const SizedBox(height: 5),
                        Text(
                          '${challenges[index].participants} Participants',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }, childCount: challenges.length),
    );
  }

  Widget globalList() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<OnGoingChallengeBloc, OnGoingChallengeState>(
        builder: (context, state) {
          if (state is OnGoingChallengeLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state is OnGoingChallengeLoaded) {
            return CustomScrollView(
              slivers: [
                getOnGoingChallengesList(context, state.globalChallenges),
              ],
            );
          } else if (state is OnGoingChallengeError) {
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
      child: BlocBuilder<OnGoingChallengeBloc, OnGoingChallengeState>(
        builder: (context, state) {
          if (state is OnGoingChallengeLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state is OnGoingChallengeLoaded) {
            return CustomScrollView(
              slivers: [
                getOnGoingChallengesList(context, state.corporateChallenges),
              ],
            );
          } else if (state is OnGoingChallengeError) {
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
      child: BlocBuilder<OnGoingChallengeBloc, OnGoingChallengeState>(
        builder: (context, state) {
          if (state is OnGoingChallengeLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state is OnGoingChallengeLoaded) {
            return CustomScrollView(
              slivers: [
                getOnGoingChallengesList(context, state.groupChallenges),
              ],
            );
          } else if (state is OnGoingChallengeError) {
            return const SizedBox();
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
