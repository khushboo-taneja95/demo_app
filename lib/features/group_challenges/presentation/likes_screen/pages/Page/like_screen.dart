import 'package:flutter/material.dart';
import 'package:tres_connect/core/themes/palette.dart';

import 'package:tres_connect/core/bloc/bloc.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/global_configuration.dart';
import 'package:tres_connect/features/group_challenges/presentation/likes_screen/bloc/liked_list_bloc.dart';

import '../../../../data/models/liked_list_model.dart';

class LikeScreenPage extends StatelessWidget {
  final String challengeId;
  final String userName;
  final String uid;
  const LikeScreenPage(
      {Key? key,
      required this.challengeId,
      required this.userName,
      required this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return const LikeScreenBody();
    return BlocProvider(
      create: (context) => LikedListBloc()
        ..add(LikeListClicked(
          challengeid: int.parse(challengeId),
          pageSize: 100,
          startIndex: 0,
          uid: uid,
        )),
      child: Scaffold(
        body: LikeScreenBody(
          challengeId: challengeId,
          userName: userName,
          uid: uid,
        ),
      ),
    );
  }
}

class LikeScreenBody extends StatefulWidget {
  final String challengeId;
  final String userName;
  final String uid;
  LikeScreenBody(
      {super.key,
      required this.challengeId,
      required this.userName,
      required this.uid});

  @override
  State<LikeScreenBody> createState() => _LikeScreenBodyState();
}

class _LikeScreenBodyState extends State<LikeScreenBody> {
  int participatntCount = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikedListBloc, LikeListState>(
      builder: (context, state) {
        if (state is LikedListLoaded) {
          participatntCount = state.listOfLikesChallenge.length;
        }
        return Scaffold(
            appBar: AppBar(
              title: Builder(builder: (context) {
                String total = participatntCount.toString();
                String title = "";
                if (participatntCount > 0) {
                  title = 'Likes (${total})';
                } else {
                  title = 'Likes';
                }
                return Text(
                  title,
                  style: TextStyle(color: Palette.surface),
                );
              }),
              backgroundColor: Colors.black,
            ),
            body: BlocBuilder<LikedListBloc, LikeListState>(
              builder: (context, state) {
                if (state is LikedListLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  );
                } else if (state is LikedListLoaded) {
                  return _getlikedList(context, state.listOfLikesChallenge);
                } else {
                  return SizedBox(
                    width: 500,
                    height: 200,
                    child: Container(
                      color: Colors.transparent,
                      child: const Center(
                        child: Text(
                          'Data not available',
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

  Widget _getlikedList(
      BuildContext context, List<ListOfLikesChallenge> listOfLikesChallenge) {
    return Container(
      color: Colors.grey[200],
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: listOfLikesChallenge.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.white,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Palette.greenbtn,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.pink,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Builder(builder: (context) {
                            String input =
                                listOfLikesChallenge[index].name ?? "A";
                            String firstCharacter = input.substring(0, 1);
                            print(firstCharacter);
                            String capitalized =
                                capitalizeFirstCharacter(firstCharacter);
                            print(capitalized);
                            return Text(
                              capitalized,
                              style: TextStyle(color: Colors.white),
                            );
                          }),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 8,
                              child: Icon(
                                Icons.thumb_up,
                                size: 10.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Builder(builder: (context) {
                    String name = listOfLikesChallenge[index].name ?? "";
                    return Text(name);
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String capitalizeFirstCharacter(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }
}
