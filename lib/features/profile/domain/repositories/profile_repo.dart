import 'package:dartz/dartz.dart';
import 'package:planitly/features/profile/domain/entity/Profile_data_entity.dart';
import 'package:planitly/shared/networking/failures.dart';

abstract class ProfileRepository {
  Future<Either<NetworkException, ProfileDataEntity>> getProfileData();
}
