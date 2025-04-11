
class Habit {
  final int id;
  final DateTime date;
  final String habit;
  double progress;
  bool checked;
  List<Task> tasks;

  Habit(
      {required this.id,
      required this.date,
      required this.habit,
      this.progress = 0,
      this.checked = false,
      List<Task>? tasks})
      : tasks = tasks ?? [];

  int _id = 0;

  int _generateId() => _id++;

  void addTask(String task) {
    tasks.add(Task(id: _generateId(), task: task));
    updateProgress();
  }

  Task getTask(int id) => tasks.firstWhere((task) => task.id == id);

  void updateTask(int id, bool checked) {
    final task = getTask(id);
    task.checked = checked;
    updateProgress();
  }

  void updateProgress({bool? allChecked}) {
    if (allChecked != null) {
      progress = allChecked ? 1 : 0;
      for (Task task in tasks) {
        task.checked = allChecked;
        }
    } else {
      final int checkedTasks = tasks.where((task) => task.checked).length;
      progress = checkedTasks / tasks.length;
      checked = checkedTasks == tasks.length;
    }
  }
}

class Task {
  final int id;
  final String task;
  bool checked;

  Task({required this.id, required this.task, this.checked = false});
}

class HabitsOP {
  final List<Habit> _habits = [];
  int _id = 0;

  int _generateId() => _id++;

  Habit getHabit(int id) => _habits.firstWhere((habit) => habit.id == id);

  bool isEmpty(DateTime date, {String? compareBy}) {
    if (compareBy == "month") {
      return getHabits(date: date, compareBy: "month").isEmpty;
    }
    return getHabits(date: date).isEmpty;
  }

  List<Habit> getHabits({DateTime? date, String compareBy = "day"}) {
  if (date == null) {
    return _habits;
  }

  return _habits.where((habit) {
    if (compareBy == "month") {
      return habit.date.month == date.month && habit.date.year == date.year;
    }
    return habit.date.year == date.year &&
           habit.date.month == date.month &&
           habit.date.day == date.day;
  }).toList();
}

  void addHabit(
      {DateTime? date,
      String? habit,
      double progress = 0,
      bool checked = false}) {
    _habits.add(Habit(
      id: _generateId(),
      date: date ?? DateTime.now(),
      habit: habit ?? "",
      progress: progress,
      checked: checked,
    ));
  }

  void updateHabit(int id, {double? progress, bool? checked, List<Task>? tasks}) {
    final habit = getHabit(id);
    habit
      ..progress = progress ?? habit.progress
      ..checked = checked ?? habit.checked
      ..tasks = tasks ?? habit.tasks;
  }
}
