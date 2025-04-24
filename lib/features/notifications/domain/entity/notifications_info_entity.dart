import 'package:planitly/features/notifications/domain/entity/notification_entity.dart';

class NotificationsInfoEntity {
  final int total;
  final List<NotificationEntity> notifications;

  NotificationsInfoEntity({
    required this.total,
    required this.notifications,
  });
}