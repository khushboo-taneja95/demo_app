import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tres_connect/core/utility/DateUtility.dart';

typedef DateRangeChangedCallback = void Function(
    DateTime startDate, DateTime endDate);

class DateRangeNavigator extends StatefulWidget {
  final int daysToNavigate;
  final Color textColor;
  final DateTime endDate;
  final DateRangeChangedCallback? onDateRangeChanged;

  const DateRangeNavigator(
      {super.key,
      required this.endDate,
      this.daysToNavigate = 7,
      this.onDateRangeChanged,
      this.textColor = Colors.black});

  @override
  _DateRangeNavigatorState createState() => _DateRangeNavigatorState();
}

class _DateRangeNavigatorState extends State<DateRangeNavigator> {
  late DateTime _startDate;
  late DateTime _endDate;

  @override
  void initState() {
    _initializeDates();
    _notifyDateRangeChanged();
    super.initState();
  }

  void _initializeDates() {
    _endDate = widget.endDate;
    _startDate = _endDate.subtract(Duration(
        days: widget.daysToNavigate == 30
            ? widget.daysToNavigate
            : widget.daysToNavigate - 1));
    _startDate =
        DateTime(_startDate.year, _startDate.month, _startDate.day, 0, 0, 0);
    _endDate =
        DateTime(_endDate.year, _endDate.month, _endDate.day, 23, 59, 59);
  }

  void _navigateForward() {
    setState(() {
      if (_endDate.isBefore(DateTime.now())) {
        _startDate = _startDate.add(Duration(days: widget.daysToNavigate));
        _endDate = _endDate.add(Duration(days: widget.daysToNavigate));
        _notifyDateRangeChanged();
      }
    });
  }

  bool _canNavigateBack() {
    return _startDate
            .isAfter(DateTime.now().subtract(const Duration(days: 30))) &&
        widget.daysToNavigate != 30;
  }

  bool _canNavigateForward() {
    return _endDate.isBefore(DateTime.now()) && widget.daysToNavigate != 30;
  }

  void _navigateBackward() {
    setState(() {
      if (_startDate
          .isAfter(DateTime.now().subtract(const Duration(days: 30)))) {
        _startDate = _startDate.subtract(Duration(days: widget.daysToNavigate));
        _endDate = _endDate.subtract(Duration(days: widget.daysToNavigate));
        _notifyDateRangeChanged();
      }
    });
  }

  void _notifyDateRangeChanged() {
    if (widget.onDateRangeChanged != null) {
      widget.onDateRangeChanged!(_startDate, _endDate);
    }
  }

  String _getDateString() {
    final DateFormat dateFormatter = DateFormat('dd-MMM-yyyy');
    final String startDateString = dateFormatter.format(_startDate);
    final String endDateString = dateFormatter.format(_endDate);
    int diffInDays = DateUtility.diffInDays(_endDate, _startDate);
    //6 days for week
    //29 days for month
    if (diffInDays > 1) {
      return '$startDateString - $endDateString';
    } else {
      return _endDate.isAfter(DateTime.now()) ? 'Today' : endDateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.chevron_left),
            onPressed: _canNavigateBack() ? _navigateBackward : null,
            color: _canNavigateBack()
                ? widget.textColor
                : widget.textColor.withOpacity(0.5)),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            _getDateString(),
            style: TextStyle(fontSize: 13, color: widget.textColor),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(width: 16),
        IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.chevron_right),
          onPressed: _canNavigateForward() ? _navigateForward : null,
          color: _canNavigateForward()
              ? widget.textColor
              : widget.textColor.withOpacity(0.5),
        ),
      ],
    );
  }
}
