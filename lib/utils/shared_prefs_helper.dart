import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';
class UserPrefsService {
  static Future<void> saveUser({
    required String username,
    required String email,
    required String password,
    required String gender,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    await prefs.setString('gender', gender);
  }
  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = tasks.map((task) => task.toJson()).toList();
    prefs.setString('tasks', jsonEncode(tasksJson));
  }


  static Future<Map<String, String?>> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'username': prefs.getString('username'),
      'email': prefs.getString('email'),
      'password': prefs.getString('password'),
      'gender': prefs.getString('gender'),
    };
  }
}
class SharedPrefsService {
  static const String _key = "tasks";

  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> taskList =
    tasks.map((task) => jsonEncode(task.toJson())).toList();
    await prefs.setStringList(_key, taskList);
  }

  static Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? taskList = prefs.getStringList(_key);
    if (taskList == null) return [];
    return taskList
        .map((taskStr) => Task.fromJson(jsonDecode(taskStr)))
        .toList();
  }
}
