import 'package:equatable/equatable.dart';

class NotifyDataModel extends Equatable {
  String? id;
  String? name;
  String? showName;
  bool? enable;

  NotifyDataModel(
      {this.id,
        this.name,
        this.showName,
        this.enable,});

  @override
  List<Object?> get props =>
      [id, name, showName, enable];
}
