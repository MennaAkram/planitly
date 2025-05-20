import 'package:planitly/features/my_pages/data/remote/page_dto.dart';
import 'package:planitly/features/my_pages/domain/entity/pages_info_entity.dart';
import 'package:planitly/shared/bases/base_mapper.dart';

class PagesInfoDto extends BaseMapper<PagesInfoDto> {
  int? total;
  List<PageDto>? pages;

  PagesInfoDto({
    this.total,
    this.pages,
  });

  @override
  Map<String, dynamic> toJson(PagesInfoDto object) {
    return {
      'total': object.total,
      'pages': object.pages?.map((page) => page.toJson(page)).toList(),
    };
  }

  @override
  PagesInfoDto fromJson(Map<String, dynamic> json) {
    return PagesInfoDto(
      total: json['total'] as int?,
      pages: (json['subjects'] as List)
          .map((page) => PageDto().fromJson(page))
          .toList(),
    );
  }

  PagesInfoEntity toEntity() {
    return PagesInfoEntity(
      total: total ?? 0,
      pages: pages?.map((page) => page.toEntity()).toList() ?? [],
    );
  }
}
