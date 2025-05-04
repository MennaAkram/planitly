import 'package:dartz/dartz.dart';
import 'package:planitly/features/finance/domain/entity/finance_info_entity.dart';
import 'package:planitly/shared/networking/failures.dart';

abstract class FinanceRepo {

  Future<Either<NetworkException, FinanceInfoEntity>> getFinance();
}