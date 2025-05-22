import 'package:planitly/features/my_pages/domain/entity/page_entity.dart';

class PagesInfoEntity {
  final int total;
  final List<PageEntity> pages;

  const PagesInfoEntity({
    required this.total,
    required this.pages,
  });
}
