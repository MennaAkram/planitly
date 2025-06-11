import 'package:dartz/dartz.dart';
import 'package:planitly/features/authentication/data/remote/token_dto.dart';
import 'package:planitly/features/authentication/domain/entity/token_entity.dart';
import 'package:planitly/features/authentication/domain/repositories/authentication_repo.dart';
import 'package:planitly/shared/bases/base_repo.dart';
import 'package:planitly/shared/networking/failures.dart';
import '../../../../../shared/configs/endpoints.dart';
import '../../../../../shared/local_storage_manager.dart';
import '../../domain/entity/fcm_token_entity.dart';
import '../remote/fcm_token_dto.dart';

class AuthenticationRepositoryImpl extends BaseRepository
    implements AuthenticationRepository {
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
        _storageManager
            .saveFinanceId(response['defualt_subjects']["financial_tracker"]);
        return token;
      },
    );
  }

  @override
  Future<Either<NetworkException, bool>> register({
    required String firstName,
    required String lastName,
    required String countryCode,
    required String phoneNumber,
    required String birthdayDate,
    required String username,
    required String email,
    required String password,
  }) async {
    return await tryToExecute(
      () => dio.post(
        EndPoints.register,
        data: {
          "firstName": firstName,
          "lastName": lastName,
          "phoneNumber": {
            "country_code": countryCode,
            "number": phoneNumber,
          },
          "birthday": birthdayDate,
          "username": username,
          "email": email,
          "password": password,
        },
      ),
      (response) {
        return true;
      },
    );
  }

  @override
  Future<Either<NetworkException, TokenEntity>> refreshToken(
      String refreshToken) async {
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
  Future<Either<NetworkException, bool>> verifyEmail(
      {required String email}) async {
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
  Future<Either<NetworkException, FcmTokenEntity>> sendFcmToken(
      {required String fcmToken}) {
    return tryToExecute(
      () => dio.post(
        EndPoints.fcmToken,
        data: {
          "fcm_token": fcmToken,
        },
      ),
      (response) {
        final fcmTokenEntity = FcmTokenDto().fromJson(response).toEntity();
        return fcmTokenEntity;
      },
    );
  }

  @override
  void logout() {
    _storageManager.clearLoginToken();
  }
}
