import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../features/authentication/domain/entity/token_entity.dart';

class LocalStorageManager {
  final FlutterSecureStorage storage;

  const LocalStorageManager(this.storage);

  final _accessTokenKey = "access_token";
  final _refreshTokenKey = "refresh_token";

  Future<TokenEntity?> getLoginToken() async {
    final accessToken = await storage.read(key: _accessTokenKey);
    final refreshToken = await storage.read(key: _refreshTokenKey);

    if (accessToken != null && refreshToken != null) {
      return TokenEntity(accessToken: accessToken, refreshToken: refreshToken);
    } else {
      return null;
    }
  }

  Future<void> saveLoginToken(TokenEntity token) {
    return Future.wait([
      storage.write(key: _accessTokenKey, value: token.accessToken),
      storage.write(key: _refreshTokenKey, value: token.refreshToken),
    ]);
  }

  void clearLoginToken() {
    storage.delete(key: _accessTokenKey);
    storage.delete(key: _refreshTokenKey);
  }
}
