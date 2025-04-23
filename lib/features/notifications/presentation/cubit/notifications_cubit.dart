import 'package:dartz/dartz.dart';
import 'package:planitly/features/notifications/domain/entity/notification_entity.dart';
import 'package:planitly/features/notifications/domain/entity/notifications_info_entity.dart';
import 'package:planitly/features/notifications/domain/repositories/notifications_repo.dart';
import 'package:planitly/shared/bases/base_cubit.dart';
import 'package:planitly/shared/bases/base_state.dart';
import 'package:planitly/shared/networking/failures.dart';

class NotificationsCubit extends BaseCubit {
  final NotificationsRepository _notificationsRepo;

  NotificationsCubit(this._notificationsRepo) : super(const InitState());

  List<NotificationEntity> notifications = [];
  int _offset = 0;
  bool hasMore = true;
  bool isLoading = false;

  void getNotifications({bool initial = false}) async {
    if (isLoading || !hasMore) return;

    isLoading = true;

    if (initial) {
      emit(LoadingState());
      _offset = 0;
      notifications.clear();
    }

    Either<NetworkException, NotificationsInfoEntity> result =
        await _notificationsRepo.getNotifications(offset: _offset);

    result.fold(
      (NetworkException exception) {
        handleException(exception);
      },
      (NotificationsInfoEntity data) {
         notifications.addAll(data.notifications);
      _offset += data.notifications.length;
      hasMore = _offset < data.total;
      emit(DoneState());
      },
    );

    isLoading = false;
  }
}
