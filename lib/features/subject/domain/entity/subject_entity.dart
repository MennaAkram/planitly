import 'package:planitly/features/subject/domain/entity/property_entity.dart';

class SubjectEntity {
  final String id;
  final String name;
  final String templete;
  final String category;
  final List<PropertyEntity> properties;

  const SubjectEntity({
    required this.id,
    required this.name,
    required this.templete,
    required this.category,
    required this.properties,
  });
}