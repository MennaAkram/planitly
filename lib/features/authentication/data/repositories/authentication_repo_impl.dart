import 'package:dartz/dartz.dart';
import 'package:planitly/features/authentication/data/remote/token_dto.dart';
import 'package:planitly/features/authentication/domain/entity/token_entity.dart';
import 'package:planitly/features/authentication/domain/repositories/authentication_repo.dart';
import 'package:planitly/shared/bases/base_repo.dart';
import 'package:planitly/shared/networking/failures.dart';
import '../../../../../shared/configs/endpoints.dart';
import '../../../../../shared/local_storage_manager.dart';

class AuthenticationRepositoryImpl extends BaseRepository implements AuthenticationRepository {
  final LocalStorageManager _storageManager;

  AuthenticationRepositoryImpl(super.dio, this._storageManager);

  @override
  Future<Either<NetworkException, TokenEntity>> login({
    required String usernameOremail,
    required String password,
  }) async {
    return await tryToExecute(
      () => dio.post(
        EndPoints.login,
        data: {
          "usernameOremail": usernameOremail,
          "password": password,
        },
      ),
      (response) {
        final token = TokenDto().fromJson(response).toEntity();
        _storageManager.saveLoginToken(token);
        return token;
      },
    );
  }

  @override
  Future<Either<NetworkException, bool>> register({
    required String username,
    required String email,
    required String password,
  }) async {
    return await tryToExecute(
      () => dio.post(
        EndPoints.register,
        data: {
          "username": username,
          "email": email,
          "password": password,
        },
      ),
      (response) {
        return true;
      } ,
    );
  }

  @override
  Future<Either<NetworkException, TokenEntity>> refreshToken(String refreshToken) async {

    final result = await tryToExecute<TokenEntity>(
      () => dio.post(EndPoints.refreshToken, data: {
        "refreshToken": refreshToken,
      }),
      (response) => TokenDto().fromJson(response).toEntity(),
    );
    return result.fold(
      (l) => left(l),
      (token) {
        _storageManager.saveLoginToken(token);
        return right(token);
      },
    );
  }

  @override
  Future<Either<NetworkException, bool>> verifyEmail({required String email}) async {
    return await tryToExecute(
      () => dio.post(
        EndPoints.forgotPassword,
        data: {
          "email": email,
        },
      ),
      (response) {
        return true;
      },
    );
  }

  @override
  Future<Either<NetworkException, bool>> resetNewPassword({required String newPassword}) async {
    return await tryToExecute(
      () => dio.post(
        EndPoints.resetPassword,
        data: {
          "newPassword": newPassword,
        },
      ),
      (response) {
        return true;
      },
    );
  }

  @override
  void logout() {
    _storageManager.clearLoginToken();
  }
}
