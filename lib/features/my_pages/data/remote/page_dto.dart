import 'package:planitly/features/my_pages/domain/entity/page_entity.dart';
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
      '_id': object.id,
      'name': object.name,
    };
  }

  @override
  PageDto fromJson(Map<String, dynamic> json) {
    return PageDto(
      id: json['_id'] as String?,
      name: json['name'] as String?,
    );
  }

  PageEntity toEntity() {
    return PageEntity(
      id: id ?? '',
      name: name ?? '',
    );
  }
}
