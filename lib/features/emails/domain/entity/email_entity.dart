class EmailEntity {
  final String sender;
  final String senderEmail;
  final String date;
  final String snippet;
  final String gravatarUrl;
  final String subject;
  final String? fullBody;

  EmailEntity({
    required this.sender,
    required this.senderEmail,
    required this.date,
    required this.snippet,
    required this.gravatarUrl,
    required this.subject,
    this.fullBody,
  });
}