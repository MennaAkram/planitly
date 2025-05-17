import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:planitly/features/notifications/domain/entity/notification_entity.dart';
import 'package:planitly/features/notifications/domain/entity/notifications_info_entity.dart';

import '../features/authentication/domain/entity/token_entity.dart';

class LocalStorageManager {
  final FlutterSecureStorage storage;

  const LocalStorageManager(this.storage);

  final _accessTokenKey = "access_token";
  final _refreshTokenKey = "refresh_token";
  final _notificationsInfoKey = "notifications_info";
  final _financeIdKey = "finance_id";

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

  Future<void> saveNotificationsInfo(
      NotificationsInfoEntity notificationsInfo) {
    final jsonMap = {
      'total': notificationsInfo.total,
      'notifications': notificationsInfo.notifications
          .map((notify) => {
                'id': notify.id,
                'message': notify.message,
                'created_at': notify.created_at
              })
          .toList()
    };
    return storage.write(
      key: _notificationsInfoKey,
      value: jsonEncode(jsonMap),
    );
  }

    Future<NotificationsInfoEntity?> getNotificationsInfo() async {
    final raw = await storage.read(key: _notificationsInfoKey);
    if (raw == null) return null;

    final Map<String, dynamic> jsonMap = jsonDecode(raw);
    final List<dynamic> listJson = jsonMap['notifications'];
    final items = listJson
        .map((m) => NotificationEntity(
              id: m['id'],
              message: m['message'],
              created_at: m['created_at'],
            ))
        .toList();

    return NotificationsInfoEntity(
      total: jsonMap['total'] as int,
      notifications: items,
    );
  }

  void clearNotificationsInfo() {
    storage.delete(key: _notificationsInfoKey);
  }

  Future<void> saveFinanceId(String financeId) {
    return Future.wait([
      storage.write(key: _financeIdKey, value: financeId),
    ]);
  }

  Future<String?> getFinanceId() async {
    return await storage.read(key: _financeIdKey);
  }

  void clearFinanceId() {
    storage.delete(key: _financeIdKey);
  }

  void clearAll() {
    storage.deleteAll();
  }
}
