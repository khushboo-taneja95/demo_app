// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  HealthReadingsDao? _healthReadingDaoInstance;

  HealthRatingDao? _healthRatingDaoInstance;

  ActivitySummaryDao? _activitySummaryDaoInstance;

  ActivityDetailsDao? _activityDetailsDaoInstance;

  UserProfileInfoDao? _userProfileDaoInstance;

  NotificationDao? _notificationDaoInstance;

  VaccinationTestDao? _vaccinationtTestDaoInstance;

  TravelHistoryDao? _travelHistoryDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `HealthReadings` (`RowID` INTEGER PRIMARY KEY AUTOINCREMENT, `UID` TEXT NOT NULL, `TimeStamp` INTEGER NOT NULL, `MedicalCode` TEXT NOT NULL, `ReadingMin` REAL NOT NULL, `ReadingMax` REAL NOT NULL, `LocLatitude` REAL NOT NULL, `LocLongitude` REAL NOT NULL, `Date` TEXT, `IsAutomatedReading` INTEGER NOT NULL, `IsSynced` INTEGER NOT NULL, `DeviceType` TEXT NOT NULL, `IsGoogleFitSync` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `HealthRating` (`HRowId` INTEGER PRIMARY KEY AUTOINCREMENT, `userID` TEXT, `healthRatingTimeStamp` TEXT, `riskRating` TEXT, `remarkStatusTime` TEXT, `reasonToShow` TEXT, `isRemarkSync` INTEGER, `riskValue` TEXT, `travelStatus` TEXT, `travelReason` TEXT, `remarks` TEXT, `healthRatingUserLatitude` TEXT, `healthRatingUserLongitude` TEXT, `hIsSynced` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ActivityDetails` (`RowID` INTEGER PRIMARY KEY AUTOINCREMENT, `UID` TEXT NOT NULL, `ActivityType` TEXT NOT NULL, `ActivityStartDate` INTEGER NOT NULL, `ActivityEndDate` INTEGER NOT NULL, `date` TEXT NOT NULL, `ActivityValue` REAL NOT NULL, `IsAutomatedReading` INTEGER NOT NULL, `ActivityTotalSleep` INTEGER NOT NULL, `DeviceType` TEXT NOT NULL, `IsSynced` INTEGER NOT NULL, `IsGoogleFitSync` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ActivitySummary` (`RowID` INTEGER PRIMARY KEY AUTOINCREMENT, `UID` TEXT NOT NULL, `ActivityType` TEXT NOT NULL, `ActivityDate` INTEGER NOT NULL, `date` TEXT NOT NULL, `ActivityTotalTime` INTEGER NOT NULL, `ActivityValue` REAL NOT NULL, `IsAutomatedReading` INTEGER NOT NULL, `DeviceType` TEXT NOT NULL, `IsSynced` INTEGER NOT NULL, `IsGoogleFitSync` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `UserProfile` (`UID` TEXT, `FirstName` TEXT, `LastName` TEXT, `EmailId` TEXT, `MobileNo` TEXT, `Gender` TEXT, `Weight` INTEGER, `Height` INTEGER, `DOB` TEXT, `ProfilePhoto` TEXT, `LoginSource` TEXT, `SourceToken` TEXT, `AuthorizationToken` TEXT, `TokenExpiryTime` TEXT, `CreationDate` TEXT, PRIMARY KEY (`UID`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `NotificationMessageTable` (`NotificationId` TEXT, `NotificationTitle` TEXT, `NotificationMessage` TEXT, `NotificationTime` TEXT, `NotificationType` TEXT, `NotificationImage` TEXT, `NotificationTargetPage` TEXT, `TargetPlatform` TEXT, `NotificationData` TEXT, `IsSeen` INTEGER NOT NULL, PRIMARY KEY (`NotificationId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TravelHistory` (`RowID` INTEGER PRIMARY KEY AUTOINCREMENT, `TravelHistoryID` INTEGER, `DepartureDate` INTEGER NOT NULL, `ReturnDate` INTEGER NOT NULL, `TravelCity` TEXT NOT NULL, `TravelUid` TEXT NOT NULL, `IsSynced` INTEGER NOT NULL, `DocId` TEXT NOT NULL, `IsActive` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `VaccinationTest` (`RowID` INTEGER PRIMARY KEY AUTOINCREMENT, `diseaseType` TEXT, `vacId` TEXT, `referenceNumber` TEXT, `vaccinationType` TEXT, `vaccinationName` TEXT, `vaccinationDate` TEXT, `docUrl` TEXT, `vaccinationThumbnail` TEXT, `courseStatus` TEXT, `uid` TEXT, `validationAuthority` TEXT, `diseaseCode` TEXT, `country` TEXT, `testResult` TEXT, `vaccinationFileType` TEXT, `vaccinationLocation` TEXT, `beneficiaryAge` TEXT, `beneficiaryGender` TEXT, `vaccinationQRCode` TEXT, `timestamp` TEXT, `beneficiaryName` TEXT, `vaccinationStatus` TEXT, `isSynced` TEXT)');
        await database.execute(
            'CREATE UNIQUE INDEX `index_HealthReadings_MedicalCode_TimeStamp` ON `HealthReadings` (`MedicalCode`, `TimeStamp`)');
        await database.execute(
            'CREATE UNIQUE INDEX `index_ActivityDetails_ActivityStartDate_ActivityType` ON `ActivityDetails` (`ActivityStartDate`, `ActivityType`)');
        await database.execute(
            'CREATE UNIQUE INDEX `index_ActivitySummary_ActivityDate_ActivityType` ON `ActivitySummary` (`ActivityDate`, `ActivityType`)');
        await database.execute(
            'CREATE UNIQUE INDEX `index_NotificationMessageTable_NotificationId` ON `NotificationMessageTable` (`NotificationId`)');
        await database.execute(
            'CREATE UNIQUE INDEX `index_TravelHistory_DocId` ON `TravelHistory` (`DocId`)');
        await database.execute(
            'CREATE UNIQUE INDEX `index_VaccinationTest_vacId` ON `VaccinationTest` (`vacId`)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  HealthReadingsDao get healthReadingDao {
    return _healthReadingDaoInstance ??=
        _$HealthReadingsDao(database, changeListener);
  }

  @override
  HealthRatingDao get healthRatingDao {
    return _healthRatingDaoInstance ??=
        _$HealthRatingDao(database, changeListener);
  }

  @override
  ActivitySummaryDao get activitySummaryDao {
    return _activitySummaryDaoInstance ??=
        _$ActivitySummaryDao(database, changeListener);
  }

  @override
  ActivityDetailsDao get activityDetailsDao {
    return _activityDetailsDaoInstance ??=
        _$ActivityDetailsDao(database, changeListener);
  }

  @override
  UserProfileInfoDao get userProfileDao {
    return _userProfileDaoInstance ??=
        _$UserProfileInfoDao(database, changeListener);
  }

  @override
  NotificationDao get notificationDao {
    return _notificationDaoInstance ??=
        _$NotificationDao(database, changeListener);
  }

  @override
  VaccinationTestDao get vaccinationtTestDao {
    return _vaccinationtTestDaoInstance ??=
        _$VaccinationTestDao(database, changeListener);
  }

  @override
  TravelHistoryDao get travelHistoryDao {
    return _travelHistoryDaoInstance ??=
        _$TravelHistoryDao(database, changeListener);
  }
}

class _$HealthReadingsDao extends HealthReadingsDao {
  _$HealthReadingsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _healthReadingInsertionAdapter = InsertionAdapter(
            database,
            'HealthReadings',
            (HealthReading item) => <String, Object?>{
                  'RowID': item.RowID,
                  'UID': item.UID,
                  'TimeStamp': _dateTimeConverter.encode(item.TimeStamp),
                  'MedicalCode': item.MedicalCode,
                  'ReadingMin': item.ReadingMin,
                  'ReadingMax': item.ReadingMax,
                  'LocLatitude': item.LocLatitude,
                  'LocLongitude': item.LocLongitude,
                  'Date': item.Date,
                  'IsAutomatedReading': item.IsAutomatedReading ? 1 : 0,
                  'IsSynced': item.IsSynced ? 1 : 0,
                  'DeviceType': item.DeviceType,
                  'IsGoogleFitSync': item.IsGoogleFitSync ? 1 : 0
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<HealthReading> _healthReadingInsertionAdapter;

  @override
  Future<List<HealthReading>> getAllReadings() async {
    return _queryAdapter.queryList(
        'SELECT * FROM HealthReadings ORDER BY TimeStamp ASC',
        mapper: (Map<String, Object?> row) => HealthReading(
            UID: row['UID'] as String,
            TimeStamp: _dateTimeConverter.decode(row['TimeStamp'] as int),
            MedicalCode: row['MedicalCode'] as String,
            ReadingMin: row['ReadingMin'] as double,
            ReadingMax: row['ReadingMax'] as double,
            LocLatitude: row['LocLatitude'] as double,
            LocLongitude: row['LocLongitude'] as double,
            Date: row['Date'] as String?,
            IsAutomatedReading: (row['IsAutomatedReading'] as int) != 0,
            IsSynced: (row['IsSynced'] as int) != 0,
            DeviceType: row['DeviceType'] as String,
            IsGoogleFitSync: (row['IsGoogleFitSync'] as int) != 0));
  }

  @override
  Stream<HealthReading?> listenLastHealthReading() {
    return _queryAdapter.queryStream(
        'SELECT * FROM HealthReadings ORDER BY TimeStamp DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => HealthReading(
            UID: row['UID'] as String,
            TimeStamp: _dateTimeConverter.decode(row['TimeStamp'] as int),
            MedicalCode: row['MedicalCode'] as String,
            ReadingMin: row['ReadingMin'] as double,
            ReadingMax: row['ReadingMax'] as double,
            LocLatitude: row['LocLatitude'] as double,
            LocLongitude: row['LocLongitude'] as double,
            Date: row['Date'] as String?,
            IsAutomatedReading: (row['IsAutomatedReading'] as int) != 0,
            IsSynced: (row['IsSynced'] as int) != 0,
            DeviceType: row['DeviceType'] as String,
            IsGoogleFitSync: (row['IsGoogleFitSync'] as int) != 0),
        queryableName: 'HealthReadings',
        isView: false);
  }

  @override
  Future<List<HealthReading>> getReadingsBetween(
    String startDate,
    String endDate,
    String medicalCode,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM HealthReadings WHERE MedicalCode = ?3 AND TimeStamp BETWEEN ?1 AND ?2 ORDER BY TimeStamp ASC',
        mapper: (Map<String, Object?> row) => HealthReading(UID: row['UID'] as String, TimeStamp: _dateTimeConverter.decode(row['TimeStamp'] as int), MedicalCode: row['MedicalCode'] as String, ReadingMin: row['ReadingMin'] as double, ReadingMax: row['ReadingMax'] as double, LocLatitude: row['LocLatitude'] as double, LocLongitude: row['LocLongitude'] as double, Date: row['Date'] as String?, IsAutomatedReading: (row['IsAutomatedReading'] as int) != 0, IsSynced: (row['IsSynced'] as int) != 0, DeviceType: row['DeviceType'] as String, IsGoogleFitSync: (row['IsGoogleFitSync'] as int) != 0),
        arguments: [startDate, endDate, medicalCode]);
  }

  @override
  Future<List<HealthReading>> getReadingsForDate(
    String date,
    String medicalCode,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM HealthReadings WHERE MedicalCode = ?2 AND Date = ?1 ORDER BY TimeStamp ASC',
        mapper: (Map<String, Object?> row) => HealthReading(UID: row['UID'] as String, TimeStamp: _dateTimeConverter.decode(row['TimeStamp'] as int), MedicalCode: row['MedicalCode'] as String, ReadingMin: row['ReadingMin'] as double, ReadingMax: row['ReadingMax'] as double, LocLatitude: row['LocLatitude'] as double, LocLongitude: row['LocLongitude'] as double, Date: row['Date'] as String?, IsAutomatedReading: (row['IsAutomatedReading'] as int) != 0, IsSynced: (row['IsSynced'] as int) != 0, DeviceType: row['DeviceType'] as String, IsGoogleFitSync: (row['IsGoogleFitSync'] as int) != 0),
        arguments: [date, medicalCode]);
  }

  @override
  Future<List<HealthReading>> getUnSynchedReadings() async {
    return _queryAdapter.queryList(
        'SELECT * FROM HealthReadings WHERE IsSynced = 0 ORDER BY TimeStamp ASC',
        mapper: (Map<String, Object?> row) => HealthReading(
            UID: row['UID'] as String,
            TimeStamp: _dateTimeConverter.decode(row['TimeStamp'] as int),
            MedicalCode: row['MedicalCode'] as String,
            ReadingMin: row['ReadingMin'] as double,
            ReadingMax: row['ReadingMax'] as double,
            LocLatitude: row['LocLatitude'] as double,
            LocLongitude: row['LocLongitude'] as double,
            Date: row['Date'] as String?,
            IsAutomatedReading: (row['IsAutomatedReading'] as int) != 0,
            IsSynced: (row['IsSynced'] as int) != 0,
            DeviceType: row['DeviceType'] as String,
            IsGoogleFitSync: (row['IsGoogleFitSync'] as int) != 0));
  }

  @override
  Future<List<HealthReading>> getUnSynchedReadingsForHealth() async {
    return _queryAdapter.queryList(
        'SELECT * FROM HealthReadings WHERE IsGoogleFitSync = 0 ORDER BY TimeStamp ASC',
        mapper: (Map<String, Object?> row) => HealthReading(
            UID: row['UID'] as String,
            TimeStamp: _dateTimeConverter.decode(row['TimeStamp'] as int),
            MedicalCode: row['MedicalCode'] as String,
            ReadingMin: row['ReadingMin'] as double,
            ReadingMax: row['ReadingMax'] as double,
            LocLatitude: row['LocLatitude'] as double,
            LocLongitude: row['LocLongitude'] as double,
            Date: row['Date'] as String?,
            IsAutomatedReading: (row['IsAutomatedReading'] as int) != 0,
            IsSynced: (row['IsSynced'] as int) != 0,
            DeviceType: row['DeviceType'] as String,
            IsGoogleFitSync: (row['IsGoogleFitSync'] as int) != 0));
  }

  @override
  Future<List<HealthReading>> getReadingsToUpload(String medicalCode) async {
    return _queryAdapter.queryList(
        'SELECT * FROM HealthReadings WHERE MedicalCode = ?1 AND IsSynced = 0 ORDER BY TimeStamp ASC',
        mapper: (Map<String, Object?> row) => HealthReading(UID: row['UID'] as String, TimeStamp: _dateTimeConverter.decode(row['TimeStamp'] as int), MedicalCode: row['MedicalCode'] as String, ReadingMin: row['ReadingMin'] as double, ReadingMax: row['ReadingMax'] as double, LocLatitude: row['LocLatitude'] as double, LocLongitude: row['LocLongitude'] as double, Date: row['Date'] as String?, IsAutomatedReading: (row['IsAutomatedReading'] as int) != 0, IsSynced: (row['IsSynced'] as int) != 0, DeviceType: row['DeviceType'] as String, IsGoogleFitSync: (row['IsGoogleFitSync'] as int) != 0),
        arguments: [medicalCode]);
  }

  @override
  Future<void> markAllReadingsAsSynced() async {
    await _queryAdapter.queryNoReturn('UPDATE HealthReadings SET IsSynced = 1');
  }

  @override
  Future<HealthReading?> getLastReading(String medicalCode) async {
    return _queryAdapter.query(
        'SELECT * FROM HealthReadings WHERE MedicalCode = ?1 ORDER BY TimeStamp DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => HealthReading(UID: row['UID'] as String, TimeStamp: _dateTimeConverter.decode(row['TimeStamp'] as int), MedicalCode: row['MedicalCode'] as String, ReadingMin: row['ReadingMin'] as double, ReadingMax: row['ReadingMax'] as double, LocLatitude: row['LocLatitude'] as double, LocLongitude: row['LocLongitude'] as double, Date: row['Date'] as String?, IsAutomatedReading: (row['IsAutomatedReading'] as int) != 0, IsSynced: (row['IsSynced'] as int) != 0, DeviceType: row['DeviceType'] as String, IsGoogleFitSync: (row['IsGoogleFitSync'] as int) != 0),
        arguments: [medicalCode]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM HealthReadings');
  }

  @override
  Future<void> insertAllReadings(List<HealthReading> readings) async {
    await _healthReadingInsertionAdapter.insertList(
        readings, OnConflictStrategy.ignore);
  }

  @override
  Future<void> insertReading(HealthReading reading) async {
    await _healthReadingInsertionAdapter.insert(
        reading, OnConflictStrategy.ignore);
  }
}

class _$HealthRatingDao extends HealthRatingDao {
  _$HealthRatingDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _healthRatingEntityInsertionAdapter = InsertionAdapter(
            database,
            'HealthRating',
            (HealthRatingEntity item) => <String, Object?>{
                  'HRowId': item.HRowId,
                  'userID': item.userID,
                  'healthRatingTimeStamp': item.healthRatingTimeStamp,
                  'riskRating': item.riskRating,
                  'remarkStatusTime': item.remarkStatusTime,
                  'reasonToShow': item.reasonToShow,
                  'isRemarkSync': item.isRemarkSync,
                  'riskValue': item.riskValue,
                  'travelStatus': item.travelStatus,
                  'travelReason': item.travelReason,
                  'remarks': item.remarks,
                  'healthRatingUserLatitude': item.healthRatingUserLatitude,
                  'healthRatingUserLongitude': item.healthRatingUserLongitude,
                  'hIsSynced': item.hIsSynced
                }),
        _healthRatingEntityUpdateAdapter = UpdateAdapter(
            database,
            'HealthRating',
            ['HRowId'],
            (HealthRatingEntity item) => <String, Object?>{
                  'HRowId': item.HRowId,
                  'userID': item.userID,
                  'healthRatingTimeStamp': item.healthRatingTimeStamp,
                  'riskRating': item.riskRating,
                  'remarkStatusTime': item.remarkStatusTime,
                  'reasonToShow': item.reasonToShow,
                  'isRemarkSync': item.isRemarkSync,
                  'riskValue': item.riskValue,
                  'travelStatus': item.travelStatus,
                  'travelReason': item.travelReason,
                  'remarks': item.remarks,
                  'healthRatingUserLatitude': item.healthRatingUserLatitude,
                  'healthRatingUserLongitude': item.healthRatingUserLongitude,
                  'hIsSynced': item.hIsSynced
                }),
        _healthRatingEntityDeletionAdapter = DeletionAdapter(
            database,
            'HealthRating',
            ['HRowId'],
            (HealthRatingEntity item) => <String, Object?>{
                  'HRowId': item.HRowId,
                  'userID': item.userID,
                  'healthRatingTimeStamp': item.healthRatingTimeStamp,
                  'riskRating': item.riskRating,
                  'remarkStatusTime': item.remarkStatusTime,
                  'reasonToShow': item.reasonToShow,
                  'isRemarkSync': item.isRemarkSync,
                  'riskValue': item.riskValue,
                  'travelStatus': item.travelStatus,
                  'travelReason': item.travelReason,
                  'remarks': item.remarks,
                  'healthRatingUserLatitude': item.healthRatingUserLatitude,
                  'healthRatingUserLongitude': item.healthRatingUserLongitude,
                  'hIsSynced': item.hIsSynced
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<HealthRatingEntity>
      _healthRatingEntityInsertionAdapter;

  final UpdateAdapter<HealthRatingEntity> _healthRatingEntityUpdateAdapter;

  final DeletionAdapter<HealthRatingEntity> _healthRatingEntityDeletionAdapter;

  @override
  Future<List<HealthRatingEntity>> findAllHealthRating() async {
    return _queryAdapter.queryList('SELECT * FROM HealthRating',
        mapper: (Map<String, Object?> row) => HealthRatingEntity(
            HRowId: row['HRowId'] as int?,
            userID: row['userID'] as String?,
            healthRatingTimeStamp: row['healthRatingTimeStamp'] as String?,
            riskRating: row['riskRating'] as String?,
            remarkStatusTime: row['remarkStatusTime'] as String?,
            reasonToShow: row['reasonToShow'] as String?,
            isRemarkSync: row['isRemarkSync'] as int?,
            riskValue: row['riskValue'] as String?,
            travelStatus: row['travelStatus'] as String?,
            travelReason: row['travelReason'] as String?,
            remarks: row['remarks'] as String?,
            healthRatingUserLatitude:
                row['healthRatingUserLatitude'] as String?,
            healthRatingUserLongitude:
                row['healthRatingUserLongitude'] as String?,
            hIsSynced: row['hIsSynced'] as String?));
  }

  @override
  Future<HealthRatingEntity?> findHealthRatingById(int id) async {
    return _queryAdapter.query('SELECT * FROM HealthRating WHERE HRowId = ?1',
        mapper: (Map<String, Object?> row) => HealthRatingEntity(
            HRowId: row['HRowId'] as int?,
            userID: row['userID'] as String?,
            healthRatingTimeStamp: row['healthRatingTimeStamp'] as String?,
            riskRating: row['riskRating'] as String?,
            remarkStatusTime: row['remarkStatusTime'] as String?,
            reasonToShow: row['reasonToShow'] as String?,
            isRemarkSync: row['isRemarkSync'] as int?,
            riskValue: row['riskValue'] as String?,
            travelStatus: row['travelStatus'] as String?,
            travelReason: row['travelReason'] as String?,
            remarks: row['remarks'] as String?,
            healthRatingUserLatitude:
                row['healthRatingUserLatitude'] as String?,
            healthRatingUserLongitude:
                row['healthRatingUserLongitude'] as String?,
            hIsSynced: row['hIsSynced'] as String?),
        arguments: [id]);
  }

  @override
  Future<HealthRatingEntity?> findLastHealthRating() async {
    return _queryAdapter.query(
        'SELECT * FROM HealthRating ORDER BY HRowId DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => HealthRatingEntity(
            HRowId: row['HRowId'] as int?,
            userID: row['userID'] as String?,
            healthRatingTimeStamp: row['healthRatingTimeStamp'] as String?,
            riskRating: row['riskRating'] as String?,
            remarkStatusTime: row['remarkStatusTime'] as String?,
            reasonToShow: row['reasonToShow'] as String?,
            isRemarkSync: row['isRemarkSync'] as int?,
            riskValue: row['riskValue'] as String?,
            travelStatus: row['travelStatus'] as String?,
            travelReason: row['travelReason'] as String?,
            remarks: row['remarks'] as String?,
            healthRatingUserLatitude:
                row['healthRatingUserLatitude'] as String?,
            healthRatingUserLongitude:
                row['healthRatingUserLongitude'] as String?,
            hIsSynced: row['hIsSynced'] as String?));
  }

  @override
  Future<void> markAllAsSynced() async {
    await _queryAdapter.queryNoReturn('UPDATE HealthRating SET hIsSynced = 1');
  }

  @override
  Future<void> deleteAllHealthRating() async {
    await _queryAdapter.queryNoReturn('DELETE FROM HealthRating');
  }

  @override
  Future<void> insertHealthRating(HealthRatingEntity healthRatingEntity) async {
    await _healthRatingEntityInsertionAdapter.insert(
        healthRatingEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateHealthRating(HealthRatingEntity healthRatingEntity) async {
    await _healthRatingEntityUpdateAdapter.update(
        healthRatingEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteHealthRating(HealthRatingEntity healthRatingEntity) async {
    await _healthRatingEntityDeletionAdapter.delete(healthRatingEntity);
  }
}

class _$ActivitySummaryDao extends ActivitySummaryDao {
  _$ActivitySummaryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _activitySummaryInsertionAdapter = InsertionAdapter(
            database,
            'ActivitySummary',
            (ActivitySummary item) => <String, Object?>{
                  'RowID': item.RowID,
                  'UID': item.UID,
                  'ActivityType': item.ActivityType,
                  'ActivityDate': _dateTimeConverter.encode(item.ActivityDate),
                  'date': item.date,
                  'ActivityTotalTime': item.ActivityTotalTime,
                  'ActivityValue': item.ActivityValue,
                  'IsAutomatedReading': item.IsAutomatedReading ? 1 : 0,
                  'DeviceType': item.DeviceType,
                  'IsSynced': item.IsSynced ? 1 : 0,
                  'IsGoogleFitSync': item.IsGoogleFitSync ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ActivitySummary> _activitySummaryInsertionAdapter;

  @override
  Future<List<ActivitySummary>> getAllSummary() async {
    return _queryAdapter.queryList(
        'SELECT * FROM ActivitySummary ORDER BY ActivityDate ASC',
        mapper: (Map<String, Object?> row) => ActivitySummary(
            UID: row['UID'] as String,
            ActivityType: row['ActivityType'] as String,
            ActivityDate: _dateTimeConverter.decode(row['ActivityDate'] as int),
            date: row['date'] as String,
            ActivityTotalTime: row['ActivityTotalTime'] as int,
            ActivityValue: row['ActivityValue'] as double,
            IsAutomatedReading: (row['IsAutomatedReading'] as int) != 0,
            DeviceType: row['DeviceType'] as String,
            IsSynced: (row['IsSynced'] as int) != 0,
            IsGoogleFitSync: (row['IsGoogleFitSync'] as int) != 0));
  }

  @override
  Future<List<ActivitySummary>> getSummaryBetween(
    DateTime startDate,
    DateTime endDate,
    String activityType,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM ActivitySummary WHERE ActivityType = ?3 AND ActivityDate BETWEEN ?1 AND ?2 ORDER BY ActivityDate ASC',
        mapper: (Map<String, Object?> row) => ActivitySummary(
            UID: row['UID'] as String,
            ActivityType: row['ActivityType'] as String,
            ActivityDate: _dateTimeConverter.decode(row['ActivityDate'] as int),
            date: row['date'] as String,
            ActivityTotalTime: row['ActivityTotalTime'] as int,
            ActivityValue: row['ActivityValue'] as double,
            IsAutomatedReading: (row['IsAutomatedReading'] as int) != 0,
            DeviceType: row['DeviceType'] as String,
            IsSynced: (row['IsSynced'] as int) != 0,
            IsGoogleFitSync: (row['IsGoogleFitSync'] as int) != 0),
        arguments: [
          _dateTimeConverter.encode(startDate),
          _dateTimeConverter.encode(endDate),
          activityType
        ]);
  }

  @override
  Future<List<ActivitySummary>> getSummaryForDate(DateTime date) async {
    return _queryAdapter.queryList(
        'SELECT * FROM ActivitySummary WHERE ActivityDate = ?1 ORDER BY ActivityDate ASC',
        mapper: (Map<String, Object?> row) => ActivitySummary(UID: row['UID'] as String, ActivityType: row['ActivityType'] as String, ActivityDate: _dateTimeConverter.decode(row['ActivityDate'] as int), date: row['date'] as String, ActivityTotalTime: row['ActivityTotalTime'] as int, ActivityValue: row['ActivityValue'] as double, IsAutomatedReading: (row['IsAutomatedReading'] as int) != 0, DeviceType: row['DeviceType'] as String, IsSynced: (row['IsSynced'] as int) != 0, IsGoogleFitSync: (row['IsGoogleFitSync'] as int) != 0),
        arguments: [_dateTimeConverter.encode(date)]);
  }

  @override
  Future<ActivitySummary?> getLastSummary(String activityType) async {
    return _queryAdapter.query(
        'SELECT * FROM ActivitySummary WHERE ActivityType = ?1 ORDER BY ActivityDate DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => ActivitySummary(UID: row['UID'] as String, ActivityType: row['ActivityType'] as String, ActivityDate: _dateTimeConverter.decode(row['ActivityDate'] as int), date: row['date'] as String, ActivityTotalTime: row['ActivityTotalTime'] as int, ActivityValue: row['ActivityValue'] as double, IsAutomatedReading: (row['IsAutomatedReading'] as int) != 0, DeviceType: row['DeviceType'] as String, IsSynced: (row['IsSynced'] as int) != 0, IsGoogleFitSync: (row['IsGoogleFitSync'] as int) != 0),
        arguments: [activityType]);
  }

  @override
  Future<List<ActivitySummary>> getSummaryToUpload(String activityType) async {
    return _queryAdapter.queryList(
        'SELECT * FROM ActivitySummary WHERE ActivityType = ?1 AND IsSynced = 0 ORDER BY ActivityDate ASC',
        mapper: (Map<String, Object?> row) => ActivitySummary(UID: row['UID'] as String, ActivityType: row['ActivityType'] as String, ActivityDate: _dateTimeConverter.decode(row['ActivityDate'] as int), date: row['date'] as String, ActivityTotalTime: row['ActivityTotalTime'] as int, ActivityValue: row['ActivityValue'] as double, IsAutomatedReading: (row['IsAutomatedReading'] as int) != 0, DeviceType: row['DeviceType'] as String, IsSynced: (row['IsSynced'] as int) != 0, IsGoogleFitSync: (row['IsGoogleFitSync'] as int) != 0),
        arguments: [activityType]);
  }

  @override
  Future<void> markAllReadingsAsSynced() async {
    await _queryAdapter
        .queryNoReturn('UPDATE ActivitySummary SET IsSynced = 1');
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM ActivitySummary');
  }

  @override
  Future<void> insertAllSummary(List<ActivitySummary> readings) async {
    await _activitySummaryInsertionAdapter.insertList(
        readings, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertSummary(ActivitySummary reading) async {
    await _activitySummaryInsertionAdapter.insert(
        reading, OnConflictStrategy.replace);
  }
}

class _$ActivityDetailsDao extends ActivityDetailsDao {
  _$ActivityDetailsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _activityDetailsInsertionAdapter = InsertionAdapter(
            database,
            'ActivityDetails',
            (ActivityDetails item) => <String, Object?>{
                  'RowID': item.RowID,
                  'UID': item.UID,
                  'ActivityType': item.ActivityType,
                  'ActivityStartDate':
                      _dateTimeConverter.encode(item.ActivityStartDate),
                  'ActivityEndDate':
                      _dateTimeConverter.encode(item.ActivityEndDate),
                  'date': item.date,
                  'ActivityValue': item.ActivityValue,
                  'IsAutomatedReading': item.IsAutomatedReading ? 1 : 0,
                  'ActivityTotalSleep': item.ActivityTotalSleep,
                  'DeviceType': item.DeviceType,
                  'IsSynced': item.IsSynced ? 1 : 0,
                  'IsGoogleFitSync': item.IsGoogleFitSync ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ActivityDetails> _activityDetailsInsertionAdapter;

  @override
  Future<List<ActivityDetails>> getAllActivityDetails() async {
    return _queryAdapter.queryList(
        'SELECT * FROM ActivityDetails ORDER BY ActivityStartDate ASC',
        mapper: (Map<String, Object?> row) => ActivityDetails(
            UID: row['UID'] as String,
            ActivityType: row['ActivityType'] as String,
            ActivityStartDate:
                _dateTimeConverter.decode(row['ActivityStartDate'] as int),
            ActivityEndDate:
                _dateTimeConverter.decode(row['ActivityEndDate'] as int),
            date: row['date'] as String,
            ActivityValue: row['ActivityValue'] as double,
            IsAutomatedReading: (row['IsAutomatedReading'] as int) != 0,
            ActivityTotalSleep: row['ActivityTotalSleep'] as int,
            DeviceType: row['DeviceType'] as String,
            IsSynced: (row['IsSynced'] as int) != 0,
            IsGoogleFitSync: (row['IsGoogleFitSync'] as int) != 0));
  }

  @override
  Future<List<ActivityDetails>> getActivityDetailsBetween(
    DateTime startDate,
    DateTime endDate,
    String activityType,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM ActivityDetails WHERE ActivityType = ?3 AND ActivityStartDate BETWEEN ?1 AND ?2 ORDER BY ActivityStartDate ASC',
        mapper: (Map<String, Object?> row) => ActivityDetails(
            UID: row['UID'] as String,
            ActivityType: row['ActivityType'] as String,
            ActivityStartDate:
                _dateTimeConverter.decode(row['ActivityStartDate'] as int),
            ActivityEndDate:
                _dateTimeConverter.decode(row['ActivityEndDate'] as int),
            date: row['date'] as String,
            ActivityValue: row['ActivityValue'] as double,
            IsAutomatedReading: (row['IsAutomatedReading'] as int) != 0,
            ActivityTotalSleep: row['ActivityTotalSleep'] as int,
            DeviceType: row['DeviceType'] as String,
            IsSynced: (row['IsSynced'] as int) != 0,
            IsGoogleFitSync: (row['IsGoogleFitSync'] as int) != 0),
        arguments: [
          _dateTimeConverter.encode(startDate),
          _dateTimeConverter.encode(endDate),
          activityType
        ]);
  }

  @override
  Future<List<ActivityDetails>> getDetailsBetween(
    String wildcard,
    String startDate,
    String endDate,
    String activityType,
  ) async {
    return _queryAdapter.queryList(
        'SELECT RowID,UID,ActivityType,ActivityStartDate,ActivityEndDate,DeviceType,IsAutomatedReading,IsSynced,IsGoogleFitSync, strftime(?1,date) as date, sum(ActivityValue) as ActivityValue,((ActivityEndDate - ActivityStartDate)/1000) as ActivityTotalSleep FROM ActivityDetails WHERE ActivityType = ?4 AND date BETWEEN ?2 AND ?3 GROUP BY strftime(?1,date)',
        mapper: (Map<String, Object?> row) => ActivityDetails(UID: row['UID'] as String, ActivityType: row['ActivityType'] as String, ActivityStartDate: _dateTimeConverter.decode(row['ActivityStartDate'] as int), ActivityEndDate: _dateTimeConverter.decode(row['ActivityEndDate'] as int), date: row['date'] as String, ActivityValue: row['ActivityValue'] as double, IsAutomatedReading: (row['IsAutomatedReading'] as int) != 0, ActivityTotalSleep: row['ActivityTotalSleep'] as int, DeviceType: row['DeviceType'] as String, IsSynced: (row['IsSynced'] as int) != 0, IsGoogleFitSync: (row['IsGoogleFitSync'] as int) != 0),
        arguments: [wildcard, startDate, endDate, activityType]);
  }

  @override
  Future<List<ActivityDetails>> getActivityDetailsForDate(
    DateTime date,
    String activityType,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM ActivityDetails WHERE date(ActivityStartDate) = date(?1) AND ActivityType = ?2 ORDER BY ActivityStartDate ASC',
        mapper: (Map<String, Object?> row) => ActivityDetails(UID: row['UID'] as String, ActivityType: row['ActivityType'] as String, ActivityStartDate: _dateTimeConverter.decode(row['ActivityStartDate'] as int), ActivityEndDate: _dateTimeConverter.decode(row['ActivityEndDate'] as int), date: row['date'] as String, ActivityValue: row['ActivityValue'] as double, IsAutomatedReading: (row['IsAutomatedReading'] as int) != 0, ActivityTotalSleep: row['ActivityTotalSleep'] as int, DeviceType: row['DeviceType'] as String, IsSynced: (row['IsSynced'] as int) != 0, IsGoogleFitSync: (row['IsGoogleFitSync'] as int) != 0),
        arguments: [_dateTimeConverter.encode(date), activityType]);
  }

  @override
  Future<List<ActivityDetails>> getDetailsToUpload(String activityType) async {
    return _queryAdapter.queryList(
        'SELECT * FROM ActivityDetails WHERE ActivityType = ?1 AND IsSynced = 0 ORDER BY ActivityStartDate ASC',
        mapper: (Map<String, Object?> row) => ActivityDetails(UID: row['UID'] as String, ActivityType: row['ActivityType'] as String, ActivityStartDate: _dateTimeConverter.decode(row['ActivityStartDate'] as int), ActivityEndDate: _dateTimeConverter.decode(row['ActivityEndDate'] as int), date: row['date'] as String, ActivityValue: row['ActivityValue'] as double, IsAutomatedReading: (row['IsAutomatedReading'] as int) != 0, ActivityTotalSleep: row['ActivityTotalSleep'] as int, DeviceType: row['DeviceType'] as String, IsSynced: (row['IsSynced'] as int) != 0, IsGoogleFitSync: (row['IsGoogleFitSync'] as int) != 0),
        arguments: [activityType]);
  }

  @override
  Future<ActivityDetails?> getLastDetails(String activityType) async {
    return _queryAdapter.query(
        'SELECT * FROM ActivityDetails WHERE ActivityType = ?1 ORDER BY ActivityStartDate DESC',
        mapper: (Map<String, Object?> row) => ActivityDetails(UID: row['UID'] as String, ActivityType: row['ActivityType'] as String, ActivityStartDate: _dateTimeConverter.decode(row['ActivityStartDate'] as int), ActivityEndDate: _dateTimeConverter.decode(row['ActivityEndDate'] as int), date: row['date'] as String, ActivityValue: row['ActivityValue'] as double, IsAutomatedReading: (row['IsAutomatedReading'] as int) != 0, ActivityTotalSleep: row['ActivityTotalSleep'] as int, DeviceType: row['DeviceType'] as String, IsSynced: (row['IsSynced'] as int) != 0, IsGoogleFitSync: (row['IsGoogleFitSync'] as int) != 0),
        arguments: [activityType]);
  }

  @override
  Future<void> markAllAsSynced() async {
    await _queryAdapter
        .queryNoReturn('UPDATE ActivityDetails SET IsSynced = 1');
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM ActivityDetails');
  }

  @override
  Future<List<ActivityDetails>> getUnSynchedActivityForHealth() async {
    return _queryAdapter.queryList(
        'SELECT * FROM ActivityDetails WHERE IsGoogleFitSync = 0 ORDER BY ActivityStartDate ASC',
        mapper: (Map<String, Object?> row) => ActivityDetails(
            UID: row['UID'] as String,
            ActivityType: row['ActivityType'] as String,
            ActivityStartDate:
                _dateTimeConverter.decode(row['ActivityStartDate'] as int),
            ActivityEndDate:
                _dateTimeConverter.decode(row['ActivityEndDate'] as int),
            date: row['date'] as String,
            ActivityValue: row['ActivityValue'] as double,
            IsAutomatedReading: (row['IsAutomatedReading'] as int) != 0,
            ActivityTotalSleep: row['ActivityTotalSleep'] as int,
            DeviceType: row['DeviceType'] as String,
            IsSynced: (row['IsSynced'] as int) != 0,
            IsGoogleFitSync: (row['IsGoogleFitSync'] as int) != 0));
  }

  @override
  Future<void> insertAllDetails(List<ActivityDetails> allDetails) async {
    await _activityDetailsInsertionAdapter.insertList(
        allDetails, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertDetails(ActivityDetails details) async {
    await _activityDetailsInsertionAdapter.insert(
        details, OnConflictStrategy.replace);
  }
}

class _$UserProfileInfoDao extends UserProfileInfoDao {
  _$UserProfileInfoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _userProfileEntiryInsertionAdapter = InsertionAdapter(
            database,
            'UserProfile',
            (UserProfileEntiry item) => <String, Object?>{
                  'UID': item.uID,
                  'FirstName': item.firstName,
                  'LastName': item.lastName,
                  'EmailId': item.emailId,
                  'MobileNo': item.mobileNo,
                  'Gender': item.gender,
                  'Weight': item.weight,
                  'Height': item.height,
                  'DOB': item.dateOfBirth,
                  'ProfilePhoto': item.cropUserProfilePicture,
                  'LoginSource': item.loginSource,
                  'SourceToken': item.sourceToken,
                  'AuthorizationToken': item.authorizationToken,
                  'TokenExpiryTime': item.tokenExpiryTime,
                  'CreationDate': item.dateCreated
                }),
        _userProfileEntiryUpdateAdapter = UpdateAdapter(
            database,
            'UserProfile',
            ['UID'],
            (UserProfileEntiry item) => <String, Object?>{
                  'UID': item.uID,
                  'FirstName': item.firstName,
                  'LastName': item.lastName,
                  'EmailId': item.emailId,
                  'MobileNo': item.mobileNo,
                  'Gender': item.gender,
                  'Weight': item.weight,
                  'Height': item.height,
                  'DOB': item.dateOfBirth,
                  'ProfilePhoto': item.cropUserProfilePicture,
                  'LoginSource': item.loginSource,
                  'SourceToken': item.sourceToken,
                  'AuthorizationToken': item.authorizationToken,
                  'TokenExpiryTime': item.tokenExpiryTime,
                  'CreationDate': item.dateCreated
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserProfileEntiry> _userProfileEntiryInsertionAdapter;

  final UpdateAdapter<UserProfileEntiry> _userProfileEntiryUpdateAdapter;

  @override
  Future<UserProfileEntiry?> getUserProfile() async {
    return _queryAdapter.query('SELECT * FROM UserProfile LIMIT 1',
        mapper: (Map<String, Object?> row) => UserProfileEntiry(
            uID: row['UID'] as String?,
            firstName: row['FirstName'] as String?,
            lastName: row['LastName'] as String?,
            mobileNo: row['MobileNo'] as String?,
            emailId: row['EmailId'] as String?,
            gender: row['Gender'] as String?,
            weight: row['Weight'] as int?,
            height: row['Height'] as int?,
            dateOfBirth: row['DOB'] as String?,
            dateCreated: row['CreationDate'] as String?,
            cropUserProfilePicture: row['ProfilePhoto'] as String?,
            loginSource: row['LoginSource'] as String?,
            sourceToken: row['SourceToken'] as String?,
            authorizationToken: row['AuthorizationToken'] as String?,
            tokenExpiryTime: row['TokenExpiryTime'] as String?));
  }

  @override
  Future<void> deleteUserProfile() async {
    await _queryAdapter.queryNoReturn('DELETE FROM UserProfile');
  }

  @override
  Future<void> insertUserProfile(UserProfileEntiry userProfileInfo) async {
    await _userProfileEntiryInsertionAdapter.insert(
        userProfileInfo, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateUserProfile(UserProfileEntiry userProfileInfo) async {
    await _userProfileEntiryUpdateAdapter.update(
        userProfileInfo, OnConflictStrategy.replace);
  }
}

class _$NotificationDao extends NotificationDao {
  _$NotificationDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _notificationEntityInsertionAdapter = InsertionAdapter(
            database,
            'NotificationMessageTable',
            (NotificationEntity item) => <String, Object?>{
                  'NotificationId': item.notificationId,
                  'NotificationTitle': item.notificationTitle,
                  'NotificationMessage': item.notificationMessage,
                  'NotificationTime': item.notificationTime,
                  'NotificationType': item.notificationType,
                  'NotificationImage': item.notificationImage,
                  'NotificationTargetPage': item.appTarget,
                  'TargetPlatform': item.targetPlatform,
                  'NotificationData': item.notificationData,
                  'IsSeen': item.isSeen ? 1 : 0
                }),
        _notificationEntityUpdateAdapter = UpdateAdapter(
            database,
            'NotificationMessageTable',
            ['NotificationId'],
            (NotificationEntity item) => <String, Object?>{
                  'NotificationId': item.notificationId,
                  'NotificationTitle': item.notificationTitle,
                  'NotificationMessage': item.notificationMessage,
                  'NotificationTime': item.notificationTime,
                  'NotificationType': item.notificationType,
                  'NotificationImage': item.notificationImage,
                  'NotificationTargetPage': item.appTarget,
                  'TargetPlatform': item.targetPlatform,
                  'NotificationData': item.notificationData,
                  'IsSeen': item.isSeen ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<NotificationEntity>
      _notificationEntityInsertionAdapter;

  final UpdateAdapter<NotificationEntity> _notificationEntityUpdateAdapter;

  @override
  Future<List<NotificationEntity>> getNotifications() async {
    return _queryAdapter.queryList(
        'SELECT * FROM NotificationMessageTable ORDER BY NotificationId DESC',
        mapper: (Map<String, Object?> row) => NotificationEntity(
            notificationId: row['NotificationId'] as String?,
            notificationTime: row['NotificationTime'] as String?,
            notificationType: row['NotificationType'] as String?,
            appTarget: row['NotificationTargetPage'] as String?,
            notificationTitle: row['NotificationTitle'] as String?,
            notificationMessage: row['NotificationMessage'] as String?,
            targetPlatform: row['TargetPlatform'] as String?,
            notificationImage: row['NotificationImage'] as String?,
            notificationData: row['NotificationData'] as String?,
            isSeen: (row['IsSeen'] as int) != 0));
  }

  @override
  Future<NotificationEntity?> getNotification(String id) async {
    return _queryAdapter.query(
        'SELECT * FROM NotificationMessageTable WHERE NotificationId = ?1',
        mapper: (Map<String, Object?> row) => NotificationEntity(
            notificationId: row['NotificationId'] as String?,
            notificationTime: row['NotificationTime'] as String?,
            notificationType: row['NotificationType'] as String?,
            appTarget: row['NotificationTargetPage'] as String?,
            notificationTitle: row['NotificationTitle'] as String?,
            notificationMessage: row['NotificationMessage'] as String?,
            targetPlatform: row['TargetPlatform'] as String?,
            notificationImage: row['NotificationImage'] as String?,
            notificationData: row['NotificationData'] as String?,
            isSeen: (row['IsSeen'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<int?> getUnreadNotificationCount() async {
    return _queryAdapter.query(
        'SELECT COUNT(*) FROM NotificationMessageTable WHERE IsSeen = 0',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<void> markAllNotificationsAsRead() async {
    await _queryAdapter
        .queryNoReturn('UPDATE NotificationMessageTable SET IsSeen = 1');
  }

  @override
  Future<void> markNotificationAsRead(String notificationId) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE NotificationMessageTable SET IsSeen = 1 WHERE NotificationId = ?1',
        arguments: [notificationId]);
  }

  @override
  Future<void> deleteAllNotifications() async {
    await _queryAdapter.queryNoReturn('DELETE FROM NotificationMessageTable');
  }

  @override
  Future<void> insertNotification(NotificationEntity notificationEntity) async {
    await _notificationEntityInsertionAdapter.insert(
        notificationEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertNotifications(
      List<NotificationEntity> notificationEntity) async {
    await _notificationEntityInsertionAdapter.insertList(
        notificationEntity, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateNotification(NotificationEntity notificationEntity) async {
    await _notificationEntityUpdateAdapter.update(
        notificationEntity, OnConflictStrategy.replace);
  }
}

class _$VaccinationTestDao extends VaccinationTestDao {
  _$VaccinationTestDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _vaccinationTestEntityInsertionAdapter = InsertionAdapter(
            database,
            'VaccinationTest',
            (VaccinationTestEntity item) => <String, Object?>{
                  'RowID': item.RowID,
                  'diseaseType': item.diseaseType,
                  'vacId': item.vacId,
                  'referenceNumber': item.referenceNumber,
                  'vaccinationType': item.vaccinationType,
                  'vaccinationName': item.vaccinationName,
                  'vaccinationDate': item.vaccinationDate,
                  'docUrl': item.docUrl,
                  'vaccinationThumbnail': item.vaccinationThumbnail,
                  'courseStatus': item.courseStatus,
                  'uid': item.uid,
                  'validationAuthority': item.validationAuthority,
                  'diseaseCode': item.diseaseCode,
                  'country': item.country,
                  'testResult': item.testResult,
                  'vaccinationFileType': item.vaccinationFileType,
                  'vaccinationLocation': item.vaccinationLocation,
                  'beneficiaryAge': item.beneficiaryAge,
                  'beneficiaryGender': item.beneficiaryGender,
                  'vaccinationQRCode': item.vaccinationQRCode,
                  'timestamp': item.timestamp,
                  'beneficiaryName': item.beneficiaryName,
                  'vaccinationStatus': item.vaccinationStatus,
                  'isSynced': item.isSynced
                }),
        _vaccinationTestEntityUpdateAdapter = UpdateAdapter(
            database,
            'VaccinationTest',
            ['RowID'],
            (VaccinationTestEntity item) => <String, Object?>{
                  'RowID': item.RowID,
                  'diseaseType': item.diseaseType,
                  'vacId': item.vacId,
                  'referenceNumber': item.referenceNumber,
                  'vaccinationType': item.vaccinationType,
                  'vaccinationName': item.vaccinationName,
                  'vaccinationDate': item.vaccinationDate,
                  'docUrl': item.docUrl,
                  'vaccinationThumbnail': item.vaccinationThumbnail,
                  'courseStatus': item.courseStatus,
                  'uid': item.uid,
                  'validationAuthority': item.validationAuthority,
                  'diseaseCode': item.diseaseCode,
                  'country': item.country,
                  'testResult': item.testResult,
                  'vaccinationFileType': item.vaccinationFileType,
                  'vaccinationLocation': item.vaccinationLocation,
                  'beneficiaryAge': item.beneficiaryAge,
                  'beneficiaryGender': item.beneficiaryGender,
                  'vaccinationQRCode': item.vaccinationQRCode,
                  'timestamp': item.timestamp,
                  'beneficiaryName': item.beneficiaryName,
                  'vaccinationStatus': item.vaccinationStatus,
                  'isSynced': item.isSynced
                }),
        _vaccinationTestEntityDeletionAdapter = DeletionAdapter(
            database,
            'VaccinationTest',
            ['RowID'],
            (VaccinationTestEntity item) => <String, Object?>{
                  'RowID': item.RowID,
                  'diseaseType': item.diseaseType,
                  'vacId': item.vacId,
                  'referenceNumber': item.referenceNumber,
                  'vaccinationType': item.vaccinationType,
                  'vaccinationName': item.vaccinationName,
                  'vaccinationDate': item.vaccinationDate,
                  'docUrl': item.docUrl,
                  'vaccinationThumbnail': item.vaccinationThumbnail,
                  'courseStatus': item.courseStatus,
                  'uid': item.uid,
                  'validationAuthority': item.validationAuthority,
                  'diseaseCode': item.diseaseCode,
                  'country': item.country,
                  'testResult': item.testResult,
                  'vaccinationFileType': item.vaccinationFileType,
                  'vaccinationLocation': item.vaccinationLocation,
                  'beneficiaryAge': item.beneficiaryAge,
                  'beneficiaryGender': item.beneficiaryGender,
                  'vaccinationQRCode': item.vaccinationQRCode,
                  'timestamp': item.timestamp,
                  'beneficiaryName': item.beneficiaryName,
                  'vaccinationStatus': item.vaccinationStatus,
                  'isSynced': item.isSynced
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<VaccinationTestEntity>
      _vaccinationTestEntityInsertionAdapter;

  final UpdateAdapter<VaccinationTestEntity>
      _vaccinationTestEntityUpdateAdapter;

  final DeletionAdapter<VaccinationTestEntity>
      _vaccinationTestEntityDeletionAdapter;

  @override
  Future<List<VaccinationTestEntity>> findAllVaccinationTest() async {
    return _queryAdapter.queryList('SELECT * FROM VaccinationTest',
        mapper: (Map<String, Object?> row) => VaccinationTestEntity(
            RowID: row['RowID'] as int?,
            diseaseType: row['diseaseType'] as String?,
            vacId: row['vacId'] as String?,
            referenceNumber: row['referenceNumber'] as String?,
            vaccinationType: row['vaccinationType'] as String?,
            vaccinationName: row['vaccinationName'] as String?,
            vaccinationDate: row['vaccinationDate'] as String?,
            docUrl: row['docUrl'] as String?,
            vaccinationThumbnail: row['vaccinationThumbnail'] as String?,
            courseStatus: row['courseStatus'] as String?,
            uid: row['uid'] as String?,
            validationAuthority: row['validationAuthority'] as String?,
            diseaseCode: row['diseaseCode'] as String?,
            country: row['country'] as String?,
            testResult: row['testResult'] as String?,
            vaccinationFileType: row['vaccinationFileType'] as String?,
            vaccinationLocation: row['vaccinationLocation'] as String?,
            beneficiaryAge: row['beneficiaryAge'] as String?,
            beneficiaryGender: row['beneficiaryGender'] as String?,
            vaccinationQRCode: row['vaccinationQRCode'] as String?,
            timestamp: row['timestamp'] as String?,
            beneficiaryName: row['beneficiaryName'] as String?,
            vaccinationStatus: row['vaccinationStatus'] as String?,
            isSynced: row['isSynced'] as String?));
  }

  @override
  Future<List<VaccinationTestEntity>> findAllByType(
      String vaccinationType) async {
    return _queryAdapter.queryList(
        'SELECT * FROM VaccinationTest WHERE vaccinationType = ?1',
        mapper: (Map<String, Object?> row) => VaccinationTestEntity(
            RowID: row['RowID'] as int?,
            diseaseType: row['diseaseType'] as String?,
            vacId: row['vacId'] as String?,
            referenceNumber: row['referenceNumber'] as String?,
            vaccinationType: row['vaccinationType'] as String?,
            vaccinationName: row['vaccinationName'] as String?,
            vaccinationDate: row['vaccinationDate'] as String?,
            docUrl: row['docUrl'] as String?,
            vaccinationThumbnail: row['vaccinationThumbnail'] as String?,
            courseStatus: row['courseStatus'] as String?,
            uid: row['uid'] as String?,
            validationAuthority: row['validationAuthority'] as String?,
            diseaseCode: row['diseaseCode'] as String?,
            country: row['country'] as String?,
            testResult: row['testResult'] as String?,
            vaccinationFileType: row['vaccinationFileType'] as String?,
            vaccinationLocation: row['vaccinationLocation'] as String?,
            beneficiaryAge: row['beneficiaryAge'] as String?,
            beneficiaryGender: row['beneficiaryGender'] as String?,
            vaccinationQRCode: row['vaccinationQRCode'] as String?,
            timestamp: row['timestamp'] as String?,
            beneficiaryName: row['beneficiaryName'] as String?,
            vaccinationStatus: row['vaccinationStatus'] as String?,
            isSynced: row['isSynced'] as String?),
        arguments: [vaccinationType]);
  }

  @override
  Future<List<VaccinationTestEntity>> findAllByDateTypeAndDisease(
    String diseaseCode,
    String vaccinationType,
    String startDate,
    String endDate,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM VaccinationTest WHERE diseaseCode = ?1 AND vaccinationType = ?2 AND vaccinationDate BETWEEN ?3 AND ?4',
        mapper: (Map<String, Object?> row) => VaccinationTestEntity(RowID: row['RowID'] as int?, diseaseType: row['diseaseType'] as String?, vacId: row['vacId'] as String?, referenceNumber: row['referenceNumber'] as String?, vaccinationType: row['vaccinationType'] as String?, vaccinationName: row['vaccinationName'] as String?, vaccinationDate: row['vaccinationDate'] as String?, docUrl: row['docUrl'] as String?, vaccinationThumbnail: row['vaccinationThumbnail'] as String?, courseStatus: row['courseStatus'] as String?, uid: row['uid'] as String?, validationAuthority: row['validationAuthority'] as String?, diseaseCode: row['diseaseCode'] as String?, country: row['country'] as String?, testResult: row['testResult'] as String?, vaccinationFileType: row['vaccinationFileType'] as String?, vaccinationLocation: row['vaccinationLocation'] as String?, beneficiaryAge: row['beneficiaryAge'] as String?, beneficiaryGender: row['beneficiaryGender'] as String?, vaccinationQRCode: row['vaccinationQRCode'] as String?, timestamp: row['timestamp'] as String?, beneficiaryName: row['beneficiaryName'] as String?, vaccinationStatus: row['vaccinationStatus'] as String?, isSynced: row['isSynced'] as String?),
        arguments: [diseaseCode, vaccinationType, startDate, endDate]);
  }

  @override
  Future<List<VaccinationTestEntity>> findAllByName(
    String vaccinationName,
    String startDate,
    String endDate,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM VaccinationTest WHERE vaccinationName = ?1 AND vaccinationDate BETWEEN ?2 AND ?3',
        mapper: (Map<String, Object?> row) => VaccinationTestEntity(RowID: row['RowID'] as int?, diseaseType: row['diseaseType'] as String?, vacId: row['vacId'] as String?, referenceNumber: row['referenceNumber'] as String?, vaccinationType: row['vaccinationType'] as String?, vaccinationName: row['vaccinationName'] as String?, vaccinationDate: row['vaccinationDate'] as String?, docUrl: row['docUrl'] as String?, vaccinationThumbnail: row['vaccinationThumbnail'] as String?, courseStatus: row['courseStatus'] as String?, uid: row['uid'] as String?, validationAuthority: row['validationAuthority'] as String?, diseaseCode: row['diseaseCode'] as String?, country: row['country'] as String?, testResult: row['testResult'] as String?, vaccinationFileType: row['vaccinationFileType'] as String?, vaccinationLocation: row['vaccinationLocation'] as String?, beneficiaryAge: row['beneficiaryAge'] as String?, beneficiaryGender: row['beneficiaryGender'] as String?, vaccinationQRCode: row['vaccinationQRCode'] as String?, timestamp: row['timestamp'] as String?, beneficiaryName: row['beneficiaryName'] as String?, vaccinationStatus: row['vaccinationStatus'] as String?, isSynced: row['isSynced'] as String?),
        arguments: [vaccinationName, startDate, endDate]);
  }

  @override
  Future<void> deleteAllVaccinationTest() async {
    await _queryAdapter.queryNoReturn('DELETE FROM VaccinationTest');
  }

  @override
  Future<void> insertVaccinationTest(
      VaccinationTestEntity vaccinationTestEntity) async {
    await _vaccinationTestEntityInsertionAdapter.insert(
        vaccinationTestEntity, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertVaccinationTestList(
      List<VaccinationTestEntity> vaccinationTestEntityList) async {
    await _vaccinationTestEntityInsertionAdapter.insertList(
        vaccinationTestEntityList, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateVaccinationTest(
      VaccinationTestEntity vaccinationTestEntity) async {
    await _vaccinationTestEntityUpdateAdapter.update(
        vaccinationTestEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteVaccinationTest(
      VaccinationTestEntity vaccinationTestEntity) async {
    await _vaccinationTestEntityDeletionAdapter.delete(vaccinationTestEntity);
  }
}

class _$TravelHistoryDao extends TravelHistoryDao {
  _$TravelHistoryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _travelHistoryEntityInsertionAdapter = InsertionAdapter(
            database,
            'TravelHistory',
            (TravelHistoryEntity item) => <String, Object?>{
                  'RowID': item.RowID,
                  'TravelHistoryID': item.TravelHistoryID,
                  'DepartureDate':
                      _dateTimeConverter.encode(item.DepartureDate),
                  'ReturnDate': _dateTimeConverter.encode(item.ReturnDate),
                  'TravelCity': item.TravelCity,
                  'TravelUid': item.TravelUid,
                  'IsSynced': item.IsSynced ? 1 : 0,
                  'DocId': item.DocId,
                  'IsActive': item.IsActive ? 1 : 0
                }),
        _travelHistoryEntityUpdateAdapter = UpdateAdapter(
            database,
            'TravelHistory',
            ['RowID'],
            (TravelHistoryEntity item) => <String, Object?>{
                  'RowID': item.RowID,
                  'TravelHistoryID': item.TravelHistoryID,
                  'DepartureDate':
                      _dateTimeConverter.encode(item.DepartureDate),
                  'ReturnDate': _dateTimeConverter.encode(item.ReturnDate),
                  'TravelCity': item.TravelCity,
                  'TravelUid': item.TravelUid,
                  'IsSynced': item.IsSynced ? 1 : 0,
                  'DocId': item.DocId,
                  'IsActive': item.IsActive ? 1 : 0
                }),
        _travelHistoryEntityDeletionAdapter = DeletionAdapter(
            database,
            'TravelHistory',
            ['RowID'],
            (TravelHistoryEntity item) => <String, Object?>{
                  'RowID': item.RowID,
                  'TravelHistoryID': item.TravelHistoryID,
                  'DepartureDate':
                      _dateTimeConverter.encode(item.DepartureDate),
                  'ReturnDate': _dateTimeConverter.encode(item.ReturnDate),
                  'TravelCity': item.TravelCity,
                  'TravelUid': item.TravelUid,
                  'IsSynced': item.IsSynced ? 1 : 0,
                  'DocId': item.DocId,
                  'IsActive': item.IsActive ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TravelHistoryEntity>
      _travelHistoryEntityInsertionAdapter;

  final UpdateAdapter<TravelHistoryEntity> _travelHistoryEntityUpdateAdapter;

  final DeletionAdapter<TravelHistoryEntity>
      _travelHistoryEntityDeletionAdapter;

  @override
  Future<List<TravelHistoryEntity>> findAllTravelHistory() async {
    return _queryAdapter.queryList('SELECT * FROM TravelHistory',
        mapper: (Map<String, Object?> row) => TravelHistoryEntity(
            RowID: row['RowID'] as int?,
            TravelHistoryID: row['TravelHistoryID'] as int?,
            DepartureDate:
                _dateTimeConverter.decode(row['DepartureDate'] as int),
            ReturnDate: _dateTimeConverter.decode(row['ReturnDate'] as int),
            TravelCity: row['TravelCity'] as String,
            TravelUid: row['TravelUid'] as String,
            IsSynced: (row['IsSynced'] as int) != 0,
            DocId: row['DocId'] as String,
            IsActive: (row['IsActive'] as int) != 0));
  }

  @override
  Future<TravelHistoryEntity?> findTravelHistoryById(int id) async {
    return _queryAdapter.query('SELECT * FROM TravelHistory WHERE RowID = ?1',
        mapper: (Map<String, Object?> row) => TravelHistoryEntity(
            RowID: row['RowID'] as int?,
            TravelHistoryID: row['TravelHistoryID'] as int?,
            DepartureDate:
                _dateTimeConverter.decode(row['DepartureDate'] as int),
            ReturnDate: _dateTimeConverter.decode(row['ReturnDate'] as int),
            TravelCity: row['TravelCity'] as String,
            TravelUid: row['TravelUid'] as String,
            IsSynced: (row['IsSynced'] as int) != 0,
            DocId: row['DocId'] as String,
            IsActive: (row['IsActive'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<void> deleteAllTravelHistory() async {
    await _queryAdapter.queryNoReturn('DELETE FROM TravelHistory');
  }

  @override
  Future<void> insertTravelHistory(
      TravelHistoryEntity travelHistoryEntity) async {
    await _travelHistoryEntityInsertionAdapter.insert(
        travelHistoryEntity, OnConflictStrategy.ignore);
  }

  @override
  Future<void> insertTravelHistories(
      List<TravelHistoryEntity> travelHistoryEntity) async {
    await _travelHistoryEntityInsertionAdapter.insertList(
        travelHistoryEntity, OnConflictStrategy.ignore);
  }

  @override
  Future<void> updateTravelHistory(
      TravelHistoryEntity travelHistoryEntity) async {
    await _travelHistoryEntityUpdateAdapter.update(
        travelHistoryEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteTravelHistory(
      TravelHistoryEntity travelHistoryEntity) async {
    await _travelHistoryEntityDeletionAdapter.delete(travelHistoryEntity);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
