import 'dart:io';

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
    phoneNumber: '',
    burthdayDate: DateTime.now(),
  );

  File? profileImage;

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
}
