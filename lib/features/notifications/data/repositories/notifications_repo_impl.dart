import 'package:dartz/dartz.dart';
import 'package:planitly/features/notifications/data/remote/notifications_info_dto.dart';
import 'package:planitly/features/notifications/domain/entity/notifications_info_entity.dart';
import 'package:planitly/shared/bases/base_repo.dart';
import 'package:planitly/shared/configs/endpoints.dart';
import 'package:planitly/shared/local_storage_manager.dart';
import 'package:planitly/shared/networking/failures.dart';
import 'package:planitly/features/notifications/domain/repositories/notifications_repo.dart';

class NotificationsRepositoryImpl extends BaseRepository
    implements NotificationsRepository {
  final LocalStorageManager _storageManager;

  NotificationsRepositoryImpl(super.dio, this._storageManager);

  @override
  Future<Either<NetworkException, NotificationsInfoEntity>> getNotifications(
      {int offset = 0}) async {
    final NotificationsInfoEntity? cachedNotificationsInfo =
        await _storageManager.getNotificationsInfo();

    if (offset == 0) {
      final cached = await _storageManager.getNotificationsInfo();
      if (cached != null && cached.notifications.isNotEmpty) {
        return right(NotificationsInfoEntity(
          total: cached.total,
          notifications: cached.notifications,
        ));
      }
    }

    return await tryToExecute(
      () => dio.get(EndPoints.notifications, queryParameters: {
        'offset': offset,
      }),
      (data) {
        final NotificationsInfoDto notificationsInfo =
            NotificationsInfoDto().fromJson(data);
        final NotificationsInfoEntity notificationsInfoEntity =
            NotificationsInfoEntity(
          total: notificationsInfo.total ?? 0,
          notifications: notificationsInfo.notifications
                  ?.map((e) => e.toEntity())
                  .toList() ??
              [],
        );
        if (offset == 0) {
          _storageManager.saveNotificationsInfo(notificationsInfoEntity);
        } else {
          _storageManager.clearNotificationsInfo();
          final existing = cachedNotificationsInfo?.notifications ?? [];
          final merged = [
            ...existing,
            ...notificationsInfoEntity.notifications
          ];
          _storageManager.saveNotificationsInfo(NotificationsInfoEntity(
            total: notificationsInfoEntity.total,
            notifications: merged,
          ));
        }
        return notificationsInfoEntity;
      },
    );
  }
}
