import 'package:intl/intl.dart';

class HabitsOP {
  final List<Map<String, dynamic>> _habits = [];
  int _id = 0;

  List<Map<String, dynamic>> getHabits() {
    return _habits;
  }

  Map<String, int> getHabitsCountByDate() {
    Map<String, int> habitsCount = {};
    for (var habit in _habits) {
      String date = DateFormat('yyyy-MM-dd').format(habit["date"]);
      if (habitsCount.containsKey(date)) {
        habitsCount[date] = habitsCount[date]! + 1;
      } else {
        habitsCount[date] = 1;
      }
    }
    return habitsCount;
  }

  List<Map<String, dynamic>> getHabitsByDate(DateTime date,
      {String? compareBy}) {
    if (compareBy == "month") {
      return _habits
          .where((habit) => habit["date"].month == date.month)
          .toList();
    }
    return _habits
        .where((habit) =>
            habit["date"].toIso8601String().split('T')[0] ==
            date.toIso8601String().split('T')[0])
        .toList();
  }

  bool isEmpty(DateTime date, {String? compareBy}) {
    if (compareBy == "month") {
      return getHabitsByDate(date, compareBy: "month").isEmpty;
    }
    return getHabitsByDate(date).isEmpty;
  }

  int generateId() {
    return _id++;
  }

  int findIndexById(int id) {
    return _habits.indexWhere((habit) => habit["id"] == id);
  }

  void addHabit(
      {DateTime? date, String? habit, int progress = 0, bool checked = false}) {
    int id = generateId();
    _habits.add({
      "id": id,
      "date": date,
      "habit": habit,
      "progress": progress,
      "checked": checked
    });
  }

  void updateHabit(int id,
      {DateTime? date, String? habit, int? progress, bool? checked}) {
    int index = findIndexById(id);

    if (index != -1) {
      _habits[index]["date"] = date ?? _habits[index]["date"];
      _habits[index]["habit"] = habit ?? _habits[index]["habit"];
      _habits[index]["progress"] = progress ?? _habits[index]["progress"];
      _habits[index]["checked"] = checked ?? _habits[index]["checked"];
    }
  }

  void deleteHabit(int id) {
    int index = findIndexById(id);
    if (index != -1) {
      _habits.removeAt(index);
    }
  }
}
