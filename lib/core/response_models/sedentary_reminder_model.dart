class SedentaryReminderModel{
  final bool isEnabled;
  final int startHour;
  final int startMinute;
  final int endHour;
  final int endMinute;
  final int steps;
  final int noon_onoff;
  final List<int> weekRepeatDays;

  SedentaryReminderModel({
    required this.isEnabled,
    required this.startHour,
    required this.startMinute,
    required this.endHour,
    required this.endMinute,
    required this.steps,
    required this.noon_onoff,
    required this.weekRepeatDays
  });


}