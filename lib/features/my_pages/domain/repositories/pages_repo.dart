import 'package:dartz/dartz.dart';
import 'package:planitly/features/my_pages/domain/entity/page_entity.dart';
import 'package:planitly/features/my_pages/domain/entity/pages_info_entity.dart';
import 'package:planitly/shared/networking/failures.dart';

abstract class PagesRepository {
  Future<Either<NetworkException, PagesInfoEntity>> getPages({
    int offset = 0,
  });

  Future<Either<NetworkException, PageEntity>> addPage({
    required String name,
  });
}
