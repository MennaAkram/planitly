import 'package:dartz/dartz.dart';
import 'package:planitly/features/notifications/domain/entity/notifications_info_entity.dart';
import 'package:planitly/shared/networking/failures.dart';

abstract class NotificationsRepository {
  Future<Either<NetworkException, NotificationsInfoEntity>> getNotifications(
      {int offset = 0});
}
