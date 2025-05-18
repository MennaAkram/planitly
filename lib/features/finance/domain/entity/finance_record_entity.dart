class FinanceRecordEntity {
  final String name;
  final double amount;
  final DateTime date;
  final DateTime createdAt;

  FinanceRecordEntity({
    required this.name,
    required this.amount,
    required this.date,
    required this.createdAt,
  });
}
