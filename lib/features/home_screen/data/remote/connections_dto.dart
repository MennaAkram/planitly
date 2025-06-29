import 'package:planitly/features/home_screen/domain/entity/connections_entity.dart';
import 'package:planitly/shared/bases/base_mapper.dart';

import 'connection_dto.dart';

class ConnectionsDto extends BaseMapper<ConnectionsDto> {
  int? totalToday;
  List<ConnectionDto>? connections;

  ConnectionsDto({
     this.totalToday,
     this.connections,
  });

  @override
  ConnectionsDto fromJson(Map<String, dynamic> json) {
    return ConnectionsDto(
      totalToday: json['total_today'] as int?,
      connections: (json['connections'] as List<dynamic>?)
          ?.map((e) => ConnectionDto().fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson(ConnectionsDto object) {
    return {
      'total_today': object.totalToday,
      'connections': object.connections?.map((e) => e.toJson(e)).toList(),
    };
  }

  ConnectionsEntity toEntity() {
    return ConnectionsEntity(
      totalToday: totalToday ?? 0,
      connections: connections?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}