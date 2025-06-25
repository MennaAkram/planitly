import 'package:dartz/dartz.dart';
import 'package:planitly/features/my_pages/domain/entity/page_entity.dart';
import 'package:planitly/features/my_pages/domain/entity/pages_info_entity.dart';
import 'package:planitly/features/my_pages/domain/repositories/pages_repo.dart';
import 'package:planitly/shared/bases/base_cubit.dart';
import 'package:planitly/shared/bases/base_state.dart';
import 'package:planitly/shared/networking/failures.dart';

class PagesCubit extends BaseCubit {
  final PagesRepository _pagesRepo;

  PagesCubit(this._pagesRepo) : super(const InitState());

  List<PageEntity> pages = [];
  int _offset = 0;
  bool hasMore = true;
  bool isLoading = false;
  bool isAdding = false;

  Future<void> getPages({bool initial = false}) async {
    if (isLoading || !hasMore) return;

    isLoading = true;

    if (initial) {
      pages.clear();
      _offset = 0;
    }

    emit(LoadingState());

    Either<NetworkException, PagesInfoEntity> result =
        await _pagesRepo.getPages(offset: _offset);

    result.fold(
      (NetworkException exception) {
        handleException(exception);
      },
      (PagesInfoEntity data) {
        pages.addAll(data.pages);
        _offset += data.pages.length;
        hasMore = _offset < data.total;
        emit(DoneState());
      },
    );

    isLoading = false;
  }

  Future<void> addPage({required String name}) async {
    if (isAdding) return;
    isAdding = true;
    emit(LoadingState());

    Either<NetworkException, PageEntity> result =
        await _pagesRepo.addPage(name: name);

    result.fold(
      (NetworkException exception) {
        handleException(exception);
      },
      (PageEntity newPage) {
        pages.insert(0, newPage);
        emit(DoneState());
      },
    );

    isAdding = false;
  }

  Future<void> deletePage({required String pageId}) async {
    emit(LoadingState());

    Either<NetworkException, bool> result =
        await _pagesRepo.deletePage(pageId: pageId);

    result.fold(
      (NetworkException exception) {
        handleException(exception);
      },
      (bool success) {
        pages.removeWhere((page) => page.id == pageId);
        emit(DoneState());
      },
    );
  }
}
