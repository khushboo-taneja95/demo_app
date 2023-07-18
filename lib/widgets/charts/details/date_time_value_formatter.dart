// import 'package:mp_chart/mp/core/axis/axis_base.dart';
// import 'package:mp_chart/mp/core/value_formatter/value_formatter.dart';
// import 'package:tres_connect/core/utility/DateUtility.dart';

// class TimeValueFormatter extends ValueFormatter{
//   final String formatter;
//   TimeValueFormatter({this.formatter = 'hh:mm a'});

//   @override
//   String getAxisLabel(double? value, AxisBase? axis) {
//     return super.getAxisLabel(value, axis);
//   }

//   @override
//   String getFormattedValue1(double? value) {
//     if (value != null) {
//       final dateTime = DateUtility.formatDateTime(dateTime: DateTime.fromMillisecondsSinceEpoch((value * 1000).toInt()),outputFormat: formatter);
//       return dateTime;
//     }
//     return "-";
//   }


// }