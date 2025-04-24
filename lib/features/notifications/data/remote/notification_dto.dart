import 'package:intl/intl.dart';
import 'package:planitly/features/notifications/domain/entity/notification_entity.dart';
import 'package:planitly/shared/bases/base_mapper.dart';

class NotificationsDto extends BaseMapper<NotificationsDto>{
  String? id;
  String? message;
  String? created_at;

  NotificationsDto({
    this.id,
    this.message,
    this.created_at,
  });

  @override
  Map<String, dynamic> toJson(NotificationsDto object) {
    return {
      'id': object.id,
      'message': object.message,
      'created_at': object.created_at,
    };
  }

  @override
  NotificationsDto fromJson(Map<String, dynamic> json) {
    return NotificationsDto(
      id: json['id'] as String?,
      message: json['message'] as String?,
      created_at: getCreatedAt(json['created_at']) as String?,
    );
  }

  List<NotificationsDto> toDto(List<dynamic> data) {
    return data.map((e) => NotificationsDto().fromJson(e)).toList();
  }

  List<NotificationEntity> toEntityList(List<dynamic> data) {
    return NotificationsDto().toDto(data).map((dto) => dto.toEntity()).toList();
  }

  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id ?? '',
      message: message ?? '',
      created_at: created_at ?? '',
    );
  }

  String getCreatedAt(String? created_at) {
    return created_at == null
        ? ''
        : DateFormat('MMM d, yyyy - hh:mm a').format(
            DateTime.parse(created_at).toLocal());
  }
}