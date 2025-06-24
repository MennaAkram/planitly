import 'package:dartz/dartz.dart';
import '../../../../shared/networking/failures.dart';
import '../entity/email_entity.dart';

abstract class EmailsRepository {
  Future<Either<NetworkException, List<EmailEntity>>> getEmails({int offset});
  Future<List<EmailEntity>> fetchRecentEmails();
  Future<bool> isSignedIn();
  Future<List<EmailEntity>> signInAndFetchEmails();
}