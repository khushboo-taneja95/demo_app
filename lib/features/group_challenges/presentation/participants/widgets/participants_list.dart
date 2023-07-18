import 'package:flutter/material.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/routes/routes.dart';
import 'package:tres_connect/core/themes/palette.dart';
import 'package:tres_connect/core/bloc/bloc.dart';
import 'package:tres_connect/features/group_challenges/data/models/get_participant_model.dart';
import 'package:tres_connect/features/group_challenges/presentation/participants/bloc/participants_bloc.dart';
import 'package:tres_connect/global_configuration.dart';

import '../../likes_screen/bloc/liked_list_bloc.dart';
import '../../likes_screen/pages/Page/like_screen.dart';

class ParticipantsPage extends StatelessWidget {
  final String challengeId;
  ParticipantsPage({Key? key, required this.challengeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ParticipantsBloc()
        ..add(ParticipantClicked(
            uid: getIt<GlobalConfiguration>().profile.uID ?? "",
            challengeId: challengeId,
            id: challengeId,
            pagesize: '500',
            search: "")),
      child: Scaffold(
        body: ParticipantsBody(
          challengeId: challengeId,
        ),
      ),
    );
  }
}

class ParticipantsBody extends StatefulWidget {
  final String challengeId;

  ParticipantsBody({Key? key, required this.challengeId}) : super(key: key);

  @override
  State<ParticipantsBody> createState() => _ParticipantsBodyState();
}

class _ParticipantsBodyState extends State<ParticipantsBody> {
  bool isSearchBtnClicked = false;
  int participatntCount = 0;

  TextEditingController _searchController = TextEditingController();
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParticipantsBloc, ParticipantState>(
      builder: (context, state) {
        if (state is ParticipantLoaded) {
          participatntCount = state.getParticipants.length;
        }
        return Scaffold(
            appBar: AppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Builder(builder: (context) {
                    if (!isSearchBtnClicked) {
                      return Builder(builder: (context) {
                        String total = participatntCount.toString();
                        String title = "";
                        if (participatntCount > 0) {
                          title = 'Participants (${total})';
                        } else {
                          title = 'Participants';
                        }
                        return Text(
                          title,
                          style: TextStyle(color: Palette.surface),
                        );
                      });
                    } else {
                      return const SizedBox();
                    }
                  }),
                  Builder(builder: (context) {
                    if (isSearchBtnClicked) {
                      return TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          // Handle search query changes
                          print('Search query: $value');
                          if (value.length > 3) {
                            // BlocProvider.of<ParticipantsBloc>(context).add(
                            //     ParticipantClicked(
                            //         uid: getIt<GlobalConfiguration>().profile.uID ??
                            //             "",
                            //         challengeId: widget.challengeId,
                            //         id: widget.challengeId,
                            //         pagesize: '500',
                            //         search: value));
                          }
                          BlocProvider.of<ParticipantsBloc>(context).add(
                              ParticipantClicked(
                                  uid: getIt<GlobalConfiguration>()
                                          .profile
                                          .uID ??
                                      "",
                                  challengeId: widget.challengeId,
                                  id: widget.challengeId,
                                  pagesize: '500',
                                  search: value));
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          fillColor: Colors.transparent,
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: 'Search...',
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        isSearchBtnClicked = true;
                      });
                    },
                  ),
                )
              ],
            ),
            body: BlocBuilder<ParticipantsBloc, ParticipantState>(
              builder: (context, state) {
                if (state is ParticipantLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  );
                } else if (state is ParticipantLoaded) {
                  return _getParticipantsList(context, state.getParticipants);
                } else {
                  return SizedBox(
                    width: 500,
                    height: 200,
                    child: Container(
                      color: Colors.transparent,
                      child: const Center(
                        child: Text(
                          'No Participant available',
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
            ));
      },
    );
  }

  Widget _getParticipantsList(
      BuildContext context, List<GetParticipants> getParticipants) {
    return Builder(builder: (context) {
      return Container(
        color: Colors.white,
        child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: getParticipants.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                // Navigator.pushNamed(context, Routes.likeScreen);
                // Navigator.pushNamed(context, Routes.likeScreen, arguments: {
                //   "challenge_id": widget.challengeId,
                //   "user_name": getParticipants[index].fullname,
                //   "u_id": widget.challengeId
                // });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LikeScreenPage(
                        challengeId:
                            getParticipants[index].challengeId.toString(),
                        userName: getParticipants[index].fullname.toString(),
                        uid: getParticipants[index].uid ?? ""),
                  ),
                );
              },
              child: Card(
                color: Colors.white,
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(builder: (context) {
                        int ind = index + 1;
                        return Text(ind.toString());
                      }),
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Palette.greenbtn,
                              child: CircleAvatar(
                                radius: 17,
                                backgroundColor: Colors.pink,
                                child: Builder(builder: (context) {
                                  String input = getParticipants[index]
                                      .fullname
                                      .toString();
                                  String firstCharacter = input.substring(0, 1);
                                  print(firstCharacter);
                                  String capitalized =
                                      capitalizeFirstCharacter(firstCharacter);
                                  print(capitalized);
                                  return Text(
                                    capitalized,
                                    style: const TextStyle(color: Colors.white),
                                  );
                                }),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(getParticipants[index].fullname.toString()),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              getParticipants[index].targetAchieved.toString() +
                                  " KM"),
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              // Navigator.pushNamed(context, Routes.likeScreen);
                              BlocProvider.of<ParticipantsBloc>(context)
                                  .add(LikeUnlikeClicked(
                                challengeid: widget.challengeId,
                                participant_uid:
                                    getParticipants[index].uid ?? "",
                                reacted_by:
                                    getIt<GlobalConfiguration>().profile.uID ??
                                        "",
                                reaction: 'LIKE',
                              ));
                            },
                            child: Builder(builder: (context) {
                              if (getParticipants[index].is_liked ?? true) {
                                return Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                  width: 55,
                                  height: 20,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.thumb_up,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Builder(builder: (context) {
                                        String likeCount =
                                            getParticipants[index]
                                                .totalReactionCount
                                                .toString();
                                        return Text(
                                          likeCount,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        );
                                      }),
                                    ],
                                  ),
                                );
                              } else {
                                return Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                  width: 55,
                                  height: 20,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.thumb_up,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Builder(builder: (context) {
                                        String likeCount =
                                            getParticipants[index]
                                                .totalReactionCount
                                                .toString();
                                        return Text(
                                          likeCount,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        );
                                      }),
                                    ],
                                  ),
                                );
                              }
                            }),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  String capitalizeFirstCharacter(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }
}

/*
//For customsearch delegate
class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    // Implement actions to be shown in the app bar, such as clearing the search query
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Implement leading widget, such as a back button
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement the search results view
    return Text('Search results for: $query');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement the search suggestions view
    return Text('Search suggestions for: $query');
  }
}
*/