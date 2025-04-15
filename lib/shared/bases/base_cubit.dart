import 'package:flutter_bloc/flutter_bloc.dart';

import '../networking/failures.dart';
import 'base_state.dart';

abstract class BaseCubit extends Cubit<BaseState> {
  BaseCubit(super.state);

  void handleException(NetworkException exception) {
    if (exception is NoInternetError) {
      emit(NoInternetErrorState());
      return;
    } else if (exception is BadRequest) {
      emit(BadRequestState(massege: exception.message));
      return;
    } else if (exception is Conflict) {
      emit(ConflictState(massege: exception.message));
      return;
    } else if (exception is AlreadyExistException) {
      emit(AlreadyExistState(message: exception.message));
      return;
    } else {
      emit(ErrorState(msg: exception.message));
      return;
    }
  }
}
