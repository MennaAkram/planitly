import 'package:planitly/features/subject/domain/entity/property_entity.dart';
import 'package:planitly/features/subject/domain/entity/subject_entity.dart';
import 'package:planitly/features/subject/domain/repository/subject_repo.dart';
import 'package:planitly/shared/bases/base_cubit.dart';
import 'package:planitly/shared/bases/base_state.dart';
import 'package:planitly/shared/networking/failures.dart';

class SubjectCubit extends BaseCubit {
  final SubjectRepository _subjectRepository;

  SubjectCubit(this._subjectRepository) : super(const InitState());

  String id = '';
  List<PropertyEntity> selectedProperties = [];

  Future<void> getSubjectData({required String subjectId}) async {
    emit(const LoadingState());

    final result =
        await _subjectRepository.getSubjectData(subjectId: subjectId);

    result.fold(
      (NetworkException exception) {
        handleException(exception);
      },
      (SubjectEntity subject) {
        id = subject.id;
        selectedProperties = subject.properties;
        emit(const DoneState());
      },
    );
  }
}
