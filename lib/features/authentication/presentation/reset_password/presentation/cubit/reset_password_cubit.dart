import 'package:planitly/features/authentication/domain/repositories/authentication_repo.dart';
import 'package:planitly/shared/bases/base_cubit.dart';
import 'package:planitly/shared/bases/base_state.dart';
import 'package:planitly/shared/networking/failures.dart';

class ResetPasswordCubit extends BaseCubit {
  final AuthenticationRepository _authRepo;

  ResetPasswordCubit(this._authRepo) : super(const InitState());

  resetPassword({
    required String newPassword,
  }) async {
    emit(const LoadingState());

    final result = await _authRepo.resetNewPassword(
      newPassword: newPassword,
    );

    result.fold(
      (NetworkException exception) => handleException(exception),
      (success) => emit(const DoneState()),
    );
  }
}
