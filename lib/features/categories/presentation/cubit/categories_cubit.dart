import 'package:planitly/features/categories/domain/entity/category_entity.dart';
import 'package:planitly/features/categories/domain/repositories/categories_repo.dart';
import 'package:planitly/shared/bases/base_cubit.dart';
import 'package:planitly/shared/bases/base_state.dart';
import 'package:planitly/shared/networking/failures.dart';

class CategoriesCubit extends BaseCubit {
  final CategoriesRepository _categoriesRepo;

  CategoriesCubit(this._categoriesRepo) : super(const InitState());

  List<CategoryEntity> categories = [];
  int _offset = 0;
  bool hasMore = true;
  bool isLoading = false;
  bool isAdding = false;

  Future<void> getCategories({bool initial = false}) async {
    if (isLoading || !hasMore) return;

    isLoading = true;

    if (initial) {
      categories.clear();
      _offset = 0;
    }

    emit(const LoadingState());

    final result = await _categoriesRepo.getCategories(offset: _offset);

    result.fold(
      (NetworkException exception) {
        handleException(exception);
      },
      (data) {
        categories.addAll(data.categories);
        _offset += data.categories.length;
        hasMore = _offset < data.total;
        emit(const DoneState());
      },
    );

    isLoading = false;
  }
}
