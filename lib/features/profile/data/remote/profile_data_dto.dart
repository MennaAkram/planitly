import 'package:planitly/features/profile/domain/entity/Profile_data_entity.dart';
import 'package:planitly/shared/bases/base_mapper.dart';

class ProfileDataDto extends BaseMapper<ProfileDataDto> {
  String? profileImage;
  String? firstName;
  String? lastName;
  String? username;
  String? countryCode;
  String? phoneNumber;
  String? email;
  DateTime? birthdayDate;

  ProfileDataDto({
    this.profileImage,
    this.firstName,
    this.lastName,
    this.username,
    this.countryCode,
    this.phoneNumber,
    this.email,
    this.birthdayDate,
  });

  @override
  ProfileDataDto fromJson(Map<String, dynamic> json) {
    return ProfileDataDto(
      profileImage: json['profile_image'] as String?,
      firstName: json['firstname'] as String?,
      lastName: json['lastname'] as String?,
      username: json['username'] as String?,
      countryCode: json['phone_number']['country_code'] as String?,
      phoneNumber: json['phone_number']['number'] as String?,
      email: json['email'] as String?,
      birthdayDate:
          json['birthday'] != null ? DateTime.parse(json['birthday']) : null,
    );
  }

  @override
  Map<String, dynamic> toJson(ProfileDataDto object) {
    return {
      'profile_image': object.profileImage,
      'firstname': object.firstName,
      'lastname': object.lastName,
      'username': object.username,
      'country_code': object.countryCode,
      'phone_number': object.phoneNumber,
      'email': object.email,
      'birthday': object.birthdayDate?.toIso8601String(),
    };
  }

  ProfileDataEntity toEntity() {
    return ProfileDataEntity(
      profileImage: profileImage ?? '',
      firstName: firstName ?? '',
      lastName: lastName ?? '',
      username: username ?? '',
      countryCode: countryCode ?? '',
      phoneNumber: phoneNumber ?? '',
      email: email ?? '',
      burthdayDate: birthdayDate ?? DateTime.now(),
    );
  }
}
