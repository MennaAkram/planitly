import 'package:planitly/features/home_screen/domain/entity/connection_entity.dart';
import 'package:planitly/shared/bases/base_mapper.dart';

class ConnectionDto extends BaseMapper<ConnectionDto> {
  String? id;
  String? connectionType;
  DateTime? endDate;
  DateTime? startDate;
  String? sourceSubject;
  String? targetSubject;
  bool? done;

  ConnectionDto({
    this.id,
    this.connectionType,
    this.endDate,
    this.startDate,
    this.sourceSubject,
    this.targetSubject,
    this.done,
  });

  @override
  ConnectionDto fromJson(Map<String, dynamic> json) {
    return ConnectionDto(
      id: json['id'] as String?,
      connectionType: json['connection_type'] as String?,
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'] as String)
          : null,
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'] as String)
          : null,
      sourceSubject: json['source_subject'] as String?,
      targetSubject: json['target_subject'] as String?,
      done: json['done'] as bool?,
    );
  }

  @override
  Map<String, dynamic> toJson(ConnectionDto object) {
    return {
      'id': object.id,
      'connection_type': object.connectionType,
      'end_date': object.endDate?.toIso8601String(),
      'start_date': object.startDate?.toIso8601String(),
      'source_subject': object.sourceSubject,
      'target_subject': object.targetSubject,
      'done': object.done,
    };
  }

  ConnectionEntity toEntity() {
    return ConnectionEntity(
      id: id ?? '',
      connectionType: connectionType ?? '',
      endDate: endDate ?? DateTime.now(),
      startDate: startDate ?? DateTime.now(),
      sourceSubject: sourceSubject ?? '',
      targetSubject: targetSubject ?? '',
      done: done ?? false,
    );
  }

}