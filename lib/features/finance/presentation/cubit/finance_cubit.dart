
import 'package:planitly/features/finance/domain/entity/expense_entity.dart';
import 'package:planitly/features/finance/domain/entity/income_entity.dart';
import 'package:planitly/features/finance/domain/repositories/finance_repo.dart';
import 'package:planitly/shared/bases/base_cubit.dart';
import 'package:planitly/shared/bases/base_state.dart';

class FinanceCubit extends BaseCubit {
  final FinanceRepository _financeRepo;

  FinanceCubit(this._financeRepo) : super(const InitState());

  List<IncomeEntity> incomes = [];
  List<ExpenseEntity> expenses = [];

  getFinance() async {
    emit(const LoadingState());

    final result = await _financeRepo.getFinance();

    return result.fold(
      (exception) {
        handleException(exception);
      },
      (data) {
        incomes = data.incomeInfo.incomeList;
        expenses = data.expenseInfo.expenseList;
        emit(const DoneState());
      },
    );
  }

}