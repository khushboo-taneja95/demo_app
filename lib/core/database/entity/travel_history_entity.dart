// ignore_for_file: non_constant_identifier_names

import 'package:floor/floor.dart';

@Entity(tableName: "TravelHistory", indices: [
  Index(value: ['DocId'], unique: true)
])
class TravelHistoryEntity {
  @PrimaryKey(autoGenerate: true)
  int? RowID;
  final int? TravelHistoryID;
  final DateTime DepartureDate;
  final DateTime ReturnDate;
  final String TravelCity;
  final String TravelUid;
  final bool IsSynced;
  final String DocId;
  final bool IsActive;

  TravelHistoryEntity(
      {this.RowID,
      required this.TravelHistoryID,
      required this.DepartureDate,
      required this.ReturnDate,
      required this.TravelCity,
      required this.TravelUid,
      required this.IsSynced,
      required this.DocId,
      required this.IsActive});

  Map<String, dynamic> toMap() {
    return {
      'TravelHistoryID': TravelHistoryID,
      'DepartureDate': DepartureDate,
      'ReturnDate': ReturnDate,
      'TravelCity': TravelCity,
      'TravelUid': TravelUid,
      'IsSynced': IsSynced,
      'DocId': DocId,
      'IsActive': IsActive,
    };
  }

  factory TravelHistoryEntity.fromMap(Map<String, dynamic> map) {
    return TravelHistoryEntity(
      TravelHistoryID: map['TravelHistoryID'],
      DepartureDate: map['DepartureDate'],
      ReturnDate: map['ReturnDate'],
      TravelCity: map['TravelCity'],
      TravelUid: map['TravelUid'],
      IsSynced: map['IsSynced'],
      DocId: map['DocId'],
      IsActive: map['IsActive'],
    );
  }
}
