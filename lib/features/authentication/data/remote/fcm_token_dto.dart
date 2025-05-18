import 'package:planitly/shared/bases/base_mapper.dart';

import '../../domain/entity/fcm_token_entity.dart';

class FcmTokenDto extends BaseMapper<FcmTokenDto>{
  String? fcm_token;

  FcmTokenDto({
    this.fcm_token,
  });

  @override
  Map<String, dynamic> toJson(FcmTokenDto object) {
    return {
      'fcm_token': object.fcm_token,
    };
  }

  @override
  FcmTokenDto fromJson(Map<String, dynamic> json) {
    return FcmTokenDto(
      fcm_token: json['fcm_token'] as String?,
    );
  }

  FcmTokenEntity toEntity() {
    return FcmTokenEntity(
      fcm_token: fcm_token ?? ''
    );
  }

}