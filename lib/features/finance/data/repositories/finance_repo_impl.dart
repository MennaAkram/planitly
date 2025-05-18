import 'package:dartz/dartz.dart';
import 'package:planitly/features/finance/data/remote/finance_info_dto.dart';
import 'package:planitly/features/finance/domain/entity/finance_info_entity.dart';
import 'package:planitly/features/finance/domain/repositories/finance_repo.dart';
import 'package:planitly/shared/bases/base_repo.dart';
import 'package:planitly/shared/configs/endpoints.dart';
import 'package:planitly/shared/local_storage_manager.dart';
import 'package:planitly/shared/networking/failures.dart';

class FinanceRepositoryImpl extends BaseRepository
    implements FinanceRepository {
  final LocalStorageManager _storageManager;

  FinanceRepositoryImpl(super.dio, this._storageManager);

  @override
  Future<Either<NetworkException, FinanceInfoEntity>> getFinance() async {
    return await tryToExecute<FinanceInfoEntity>(
      () async {
        String? financeId = await _storageManager.getFinanceId();
        return dio.get(EndPoints.subjects(financeId ?? ''));
      },
      (response) {
        return FinanceInfoDto().fromJson(response).toEntity();
      },
    );
  }

  @override
  Future<Either<NetworkException, bool>> addFinanceRecord({
    required String financeTableId,
    required String name,
    required double amount,
    required DateTime date,
  }) async {
    return await tryToExecute(
      () => dio.post(EndPoints.data_transfer, data: {
        'target_component': financeTableId,
        'data_value': {
          'item': {
            'key': name,
            'value': '$amount ; ${date.toIso8601String()}',
          },
        },
        'operation': 'append',
      }),
      (response) => true,
    );
  }
}
