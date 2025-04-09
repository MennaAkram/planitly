class Email {
  final int id;
  final String text;
  final DateTime date;
  final String icon;
  bool isRead = false;

  Email(
      {required this.id,
      required this.text,
      required this.date,
      required this.icon});

  String getDate() {
    return '${date.day}-${date.month}-${date.year}';
  }
}

class EmailsOP {
  final List<Email> _emails = [];
  int _id = 0;

  List<Email> getEmails() => _emails;

  bool isEmpty() => _emails.isEmpty;

  int _generateId() => _id++;

  void addEmail(String text, {DateTime? date, String? icon}) {
    _emails.insert(
        0,
        Email(
            id: _generateId(),
            text: text,
            date: date ?? DateTime.now(),
            icon: icon ?? 'assets/icons/notification.svg'));
  }
}
