
import 'package:dartz/dartz.dart';
import 'package:planitly/features/authentication/domain/entity/token_entity.dart';
import 'package:planitly/features/authentication/domain/repositories/authentication_repo.dart';
import 'package:planitly/shared/bases/base_cubit.dart';
import 'package:planitly/shared/bases/base_state.dart';
import 'package:planitly/shared/networking/failures.dart';

class LoginCubit extends BaseCubit{
  final AuthenticationRepository _authRepo;

  LoginCubit(this._authRepo) : super(const InitState());

  login({ required String usernameOremail, required String password}) async {
    emit(const LoadingState());

    Either<NetworkException, TokenEntity> result = await _authRepo.login(
      usernameOremail: usernameOremail,
      password: password,
    );

    return result.fold(
      (NetworkException exception) {
        handleException(exception);
      },
      (data) {
        emit(const DoneState());
      },
    );
  }
  

}