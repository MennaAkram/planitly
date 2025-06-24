import 'package:dartz/dartz.dart';
import 'package:googleapis/gmail/v1.dart' as gmail;
import 'package:googleapis/gmail/v1.dart';
import 'package:intl/intl.dart';
import 'package:planitly/features/emails/domain/repositories/emails_repo.dart';
import 'package:planitly/shared/networking/failures.dart';
import '../../../../shared/bases/base_repo.dart';
import '../../../../shared/emails_service.dart';
import '../../domain/entity/email_entity.dart';

class EmailsRepositoryImpl extends BaseRepository
    implements EmailsRepository {
  final EmailsService _service;

  EmailsRepositoryImpl(super.dio, this._service);

  @override
  Future<Either<NetworkException, List<EmailEntity>>> getEmails({int offset = 0}) async {
    try {
      final isSignedIn = await _service.googleSignIn.isSignedIn();
      if (!isSignedIn) {
        final user = await _service.googleSignIn.signIn();
        if (user == null) {
          return left(UnAuthorizedFailure("User not signed in"));
        }
      }

      final account = await _service.googleSignIn.currentUser?.authentication;
      if (account == null) {
        return left(UnAuthorizedFailure("No authentication found"));
      }

      final authClient = GoogleAuthClient({'Authorization': 'Bearer ${account.accessToken}'});
      final gmailApi = gmail.GmailApi(authClient);

      final messagesResponse = await gmailApi.users.messages.list('me', maxResults: 60, labelIds: ['INBOX']);
      final messages = messagesResponse.messages ?? [];

      print("Fetched messages count: ${messagesResponse.messages?.length ?? 0}");
      print("NextPageToken: ${messagesResponse.nextPageToken}");
      print("Fetched messages: ${messages.map((m) => m.snippet).toList()}");

      List<EmailEntity> emails = [];

      for (var msg in messages) {
        final message = await gmailApi.users.messages.get('me', msg.id!);
        final headers = message.payload?.headers ?? [];

        final fromHeader = headers.firstWhere(
              (h) => h.name?.toLowerCase() == 'from',
          orElse: () => gmail.MessagePartHeader(name: 'From', value: 'Unknown <unknown@email.com>'),
        ).value ?? 'Unknown';

        final subject = headers.firstWhere(
              (h) => h.name?.toLowerCase() == 'subject',
          orElse: () => gmail.MessagePartHeader(name: 'Subject', value: ''),
        ).value ?? '';

        final dateHeader = headers.firstWhere(
              (h) => h.name?.toLowerCase() == 'date',
          orElse: () => MessagePartHeader(name: 'Date', value: ''),
        );

        String formattedDate = '';
        if (dateHeader.value != null && dateHeader.value!.isNotEmpty) {
          try {
            final parsedDate = DateTime.parse(
              DateFormat('EEE, dd MMM yyyy HH:mm:ss Z').parseUTC(dateHeader.value!).toIso8601String(),
            );

            formattedDate = '${parsedDate.day}-${parsedDate.month}-${parsedDate.year}';
          } catch (e) {
            formattedDate = dateHeader.value!;
          }
        } else {
          formattedDate = '';
        }

        String body;
        final htmlBody = _service.extractHtmlBody(message.payload);
        if (htmlBody != null) {
          final rawParts = message.payload?.parts?.map((p) => p.toJson()).toList() ?? [];
          body = await _service.replaceCidImagesWithBase64(
            html: htmlBody,
            messageId: message.id!,
            payloadParts: rawParts,
          );
        } else {
          body = _service.extractPlainTextBody(message.payload) ?? message.snippet ?? '';
        }

        final senderRegex = RegExp(r'^(.*?)\s*<(.+?)>$');
        final match = senderRegex.firstMatch(fromHeader);
        final sender = match?.group(1) ?? fromHeader;
        final senderEmail = match?.group(2) ?? fromHeader;

        final gravatarUrl = _service.getGravatarUrl(senderEmail);

        emails.add(EmailEntity(
          sender: sender,
          senderEmail: senderEmail,
          date: formattedDate,
          snippet: message.snippet ?? '',
          gravatarUrl: gravatarUrl,
          subject: subject,
          fullBody: body,
        ));
      }

      return right(emails);
    } catch (e) {
      return left(NotFoundException("Failed to fetch emails: $e"));
    }
  }

  @override
  Future<bool> isSignedIn() async {
    final account = await _service.googleSignIn.signInSilently();
    return account != null;

  }

  @override
  Future<List<EmailEntity>> fetchRecentEmails() async {
    final result = await getEmails(offset: 0);
    return result.getOrElse(() => []);
  }

  @override
  Future<List<EmailEntity>> signInAndFetchEmails() async {
    final account = await _service.googleSignIn.signIn();
    if (account == null) return [];

    return fetchRecentEmails();
  }

}