import 'package:planitly/features/authentication/domain/entity/token_entity.dart';
import 'package:planitly/shared/bases/base_mapper.dart';

class TokenDto extends BaseMapper<TokenDto> {
  String? accessToken;
  String? refreshToken;

  TokenDto({this.accessToken, this.refreshToken});

  @override
  Map<String, dynamic> toJson(TokenDto object) {
    return {
      'accessToken': object.accessToken,
      'refreshToken': object.refreshToken,
    };
  }

  @override
  TokenDto fromJson(Map<String, dynamic> json) {
    return TokenDto(
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );
  }

  TokenEntity toEntity() {
    return TokenEntity(accessToken: accessToken!, refreshToken: refreshToken!);
  }
}