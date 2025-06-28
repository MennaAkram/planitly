class ConnectionEntity {
  final String id;
  final String connectionType;
  final DateTime endDate;
  final DateTime startDate;
  final String sourceSubject;
  final String targetSubject;
  final bool done;

  ConnectionEntity({
    required this.id,
    required this.connectionType,
    required this.endDate,
    required this.startDate,
    required this.sourceSubject,
    required this.targetSubject,
    required this.done,
  });
}