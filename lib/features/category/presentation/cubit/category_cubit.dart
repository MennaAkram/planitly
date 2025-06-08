import 'package:dartz/dartz.dart';
import 'package:planitly/features/category/domain/entity/category_info_entity.dart';
import 'package:planitly/features/category/domain/repository/category_repo.dart';
import 'package:planitly/features/my_pages/domain/entity/page_entity.dart';
import 'package:planitly/shared/bases/base_cubit.dart';
import 'package:planitly/shared/bases/base_state.dart';
import 'package:planitly/shared/networking/failures.dart';

class CategoryCubit extends BaseCubit {
  final CategoryRepository _categoryRepo;

  CategoryCubit(this._categoryRepo) : super(const InitState());

  List<PageEntity> pages = [];
  String categoryName = '';
  int _offset = 0;
  bool hasMore = true;
  bool isLoading = false;
  bool isAdding = false;

  Future<void> getCategoryInfo({bool initial = false}) async {
    if (isLoading || !hasMore) return;

    isLoading = true;

    if (initial) {
      pages.clear();
      _offset = 0;
    }

    emit(LoadingState());

    Either<NetworkException, CategoryInfoEntity> result = await _categoryRepo
        .getCategoryInfo(categoryName: categoryName, offset: _offset);

    result.fold(
      (NetworkException exception) {
        handleException(exception);
      },
      (data) {
        pages.addAll(data.pagesInfo.pages);
        _offset += data.pagesInfo.pages.length;
        hasMore = _offset < data.pagesInfo.total;
        emit(const DoneState());
      },
    );

    isLoading = false;
  }
}
