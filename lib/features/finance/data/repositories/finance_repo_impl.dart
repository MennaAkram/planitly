
import 'package:dartz/dartz.dart';
import 'package:planitly/features/finance/data/remote/finance_info_dto.dart';
import 'package:planitly/features/finance/domain/entity/finance_info_entity.dart';
import 'package:planitly/features/finance/domain/repositories/finance_repo.dart';
import 'package:planitly/shared/bases/base_repo.dart';
import 'package:planitly/shared/configs/endpoints.dart';
import 'package:planitly/shared/local_storage_manager.dart';
import 'package:planitly/shared/networking/failures.dart';

class FinanceRepositoryImpl extends BaseRepository implements FinanceRepository{
  final LocalStorageManager _storageManager;

  FinanceRepositoryImpl(super.dio, this._storageManager);

  @override
  Future<Either<NetworkException, FinanceInfoEntity>> getFinance() async {
    return await tryToExecute<FinanceInfoEntity>(
      () => dio.get(EndPoints.finance),
      (response) {
        return FinanceInfoDto().fromJson(response).toEntity();
      },
    );
  }

}