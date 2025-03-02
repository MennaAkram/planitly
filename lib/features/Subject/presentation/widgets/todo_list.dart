import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';

class ToDoList extends StatefulWidget {
   const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final List<Map<String, dynamic>> _tasks = [
    {
      'task': '',
      'isDone': false,
      'controller': TextEditingController(),
      'focusNode': FocusNode()
    },
  ];

  void _addTask(String task, int index) {
    if (task.trim().isEmpty) {
      return;
    }

    setState(() {
      _tasks.insert(index + 1, {
        'task': '',
        'isDone': false,
        'controller': TextEditingController(),
        'focusNode': FocusNode()..requestFocus()
      });
    });
  }

  void _toggleTaskStatus(int index) {
    setState(() {
      _tasks[index]['isDone'] = !_tasks[index]['isDone'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ..._tasks.asMap().entries.map((entry) {
          final index = entry.key;
          return _buildTaskItem(context, index);
        }),
      ],
    );
  }

  Widget _buildTaskItem(BuildContext context, int index) {
    final TextEditingController controller = _tasks[index]['controller'];
    return Row(
      children: [
        Checkbox(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          side: BorderSide(
            color: controller.text.isEmpty
                ? Theme.of(context).appColors.black37
                : Theme.of(context).appColors.black87,
            width: 1,
          ),
          value: _tasks[index]['isDone'],
          onChanged: (_) => _toggleTaskStatus(index),
        ),
        Expanded(
          child: TextField(
            controller: controller,
            focusNode: _tasks[index]['focusNode'],
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "To-do",
              hintStyle: Theme.of(context).appTexts.bodySmall.copyWith(
                    color: Theme.of(context).appColors.black37,
                  ),
            ),
            style: Theme.of(context).appTexts.bodySmall.copyWith(
                  color: Theme.of(context).appColors.black87,
                ),
            onChanged: (value) {
              setState(() {
                _tasks[index]['task'] = value;
              });
            },
            onSubmitted: (value) {
              _addTask(value, index);
            },
          ),
        ),
      ],
    );
  }
}
