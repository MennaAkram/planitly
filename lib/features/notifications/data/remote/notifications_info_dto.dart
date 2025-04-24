import 'package:planitly/features/notifications/data/remote/notification_dto.dart';
import 'package:planitly/shared/bases/base_mapper.dart';

class NotificationsInfoDto extends BaseMapper<NotificationsInfoDto> {
  int? total;
  List<NotificationsDto>? notifications;

  NotificationsInfoDto({
    this.total,
    this.notifications,
  });

  @override
  Map<String, dynamic> toJson(NotificationsInfoDto object) {
    return {
      'total': object.total ?? 0,
      'notifications': object.notifications?.map((e) => e.toJson(e)).toList() ?? [],
    };
  }

  @override
  NotificationsInfoDto fromJson(Map<String, dynamic> json) {
    return NotificationsInfoDto(
      total: json['total'] as int?,
      notifications: NotificationsDto().toDto(json['notifications']),
    );
  }
} 