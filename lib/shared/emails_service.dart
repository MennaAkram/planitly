import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/gmail/v1.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

class EmailsService {
  late final http.Client client;
  late final String accessToken;

  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['https://www.googleapis.com/auth/gmail.readonly'],
  );

  Future<String> fetchAttachmentBase64(String messageId, String attachmentId) async {
    final uri = Uri.parse(
      'https://gmail.googleapis.com/gmail/v1/users/me/messages/$messageId/attachments/$attachmentId',
    );

    final response = await client.get(uri, headers: {
      'Authorization': 'Bearer $accessToken',
    });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['data']; // already base64 encoded
    } else {
      throw Exception('Failed to fetch attachment');
    }
  }

  Future<String> replaceCidImagesWithBase64({
    required String html,
    required String messageId,
    required List<dynamic> payloadParts,
  }) async {
    final cidRegex = RegExp('src=["\']cid:(.*?)["\']', caseSensitive: false);
    final matches = cidRegex.allMatches(html).toList();

    for (final match in matches) {
      final cid = match.group(1);
      final part = payloadParts.firstWhere(
            (p) {
          final headers = (p['headers'] ?? []) as List;
          final contentIdHeader = headers.firstWhere(
                (h) =>
            h['name'] == 'Content-ID' &&
                (h['value'] == '<$cid>' || h['value'] == cid),
            orElse: () => null,
          );
          return contentIdHeader != null && p['body']?['attachmentId'] != null;
        },
        orElse: () => null,
      );

      if (part != null) {
        final attachmentId = part['body']['attachmentId'];
        final mimeType = part['mimeType'] ?? 'image/png';

        final base64 = await fetchAttachmentBase64(messageId, attachmentId);
        final dataUrl = 'data:$mimeType;base64,$base64';

        html = html.replaceAll('cid:$cid', dataUrl);
      }
    }

    return html;
  }

  String? extractPlainTextBody(MessagePart? part) {
    if (part == null) return null;
    if (part.mimeType == 'text/plain') {
      final data = part.body?.data;
      if (data != null) {
        return utf8.decode(base64Url.decode(data.replaceAll('-', '+').replaceAll('_', '/')));
      }
    }

    for (final subPart in part.parts ?? []) {
      final text = extractPlainTextBody(subPart);
      if (text != null) return text;
    }

    return null;
  }

  String getGravatarUrl(String email) {
    final normalizedEmail = email.trim().toLowerCase();
    final emailHash = md5.convert(utf8.encode(normalizedEmail)).toString();
    return 'https://www.gravatar.com/avatar/$emailHash?d=identicon';
  }

  String? extractHtmlBody(MessagePart? part) {
    if (part == null) return null;
    if (part.mimeType == 'text/html') {
      final data = part.body?.data;
      if (data != null) {
        return utf8.decode(base64Url.decode(data.replaceAll('-', '+').replaceAll('_', '/')));
      }
    }

    for (final subPart in part.parts ?? []) {
      final html = extractHtmlBody(subPart);
      if (html != null) return html;
    }

    return null;
  }

}

class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final http.Client _client = http.Client();

  GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _client.send(request);
  }

  @override
  void close() {
    _client.close();
    super.close();
  }
}