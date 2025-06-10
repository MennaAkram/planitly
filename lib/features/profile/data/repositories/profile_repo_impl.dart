import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:planitly/features/profile/data/remote/profile_data_dto.dart';
import 'package:planitly/features/profile/domain/entity/Profile_data_entity.dart';
import 'package:planitly/features/profile/domain/repositories/profile_repo.dart';
import 'package:planitly/shared/bases/base_repo.dart';
import 'package:planitly/shared/configs/endpoints.dart';
import 'package:planitly/shared/networking/failures.dart';

class ProfileRepositoryImpl extends BaseRepository
    implements ProfileRepository {
  ProfileRepositoryImpl(super.dio);

  @override
  Future<Either<NetworkException, ProfileDataEntity>> getProfileData() async {
    return await tryToExecute(
      () => dio.get(EndPoints.profile),
      (response) => ProfileDataDto().fromJson(response).toEntity(),
    );
  }

  @override
  Future<Either<NetworkException, String>> uploadProfileImage(
      {required File image}) async {
    final fileName = image.path.split('/').last;
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        image.path,
        filename: fileName,
      ),
    });
    return await tryToExecute(
      () => dio.post(EndPoints.uploadProfileImage,
          data: formData, options: Options(contentType: 'multipart/form-data')),
      (response) => response['image_url'] as String,
    );
  }
}
