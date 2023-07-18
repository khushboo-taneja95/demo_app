import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tres_connect/core/themes/palette.dart';
import 'package:tres_connect/features/group_challenges/data/models/get_all_badge_models.dart';
import 'package:tres_connect/features/group_challenges/presentation/create_challenge/bloc/create_challenges_bloc.dart';

class UploadBadgeScreenDesigns extends StatelessWidget {
  final int forRank;
  const UploadBadgeScreenDesigns({super.key, required this.forRank});

  @override
  Widget build(BuildContext context) {
    return UploadBadgeDesign(forRank: forRank);
  }
}

class UploadBadgeDesign extends StatelessWidget {
  final int forRank;
  const UploadBadgeDesign({super.key, required this.forRank});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateChallengeBloc()
        ..add(CreateChallengeLoadEvent(forRank: forRank)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Upload Badges",
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
                ),
              );
            } else if (state is GetBadgesLoaded) {
              return getUploadBadgesData(context, state.getAllBadge);
            } else if (state is CreateChallengeError) {
              return const SizedBox();
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget getUploadBadgesData(
      BuildContext context, List<GetAllBadge> getAllBadge) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: getAllBadge.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: InkWell(
            onTap: () {
              Navigator.pop(context, {
                "badgeId": getAllBadge[index].id,
                "badgeImage": getAllBadge[index].image,
                "forRank": forRank
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
              clipBehavior: Clip.hardEdge,
              width: 75,
              height: 75,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    getAllBadge[index].image ?? "",
                    height: 75,
                    width: 75,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
