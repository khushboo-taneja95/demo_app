import 'package:flutter/material.dart';
import 'package:tres_connect/core/database/entity/health_rating_entity.dart';
import 'package:tres_connect/core/themes/palette.dart';
import 'package:tres_connect/health_rating_utility.dart';
import 'package:tres_connect/widgets/charts/no_chart_widget.dart';
import 'package:tres_connect/widgets/date_range_picker.dart';

typedef TabChangeCallback = void Function(int tabIndex);

class TabBarWidget extends StatefulWidget {
  final TabChangeCallback? onTabChanged;
  final List<Widget> pagesWidget;
  final DateRangeChangedCallback? onDateRangeChanged;
  final Color backgroundColor;
  final bool showHealthRating;
  final bool showTabs;
  final HealthRatingEntity? healthRatingEntity;
  final int initialIndex;
  const TabBarWidget(
      {super.key,
      required this.pagesWidget,
      this.initialIndex = 0,
      this.onTabChanged,
      this.onDateRangeChanged,
      this.backgroundColor = Colors.white,
      this.showHealthRating = true,
      this.showTabs = true,
      this.healthRatingEntity});

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int length = 3;
  late List<Widget> pages;
  int daysToNavigate = 1;
  @override
  void initState() {
    _tabController = TabController(
        length: length, vsync: this, initialIndex: widget.initialIndex);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        _notifyTabChanged();
        _getDaysToNavigate();
      }
    });
    pages = List.generate(length, (index) {
      try {
        return widget.pagesWidget[index];
      } catch (e) {
        return const NoChartWidget(
          message: "No widget found",
        );
      }
    });
    super.initState();
  }

  void _notifyTabChanged() {
    if (widget.onTabChanged != null) {
      widget.onTabChanged!(_tabController.index);
    }
  }

  void _getDaysToNavigate() {
    setState(() {
      if (_tabController.index == 0) {
        daysToNavigate = 1;
      } else if (_tabController.index == 1) {
        daysToNavigate = 7;
      } else if (_tabController.index == 2) {
        daysToNavigate = 30;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(widget.showHealthRating ? 150 : 100),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(),
            widget.showTabs
                ? Container(
                    height: 40,
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    decoration: BoxDecoration(
                      color: const Color(0xff999ca4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      labelColor: Palette.secondaryDark,
                      unselectedLabelColor: Palette.secondaryDark,
                      tabs: const [
                        Tab(
                          text: "DAY",
                        ),
                        Tab(
                          text: "WEEK",
                        ),
                        Tab(
                          text: "MONTH",
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
      body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: pages),
    );
  }
}
