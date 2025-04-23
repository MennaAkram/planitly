import 'package:planitly/features/authentication/domain/repositories/authentication_repo.dart';
import 'package:planitly/shared/bases/base_cubit.dart';
import 'package:planitly/shared/bases/base_state.dart';

class SplashCubit extends BaseCubit{
  final AuthenticationRepository _authRepo;

  SplashCubit(this._authRepo) : super(const InitState());

  Future<bool> checkUserLoggedIn() async {
    emit(const LoadingState());

    final result = await _authRepo.isUserLoggedIn();

    return result.fold(
      (exception) {
        handleException(exception);
        return false;
      },
      (data) {
        emit(const DoneState());
        return data;
      },
    );
  }
}