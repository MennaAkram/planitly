import 'package:dartz/dartz.dart';
import 'package:planitly/features/subject/data/remote/subject_dto.dart';
import 'package:planitly/features/subject/domain/entity/subject_entity.dart';
import 'package:planitly/features/subject/domain/repository/subject_repo.dart';
import 'package:planitly/shared/bases/base_repo.dart';
import 'package:planitly/shared/configs/endpoints.dart';
import 'package:planitly/shared/networking/failures.dart';

class SubjectRepositoryImpl extends BaseRepository
    implements SubjectRepository {
  SubjectRepositoryImpl(super.dio);

  @override
  Future<Either<NetworkException, SubjectEntity>> getSubjectData({
    required String subjectId,
  }) {
    return tryToExecute(
      () => dio.get(EndPoints.subject(subjectId)),
      (response) => SubjectDto().fromJson(response).toEntity(),
    );
  }
}
