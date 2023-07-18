// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import 'package:tres_connect/core/database/entity/health_reading_entity.dart';
// import 'package:tres_connect/core/errors/failures.dart';
// import 'package:tres_connect/core/usecase/usecase.dart';
// import 'package:tres_connect/features/health_dashboard/domain/repositories/vitals_repository.dart';

// class SaveVitalsUsecase extends UseCase<void, SaveVitalsUsecaseParams> {
//   SaveVitalsUsecase({required this.repository});

//   final VitalsRepository repository;

//   @override
//   Future<Either<Failure, void>> call(SaveVitalsUsecaseParams params) {
//     List<HealthReading> readings = [];
//     for (var reading in params.healthReadings) {
//       if (reading.MedicalCode == "HR") {
//         if (reading.ReadingMax >= 45 && reading.ReadingMax <= 250) {
//           readings.add(reading);
//         }
//       } else if (reading.MedicalCode == "BT") {
//         if (reading.ReadingMax >= 10 && reading.ReadingMax <= 60) {
//           readings.add(reading);
//         }
//       } else {
//         readings.add(reading);
//       }
//     }
//     return repository.saveVitals(readings: readings);
//   }
// }

// class SaveVitalsUsecaseParams extends Equatable {
//   final List<HealthReading> healthReadings;

//   const SaveVitalsUsecaseParams({required this.healthReadings});

//   @override
//   List<Object?> get props => [healthReadings];
// }
