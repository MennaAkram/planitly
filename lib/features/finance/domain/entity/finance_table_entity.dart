import 'package:planitly/features/finance/domain/entity/finance_record_entity.dart';

class FinanceTableEntity {
  final String id;
  final List<FinanceRecordEntity> records;

  FinanceTableEntity({
    required this.id,
    required this.records,
  });
}
