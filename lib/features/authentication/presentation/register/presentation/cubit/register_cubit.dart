import 'package:dartz/dartz.dart';
import 'package:planitly/features/authentication/domain/repositories/authentication_repo.dart';
import 'package:planitly/shared/bases/base_cubit.dart';
import 'package:planitly/shared/bases/base_state.dart';
import 'package:planitly/shared/networking/failures.dart';

class RegisterCubit extends BaseCubit {
  final AuthenticationRepository _authRepo;

  RegisterCubit(this._authRepo) : super(const InitState());

  register(
      {required String username,
      required String email,
      required String password}) async {
    emit(const LoadingState());

    Either<NetworkException, void> result = await _authRepo.register(
      username: username,
      email: email,
      password: password,
    );

    return result.fold(
      (NetworkException excepyion) {
        handleException(excepyion);
      },
      (data) {
        emit(const DoneState());
      },
    );
  }
}
