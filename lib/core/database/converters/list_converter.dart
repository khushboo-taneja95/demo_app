import 'package:floor/floor.dart';

class ListConverter extends TypeConverter<List<dynamic>, String> {
  @override
  List<dynamic> decode(String databaseValue) {
    final val = databaseValue
        .split(",")
        .map((x) => x.trim())
        .where((element) => element.isNotEmpty)
        .toList();
    return val;
  }

  @override
  String encode(List<dynamic> value) {
    return value.join(', ');
  }
}
