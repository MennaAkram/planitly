class TasksOP {

  final List<Map<String, dynamic>> _tasks = [];
  int _id = 0;

  List<Map<String, dynamic>> getTasks() {
    return _tasks;
  }

  List<Map<String, dynamic>> getTasksByDate(DateTime date, {String? compareBy}) {
    if (compareBy == "month") {
      return _tasks.where((element) => element["date"].month == date.month).toList();
    }
    return _tasks.where((element) => element["date"].toIso8601String().split('T')[0] == date.toIso8601String().split('T')[0]).toList();
  }

  bool isEmpty(DateTime date, {String? compareBy}) {
    if (compareBy == "month") {
      return getTasksByDate(date, compareBy: "month").isEmpty;
    }
    return getTasksByDate(date).isEmpty;
  }

  int generateId() {
    return _id++;
  }

  int findIndexById(int id) {
    return _tasks.indexWhere((element) => element["id"] == id);
  }

  

  void addTask({DateTime? date, String? task, int progress = 0, bool checked = false}) {
    int id = generateId();
    _tasks.add({
      "id": id,
      "date": date,
      "task": task,
      "progress": progress,
      "checked": checked
    });
  }

  void updateTask(int id,
      {DateTime? date, String? task, int? progress, bool? checked}) {
    int index = findIndexById(id);
    if (index != -1) {
      _tasks[index]["date"] = date ?? _tasks[index]["date"];
      _tasks[index]["task"]= task ?? _tasks[index]["task"];
      _tasks[index]["progress"] = progress ?? _tasks[index]["progress"];
      _tasks[index]["checked"] = checked ?? _tasks[index]["checked"];
    }
  }

  void deleteTask(int id) {
    int index = findIndexById(id);
    if (index != -1) {
      _tasks.removeAt(index);
    }
  }
}
