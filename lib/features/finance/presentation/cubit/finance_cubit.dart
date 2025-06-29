import 'package:fl_chart/fl_chart.dart';
import 'package:planitly/features/finance/domain/entity/finance_record_entity.dart';
import 'package:planitly/features/finance/domain/repositories/finance_repo.dart';
import 'package:planitly/shared/bases/base_cubit.dart';
import 'package:planitly/shared/bases/base_state.dart';

class FinanceCubit extends BaseCubit {
  final FinanceRepository _financeRepo;

  FinanceCubit(this._financeRepo) : super(const InitState());

  List<FinanceRecordEntity> incomes = [];
  List<FinanceRecordEntity> expenses = [];
  List<(DateTime, DateTime, double, bool)> allRecords = [];

  String incomeTableId = '';
  String expenseTableId = '';

  List<FlSpot> graphData = [const FlSpot(0, 0), const FlSpot(1, 0)];
  double maxY = 10;
  double minY = 0;
  bool isIncreasing = false;

  bool get showIncomeTable => incomes.isNotEmpty;
  bool get showExpenseTable => expenses.isNotEmpty;

  double get totalAmount {
    double total = 0;
    for (var income in incomes) {
      total += income.amount;
    }
    for (var expense in expenses) {
      total -= expense.amount;
    }
    return total;
  }

  getFinance() async {
    emit(const LoadingState());

    final result = await _financeRepo.getFinance();

    return result.fold(
      (exception) {
        handleException(exception);
      },
      (data) {
        incomes = _sortByDate(data.incomeInfo.records);
        expenses = _sortByDate(data.expenseInfo.records);

        incomeTableId = data.incomeInfo.id;
        expenseTableId = data.expenseInfo.id;

        allRecords = [
          ...incomes.map((r) => (r.date, r.createdAt, r.amount, true)),
          ...expenses.map((r) => (r.date, r.createdAt, r.amount, false)),
        ]..sort((a, b) => a.$1.compareTo(b.$1) == 0
            ? a.$2.compareTo(b.$2)
            : a.$1.compareTo(b.$1));

        _initGraph();
        emit(const DoneState());
      },
    );
  }

  addFinanceRecord({
    required bool isIncome,
    required String name,
    required double amount,
    required DateTime date,
  }) async {
    emit(const LoadingState());

    final result = await _financeRepo.addFinanceRecord(
      financeTableId: isIncome ? incomeTableId : expenseTableId,
      name: name,
      amount: amount,
      date: date,
    );

    return result.fold(
      (exception) {
        handleException(exception);
      },
      (data) {
        final newRecord = FinanceRecordEntity(
          name: name,
          amount: amount,
          date: date,
          createdAt: DateTime.now(),
        );

        final mergedIndex = _getMergedIndex(date);

        allRecords
            .insert(mergedIndex, (date, DateTime.now(), amount, isIncome));

        int index = _getIndex(isIncome, date);

        if (isIncome) {
          incomes.insert(index, newRecord);
        } else {
          expenses.insert(index, newRecord);
        }
        _insertGraphPoint(
            index: mergedIndex, isIncome: isIncome, amount: amount);

        emit(const DoneState());
      },
    );
  }

  void _initGraph() {
    double runningTotal = 0;

    for (final rec in allRecords) {
      runningTotal += rec.$4 ? rec.$3 : -rec.$3;
      graphData.add(FlSpot(graphData.length.toDouble(), runningTotal));
    }

    _recomputeBounds();
  }

  void _insertGraphPoint(
      {required int index, required bool isIncome, required double amount}) {
    final lastTotal = graphData.isNotEmpty ? graphData.last.y : 0;
    final newTotal = isIncome ? lastTotal + amount : lastTotal - amount;

    for (int i = index + 1; i < graphData.length; i++) {
      final old = graphData[i];
      graphData[i] = FlSpot(
        old.x + 1,
        old.y + (isIncome ? amount : -amount),
      );
    }

    graphData.insert(index + 1, FlSpot((index + 1).toDouble(), newTotal));

    _recomputeBounds();
  }

  void _recomputeBounds() {
    final extremes = graphData.map((e) => e.y).fold<List<double>>(
      [0, 0],
      (prev, y) {
        final maxPos = prev[0] < y ? y : prev[0];
        final maxNeg = prev[1] > y ? y : prev[1];
        return [maxPos, maxNeg];
      },
    );

    final maxPos = extremes[0];
    final maxNeg = extremes[1];

    maxY = (maxPos * 1.2).clamp(10, double.infinity);
    minY = (maxNeg * 1.2).clamp(double.negativeInfinity, -10);

    isIncreasing = graphData.length > 1 &&
        graphData.last.y > graphData[graphData.length - 2].y;
  }

  int _getMergedIndex(DateTime newDate) {
    int low = 0, high = allRecords.length;
    while (low < high) {
      int mid = low + (high - low) ~/ 2;
      if (newDate.isBefore(allRecords[mid].$1)) {
        high = mid;
      } else {
        low = mid + 1;
      }
    }
    return low;
  }

  int _getIndex(bool isIncome, DateTime newDate) {
    final list = isIncome ? incomes : expenses;

    int low = 0;
    int high = list.length;

    while (low < high) {
      int mid = low + (high - low) ~/ 2;
      if (newDate.isBefore(list[mid].date)) {
        low = mid + 1;
      } else {
        high = mid;
      }
    }

    return low;
  }

  bool hasEnoughAmount(double expenseAmount) {
    var total = 0.0;

    for (final income in incomes) {
      total += income.amount;
    }

    for (final expense in expenses) {
      total -= expense.amount;
    }

    return total >= expenseAmount;
  }

  List<FinanceRecordEntity> _sortByDate(List<FinanceRecordEntity> list) {
    list.sort((a, b) => b.date.compareTo(a.date) == 0
        ? b.createdAt.compareTo(a.createdAt)
        : b.date.compareTo(a.date));
    return list;
  }
}
