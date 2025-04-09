class Notify {
  final int id;
  final String text;
  final DateTime date;
  final String icon;
  bool isRead;

  Notify({
    required this.id,
    required this.text,
    required this.date,
    this.isRead = false,
    this.icon = 'assets/icons/notification.svg',
  });

  String getDate() {
    return '${date.day}-${date.month}-${date.year}';
  }
}

class NotificationsOP {
  final List<Notify> _notifications = [];
  int _id = 0;

  int _generateId() => _id++;

  List<Notify> getNotifications() => _notifications;

  bool isEmpty() => _notifications.isEmpty;

  void addNotification(String text, {DateTime? date}) {
    _notifications.insert(
        0,
        Notify(
          id: _generateId(),
          text: text,
          date: date ?? DateTime.now(),
        ));
  }
}
