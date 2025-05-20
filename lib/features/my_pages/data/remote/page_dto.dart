import 'package:planitly/shared/bases/base_mapper.dart';

class PageDto extends BaseMapper<PageDto> {
  String? id;
  String? name;

  PageDto({
    this.id,
    this.name,
  });

  @override
  Map<String, dynamic> toJson(PageDto object) {
    return {
      'id': object.id,
      'name': object.name,
    };
  }

  @override
  PageDto fromJson(Map<String, dynamic> json) {
    return PageDto(
      id: json['id'] as String?,
      name: json['name'] as String?,
    );
  }
}
