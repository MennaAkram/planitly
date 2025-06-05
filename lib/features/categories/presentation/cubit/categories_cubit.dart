import 'package:planitly/features/categories/domain/entity/category_entity.dart';
import 'package:planitly/features/categories/domain/repositories/categories_repo.dart';
import 'package:planitly/features/my_pages/domain/entity/page_entity.dart';
import 'package:planitly/shared/bases/base_cubit.dart';
import 'package:planitly/shared/bases/base_state.dart';
import 'package:planitly/shared/networking/failures.dart';

class CategoriesCubit extends BaseCubit {
  final CategoriesRepository _categoriesRepo;

  CategoriesCubit(this._categoriesRepo) : super(const InitState());

  List<CategoryEntity> categories = [];
  List<PageEntity> selectedPages = [];
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

  Future<void> addCategory({required String name}) async {
    if (isAdding) return;
    emit(const LoadingState());

    isAdding = true;

    final result = await _categoriesRepo.addCategory(
        name: name, pageIds: selectedPages.map((e) => e.id).toList());

    result.fold(
      (NetworkException exception) {
        handleException(exception);
      },
      (category) {
        categories.insert(0, category);
        emit(const DoneState());
      },
    );

    isAdding = false;
  }

  Future<void> deleteCategory({required String categoryName}) async {
    emit(const LoadingState());

    final result = await _categoriesRepo.deleteCategory(categoryName: categoryName);

    result.fold(
      (NetworkException exception) {
        handleException(exception);
      },
      (success) {
        categories.removeWhere((category) => category.name == categoryName);
        emit(const DoneState());
      },
    );
  }

  void selectPage(PageEntity page) {
    emit(const LoadingState());

    selectedPages.add(page);

    emit(const DoneState());
  }

  void unselectPage(PageEntity page) {
    emit(const LoadingState());

    selectedPages.remove(page);

    emit(const DoneState());
  }
}
