import 'package:floor/floor.dart';

@Entity(tableName: "NotificationMessageTable", indices: [
  Index(value: ['NotificationId'], unique: true)
])
class NotificationEntity {
  @PrimaryKey()
  @ColumnInfo(name: "NotificationId")
  String? notificationId;
  @ColumnInfo(name: "NotificationTitle")
  String? notificationTitle;
  @ColumnInfo(name: "NotificationMessage")
  String? notificationMessage;
  @ColumnInfo(name: "NotificationTime")
  String? notificationTime;
  @ColumnInfo(name: "NotificationType")
  String? notificationType;
  @ColumnInfo(name: "NotificationImage")
  String? notificationImage;
  @ColumnInfo(name: "NotificationTargetPage")
  String? appTarget;
  @ColumnInfo(name: "TargetPlatform")
  String? targetPlatform;
  @ColumnInfo(name: "NotificationData")
  String? notificationData;
  @ColumnInfo(name: "IsSeen")
  bool isSeen = false;

  NotificationEntity(
      {this.notificationId,
      this.notificationTime,
      this.notificationType,
      this.appTarget,
      this.notificationTitle,
      this.notificationMessage,
      this.targetPlatform,
      this.notificationImage,
      this.notificationData,
      this.isSeen = false});
}
