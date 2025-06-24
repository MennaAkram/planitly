import 'dart:ui';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../../../../shared/bases/base_cubit.dart';
import '../../../../shared/bases/base_state.dart';
import '../../domain/entity/email_entity.dart';
import '../../domain/repositories/emails_repo.dart';

class EmailsCubit extends BaseCubit {
  final EmailsRepository _emailsRepo;

  EmailsCubit(this._emailsRepo) : super(const InitState());

  List<EmailEntity> emails = [];
  int _offset = 0;
  bool hasMore = true;
  bool isLoading = false;
  bool isSignedIn = false;
  bool hasCheckedSignIn = false;

  void getEmails({bool initial = false}) async {
    if (isLoading || !hasMore) return;

    if (initial) {
      emit(LoadingState());
      _offset = 0;
      emails.clear();
    }

    isLoading = true;

    final result = await _emailsRepo.getEmails(offset: _offset);

    result.fold(
          (exception) {
        handleException(exception);
      },
          (fetchedEmails) {
        emails.addAll(fetchedEmails);
        _offset += fetchedEmails.length;
        hasMore = fetchedEmails.isNotEmpty;
        emit(DoneState());
      },
    );

    isLoading = false;
  }

  Future<void> checkIfSignedIn() async {
    emit(LoadingState());

    isSignedIn = await _emailsRepo.isSignedIn();
    hasCheckedSignIn = true;

    print("isSignedIn: $isSignedIn");

    if (isSignedIn) {
      final fetchedEmails = await _emailsRepo.fetchRecentEmails();
      print("Fetched emails: ${fetchedEmails.length}");

      emails = fetchedEmails;
      _offset = emails.length;
      hasMore = emails.isNotEmpty;
      emit(DoneState());
    } else {
      emails.clear();
      hasMore = true;
      _offset = 0;
      emit(DoneState());
    }
  }

  Future<void> handleSignIn() async {
    emit(LoadingState());

    final fetchedEmails = await _emailsRepo.signInAndFetchEmails();

    emails = fetchedEmails;
    _offset = emails.length;
    hasMore = emails.isNotEmpty;
    emit(DoneState());
  }

  String getInitials(String name) {
    name = name.trim();
    if (name.startsWith('"') && name.endsWith('"')) {
      name = name.substring(1, name.length - 1);
    }

    final parts = name.split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();

    if (parts.isEmpty) return '?';
    return parts[0][0].toUpperCase();
  }

  Color colorFromEmail(String email) {
    final hash = md5.convert(utf8.encode(email)).toString();
    final hex = hash.replaceAll(RegExp('[^0-9a-fA-F]'), '').padRight(6, '0').substring(0, 6);
    return Color(int.parse('0xFF$hex'));
  }

}