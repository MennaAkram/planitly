import 'package:planitly/features/home_screen/domain/entity/template_entity.dart';
import 'custom_template_entity.dart';

class TemplatesEntity {
  final List<TemplateEntity> predefined;
  final List<CustomTemplateEntity> custom;

  TemplatesEntity({
    required this.predefined,
    required this.custom,
  });
}