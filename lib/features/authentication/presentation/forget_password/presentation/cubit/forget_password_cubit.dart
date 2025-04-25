import 'package:planitly/features/authentication/domain/repositories/authentication_repo.dart';
import 'package:planitly/shared/bases/base_cubit.dart';
import 'package:planitly/shared/bases/base_state.dart';

class ForgetPasswordCubit extends BaseCubit {
  final AuthenticationRepository _authRepo;

  ForgetPasswordCubit(this._authRepo) : super(const InitState());

  verifyEmail({required String email}) async {
    emit(const LoadingState());

    final result = await _authRepo.verifyEmail(email: email);

    return result.fold(
      (exception) {
        handleException(exception);
      },
      (data) {
        emit(const DoneState());
      },
    );
  }


}