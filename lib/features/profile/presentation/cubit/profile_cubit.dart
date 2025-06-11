import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:planitly/features/profile/domain/entity/Profile_data_entity.dart';
import 'package:planitly/features/profile/domain/repositories/profile_repo.dart';
import 'package:planitly/shared/bases/base_cubit.dart';
import 'package:planitly/shared/bases/base_state.dart';
import 'package:planitly/shared/networking/failures.dart';

class ProfileCubit extends BaseCubit {
  final ProfileRepository _profileRepo;

  ProfileCubit(this._profileRepo) : super(const InitState());

  ProfileDataEntity profileDataEntity = ProfileDataEntity(
    profileImage: '',
    firstName: '',
    lastName: '',
    username: '',
    email: '',
    countryCode: '+20',
    phoneNumber: '',
    burthdayDate: DateTime.now(),
  );

  File? profileImage;
  bool isImageUploading = false;
  bool iseditingProfile = false;

  Future<void> getProfileData() async {
    emit(const LoadingState());
    final result = await _profileRepo.getProfileData();
    result.fold((NetworkException exception) {
      handleException(exception);
    }, (data) {
      profileDataEntity = data;
      emit(const DoneState());
    });
  }

  Future<void> uploadProfileImage() async {
    if (isImageUploading) return;

    isImageUploading = true;

    emit(const LoadingState());

    Either<NetworkException, String> result =
        await _profileRepo.uploadProfileImage(image: profileImage!);

    result.fold((NetworkException exception) {
      profileImage = null;
      handleException(exception);
    }, (imageUrl) {
      profileDataEntity.profileImage = imageUrl;
      emit(const DoneState());
    });

    isImageUploading = false;
  }

  Future<void> editProfileData({
    required String firstName,
    required String lastName,
    required String countryCode,
    required String phoneNumber,
    required DateTime birthdayDate,
  }) async {
    if (iseditingProfile) return;
    iseditingProfile = true;
    emit(const LoadingState());

    Either<NetworkException, bool> result = await _profileRepo.editProfileData(
      firstName: firstName,
      lastName: lastName,
      countryCode: countryCode,
      phoneNumber: phoneNumber,
      birthdayDate: birthdayDate,
    );

    result.fold((NetworkException exception) {
      handleException(exception);
    }, (success) {
      profileDataEntity.firstName = firstName;
      profileDataEntity.lastName = lastName;
      profileDataEntity.countryCode = countryCode;
      profileDataEntity.phoneNumber = phoneNumber;
      profileDataEntity.burthdayDate = birthdayDate;
      emit(const DoneState());
    });

    iseditingProfile = false;
  }
}
