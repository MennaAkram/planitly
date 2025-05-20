import 'package:dartz/dartz.dart';
import 'package:planitly/features/my_pages/domain/entity/pages_info_entity.dart';
import 'package:planitly/shared/networking/failures.dart';

abstract class PagesRepository {
  Future<Either<NetworkException, PagesInfoEntity>> getPages({
    int index = 0,
  });
}
