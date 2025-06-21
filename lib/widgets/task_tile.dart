import 'package:flutter/material.dart';
import '../models/task.dart';
import '../utils/shared_prefs_helper.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final int index;
  final List<Task> taskList;
  final Function(List<Task>) onTaskListChanged;

  TaskTile({
    required this.task,
    required this.index,
    required this.taskList,
    required this.onTaskListChanged,
  });

  void _showDescriptionEditor(BuildContext context) {
    final TextEditingController descController =
    TextEditingController(text: task.description);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(task.title),
        content: TextField(
          controller: descController,
          maxLines: 8,
          decoration: InputDecoration(
            labelText: "Edit Description",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              taskList[index].description = descController.text;
              await SharedPrefsService.saveTasks(taskList);
              onTaskListChanged(taskList);
              Navigator.pop(context);
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDone = task.isDone;

    return GestureDetector(
      onTap: () => _showDescriptionEditor(context),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDone ? Colors.green.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                isDone ? Icons.check_box : Icons.check_box_outline_blank,
                color: isDone ? Colors.green : Colors.grey,
              ),
              onPressed: () async {
                taskList[index].isDone = !isDone;
                await SharedPrefsService.saveTasks(taskList);
                onTaskListChanged(taskList);
              },
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 16,
                      color: isDone ? Colors.grey : Colors.black,
                      fontWeight: FontWeight.w600,
                      decoration: isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    task.description.isNotEmpty
                        ? "Tap to view/edit description"
                        : "No description",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                taskList.removeAt(index);
                await SharedPrefsService.saveTasks(taskList);
                onTaskListChanged(taskList);
              },
            ),
          ],
        ),
      ),
    );
  }
}
