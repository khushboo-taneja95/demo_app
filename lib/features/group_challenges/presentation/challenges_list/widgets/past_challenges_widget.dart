import 'package:flutter/material.dart';
import 'package:tres_connect/core/themes/palette.dart';

class PastChallenges extends StatelessWidget {
  const PastChallenges({super.key});

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
                  // allOnGoingChallengesList(),
                  // globalList(),
                  // corporateList(),
                  // groupList(),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
