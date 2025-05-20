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

  getPages({bool initial = false}) async {
    if (isLoading || !hasMore) return;

    isLoading = true;

    if (initial) {
      emit(LoadingState());
      _offset = 0;
      pages.clear();
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
}
