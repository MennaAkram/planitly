import 'package:dartz/dartz.dart';
import 'package:planitly/features/authentication/domain/entity/token_entity.dart';
import 'package:planitly/shared/networking/failures.dart';

import '../entity/fcm_token_entity.dart';

abstract class AuthenticationRepository {
  Future<Either<NetworkException, TokenEntity>> login(
      {required String usernameOremail, required String password});

  Future<Either<NetworkException, bool>> register(
      {required String firstName,
      required String lastName,
      required String phoneNumber,
      required String birthdayDate,
      required String username,
      required String email,
      required String password});

  Future<Either<NetworkException, TokenEntity>> refreshToken(
      String refreshToken);

  Future<Either<NetworkException, bool>> verifyEmail(
      {required String email});
  
  Future<Either<NetworkException, FcmTokenEntity>> sendFcmToken(
      {required String fcmToken});

  void logout();
}
