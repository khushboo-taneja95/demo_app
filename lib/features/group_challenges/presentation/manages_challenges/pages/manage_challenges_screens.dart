import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/routes/routes.dart';
import 'package:tres_connect/core/themes/palette.dart';
import 'package:tres_connect/core/utility/DateUtility.dart';
import 'package:tres_connect/core/utility/utils.dart';
import 'package:tres_connect/features/group_challenges/data/datasources/create_challenges_remote_data_source.dart';
import 'package:tres_connect/features/group_challenges/data/models/get_my_challenges_models.dart';
import 'package:tres_connect/features/group_challenges/presentation/edit_challenges/pages/edit_challenge_page.dart';
import 'package:tres_connect/global_configuration.dart';

class ManageChallengesScreens extends StatefulWidget {
  final String? groupUid;
  final String? groupName;
  final String? challengeId;
  const ManageChallengesScreens({
    Key? key,
    required this.groupName,
    required this.groupUid,
    this.challengeId,
  }) : super(key: key);

  @override
  State<ManageChallengesScreens> createState() =>
      _ManageChallengesScreensState();
}

class _ManageChallengesScreensState extends State<ManageChallengesScreens> {
  Future<GetMyChallengesModels>? _futureGetMyChallengesAPI;
  @override
  void initState() {
    super.initState();
    loadChellenges();
  }

  void loadChellenges() {
    _futureGetMyChallengesAPI =
        CreateChallengesRemoteDataSourceImpl().getMyChallenge(
      pageSize: '10',
      startIndex: '0',
      uid: getIt<GlobalConfiguration>().profile.uID ?? "",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Manage Challenges",
          style: TextStyle(color: Palette.surface),
        ),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<GetMyChallengesModels>(
          future: _futureGetMyChallengesAPI,
          builder: (BuildContext context,
              AsyncSnapshot<GetMyChallengesModels> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!.getMyChallenges!.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.getMyChallenges!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            child: Slidable(
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      if (snapshot.data!.getMyChallenges![index]
                                              .participants ==
                                          0) {
                                        showDialog(
                                            context: context,
                                            builder: (ctx) {
                                              return AlertDialog(
                                                title: const Text(
                                                    "Delete Challenge"),
                                                content: const Text(
                                                    "Are you sure you want to delete this challenge?"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(ctx);
                                                    },
                                                    child: const Text("Cancel"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(ctx);
                                                      CreateChallengesRemoteDataSourceImpl()
                                                          .deleteChallenges(
                                                              challengeId:
                                                                  '${snapshot.data!.getMyChallenges![index].id}')
                                                          .then((value) {
                                                        setState(() {
                                                          _futureGetMyChallengesAPI =
                                                              CreateChallengesRemoteDataSourceImpl()
                                                                  .getMyChallenge(
                                                            pageSize: '10',
                                                            startIndex: '0',
                                                            uid:
                                                                getIt<GlobalConfiguration>()
                                                                        .profile
                                                                        .uID ??
                                                                    "",
                                                          );
                                                        });
                                                      });
                                                    },
                                                    child: const Text("Delete"),
                                                  ),
                                                ],
                                              );
                                            });
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (ctx) {
                                              return AlertDialog(
                                                title: const Text("Failed"),
                                                content: const Text(
                                                    "Cannot delete challenge with participants "),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(ctx);
                                                    },
                                                    child: const Text("OK"),
                                                  ),
                                                ],
                                              );
                                            });
                                        Utils.showSnackBar(context,
                                            "Cannot delete challenge with participants");
                                      }
                                    },
                                    backgroundColor: const Color(0xFFFE4A49),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: ConstrainedBox(
                                        constraints: const BoxConstraints(
                                          minHeight: 80,
                                          maxWidth: 125,
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            snapshot
                                                    .data!
                                                    .getMyChallenges![index]
                                                    .challengeImage ??
                                                "https://storage.googleapis.com/proudcity/mebanenc/uploads/2021/03/placeholder-image.png",
                                            width: 125,
                                            height: 81,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            " ${snapshot.data!.getMyChallenges![index].challengeTitle}",
                                            maxLines: 5,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            DateUtility.parseAndFormatDateTime(
                                                dateTimeString:
                                                    '${snapshot.data!.getMyChallenges![index].challengeEnddate}',
                                                inputFormat:
                                                    "yyyy-MM-dd'T'HH:mm:ss",
                                                outputFormat: "dd-MM-yyyy"),
                                            maxLines: 2,
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            " ${snapshot.data!.getMyChallenges![index].participants} Participants",
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 8.0, top: 40),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                Utils.hideKeyboard();
                                                final result =
                                                    await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditChallengePage(
                                                      challengesDetails:
                                                          snapshot
                                                              .data!
                                                              .getMyChallenges![
                                                                  index]
                                                              .challengeDetails,
                                                      challengesName: snapshot
                                                          .data!
                                                          .getMyChallenges![
                                                              index]
                                                          .challengeTitle,
                                                      endDate: DateTime.parse(
                                                          snapshot
                                                              .data!
                                                              .getMyChallenges![
                                                                  index]
                                                              .challengeEnddate
                                                              .toString()),
                                                      startDate: DateTime.parse(
                                                          snapshot
                                                              .data!
                                                              .getMyChallenges![
                                                                  index]
                                                              .challengeStartdate
                                                              .toString()),
                                                      targetName: snapshot
                                                          .data!
                                                          .getMyChallenges![
                                                              index]
                                                          .target
                                                          .toString(),
                                                      challengeId: snapshot
                                                          .data!
                                                          .getMyChallenges![
                                                              index]
                                                          .id
                                                          .toString(),
                                                    ),
                                                  ),
                                                );
                                                if (result != null &&
                                                    result["refresh"] == true) {
                                                  loadChellenges();
                                                }
                                                setState(() {});
                                              },
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
                        },
                      ),
                    )
                  : const Center(child: Text("No challenges found "));
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final returnedData = await Navigator.pushNamed(
              context, Routes.createChallengeScreen,
              arguments: {
                "groupId": widget.groupUid,
                "groupName": widget.groupName,
              }) as Map<String, dynamic>?;
          if (returnedData != null && returnedData["refresh"] == true) {
            loadChellenges();
            setState(() {});
          }
        },
        backgroundColor: Palette.greenbtn,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
