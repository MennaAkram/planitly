import 'package:dartz/dartz.dart';
import 'package:planitly/features/authentication/domain/entity/token_entity.dart';
import 'package:planitly/shared/networking/failures.dart';

abstract class AuthenticationRepository {
  Future<Either<NetworkException, TokenEntity>> login(
      {required String usernameOremail, required String password});

  Future<Either<NetworkException, bool>> register(
      {required String username,
      required String email,
      required String password});

  Future<Either<NetworkException, TokenEntity>> refreshToken(
      String accesToken, String refreshToken);

  void logout();
}
