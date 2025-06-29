import 'connection_entity.dart';

class ConnectionsEntity {
  final int totalToday;
  final List<ConnectionEntity> connections;

  ConnectionsEntity({
    required this.totalToday,
    required this.connections,
  });
}