// ignore_for_file: non_constant_identifier_names
import 'package:floor/floor.dart';

@Entity(tableName: "VaccinationTest", indices: [
  Index(value: ['vacId'], unique: true)
])
class VaccinationTestEntity {
  @PrimaryKey(autoGenerate: true)
  int? RowID;
  String? diseaseType;
  String? vacId;
  String? referenceNumber;
  String? vaccinationType;
  String? vaccinationName;
  String? vaccinationDate;
  String? docUrl;
  String? vaccinationThumbnail;
  String? courseStatus;
  String? uid;
  String? validationAuthority;
  String? diseaseCode;
  String? country;
  String? testResult;
  String? vaccinationFileType;
  String? vaccinationLocation;
  String? beneficiaryAge;
  String? beneficiaryGender;
  String? vaccinationQRCode;
  String? timestamp;
  String? beneficiaryName;
  String? vaccinationStatus;
  String? isSynced;

  VaccinationTestEntity({
    this.RowID,
    this.diseaseType,
    this.vacId,
    this.referenceNumber,
    this.vaccinationType,
    this.vaccinationName,
    this.vaccinationDate,
    this.docUrl,
    this.vaccinationThumbnail,
    this.courseStatus,
    this.uid,
    this.validationAuthority,
    this.diseaseCode,
    this.country,
    this.testResult,
    this.vaccinationFileType,
    this.vaccinationLocation,
    this.beneficiaryAge,
    this.beneficiaryGender,
    this.vaccinationQRCode,
    this.timestamp,
    this.beneficiaryName,
    this.vaccinationStatus,
    this.isSynced,
  });

  factory VaccinationTestEntity.fromMap(Map<String, dynamic> json) {
    return VaccinationTestEntity(
      RowID: json['RowID'],
      diseaseType: json['DiseaseType'],
      vacId: json['VacId'],
      referenceNumber: json['ReferenceNumber'],
      vaccinationType: json['VaccinationType'],
      vaccinationName: json['VaccinationName'],
      vaccinationDate: json['VaccinationDate'],
      docUrl: json['Doc_Url'],
      vaccinationThumbnail: json['VaccinationThumbnail'],
      courseStatus: json['CourseStatus'],
      uid: json['UID'],
      validationAuthority: json['ValidationAuthority'],
      diseaseCode: json['DiseaseCode'],
      country: json['country'],
      testResult: json['TestResult'],
      vaccinationFileType: json['VaccinationFileType'],
      vaccinationLocation: json['VaccinationLocation'],
      beneficiaryAge: json['BeneficiaryAge'],
      beneficiaryGender: json['BeneficiaryGender'],
      vaccinationQRCode: json['VaccinationQRCode'],
      timestamp: json['timestamp'],
      beneficiaryName: json['BeneficiaryName'],
      vaccinationStatus: json['VaccinationStatus'],
      isSynced: json['ISSYNCED'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'RowID': RowID,
      'DiseaseType': diseaseType,
      'VacId': vacId,
      'ReferenceNumber': referenceNumber,
      'VaccinationType': vaccinationType,
      'VaccinationName': vaccinationName,
      'VaccinationDate': vaccinationDate,
      'Doc_Url': docUrl,
      'VaccinationThumbnail': vaccinationThumbnail,
      'CourseStatus': courseStatus,
      'UID': uid,
      'ValidationAuthority': validationAuthority,
      'DiseaseCode': diseaseCode,
      'country': country,
      'TestResult': testResult,
      'VaccinationFileType': vaccinationFileType,
      'VaccinationLocation': vaccinationLocation,
      'BeneficiaryAge': beneficiaryAge,
      'BeneficiaryGender': beneficiaryGender,
      'VaccinationQRCode': vaccinationQRCode,
      'timestamp': timestamp,
      'BeneficiaryName': beneficiaryName,
      'VaccinationStatus': vaccinationStatus,
      'ISSYNCED': isSynced,
    };
  }
}
