import 'package:flutter/material.dart';
import 'package:tres_connect/core/utility/DateUtility.dart';
import 'package:tres_connect/features/main/domain/entities/notification_entity.dart';
import 'package:tres_connect/gen/assets.gen.dart';

class NotificationRowWidget extends StatelessWidget {
  final NotificationEntity entity;
  final bool showArrow;

  const NotificationRowWidget(
      {Key? key, required this.entity, this.showArrow = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double opacity = 1;
    if (entity.isSeen) {
      opacity = 0.7;
    }
    if (!showArrow) {
      opacity = 1;
    }
    return Opacity(
      opacity: opacity,
      child: Container(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              width: 50,
              margin: const EdgeInsets.only(top: 10),
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Assets.images.icLauncherRound.image(
                  height: 50,
                  width: 50,
                ),
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${entity.notificationTitle}",
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Builder(builder: (ctx) {
                            if (entity.notificationImage == null ||
                                entity.notificationImage!.isEmpty) {
                              return Container();
                            }
                            return Image.network(
                              entity.notificationImage!,
                              height: 130,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          }),
                          Text(
                            "${entity.notificationMessage}",
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.normal),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            DateUtility.formatDateTime(
                                dateTime: DateUtility.parseDateTime(
                                        dateTimeString:
                                            entity.notificationTime ?? "",
                                        format: "yyyy-MM-dd'T'HH:mm:ss")
                                    .toLocal(),
                                outputFormat: "dd MMM yyyy hh:mm a"),
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                  showArrow ? const Icon(Icons.chevron_right) : Container(),
                ],
              ),
            ),
            //Align vertically center
          ],
        ),
      ),
    );
  }
}
