import 'package:planitly/features/home_screen/domain/entity/subject_entity.dart';
import 'component_entity.dart';

class FinanceEntity {
  final SubjectEntity subject;
  final List<ComponentsEntity> components;
  final List<String> widgets;

  FinanceEntity({
    required this.subject,
    required this.components,
    required this.widgets,
  });

}