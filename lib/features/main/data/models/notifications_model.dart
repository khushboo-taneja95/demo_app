import 'package:tres_connect/features/main/domain/entities/notification_entity.dart';

class NotificationModel {
  int? status;
  List<NotificationList>? notificationList;
  String? errorMessage;

  NotificationModel({this.status, this.notificationList, this.errorMessage});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['NotificationList'] != null) {
      notificationList = <NotificationList>[];
      json['NotificationList'].forEach((v) {
        notificationList!.add(NotificationList.fromJson(v));
      });
    }
    if (json['ErrorMessage'] != null) {
      errorMessage = json['ErrorMessage'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (notificationList != null) {
      data['NotificationList'] =
          notificationList!.map((v) => v.toJson()).toList();
    }
    if (errorMessage != null) {
      data['ErrorMessage'] = errorMessage;
    }
    return data;
  }
}

class NotificationList extends NotificationEntity {
  NotificationList(
      {notificationId,
      notificationTime,
      notificationType,
      appTarget,
      notificationTitle,
      notificationMessage,
      targetPlatform,
      notificationImage,
      notificationData})
      : super(
            notificationId: notificationId,
            notificationTime: notificationTime,
            notificationType: notificationType,
            appTarget: appTarget,
            notificationTitle: notificationTitle,
            notificationMessage: notificationMessage,
            targetPlatform: targetPlatform,
            notificationImage: notificationImage,
            notificationData: notificationData);

  NotificationList.fromJson(Map<String, dynamic> json) {
    notificationId = json['NotificationId'];
    notificationTime = json['NotificationTime'];
    notificationType = json['NotificationType'];
    appTarget = json['AppTarget'];
    notificationTitle = json['NotificationTitle'];
    notificationMessage = json['NotificationMessage'];
    targetPlatform = json['TargetPlatform'];
    notificationImage = json['NotificationImage'];
    notificationData = json['NotificationData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['NotificationId'] = notificationId;
    data['NotificationTime'] = notificationTime;
    data['NotificationType'] = notificationType;
    data['AppTarget'] = appTarget;
    data['NotificationTitle'] = notificationTitle;
    data['NotificationMessage'] = notificationMessage;
    data['TargetPlatform'] = targetPlatform;
    data['NotificationImage'] = notificationImage;
    data['NotificationData'] = notificationData;
    return data;
  }

  NotificationList.fromEntity(NotificationEntity entity)
      : super(
            notificationId: entity.notificationId,
            notificationTime: entity.notificationTime,
            notificationType: entity.notificationType,
            appTarget: entity.appTarget,
            notificationTitle: entity.notificationTitle,
            notificationMessage: entity.notificationMessage,
            targetPlatform: entity.targetPlatform,
            notificationImage: entity.notificationImage,
            notificationData: entity.notificationData,
            isSeen: entity.isSeen);
}
