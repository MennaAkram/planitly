import 'package:dartz/dartz.dart';
import 'package:planitly/features/subject/domain/entity/subject_entity.dart';
import 'package:planitly/shared/networking/failures.dart';

abstract class SubjectRepository {
  Future<Either<NetworkException, SubjectEntity>> getSubjectData({
    required String subjectId,
  });
}
