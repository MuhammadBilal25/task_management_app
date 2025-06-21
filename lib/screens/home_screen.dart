import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_tile.dart';
import '../utils/shared_prefs_helper.dart';
import 'add_task_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];
  String username = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    _loadTasks();
    _loadUserInfo();
  }


  void _loadUserInfo() async {
    final user = await UserPrefsService.getUser();
    setState(() {
      username = user['username'] ?? '';
      email = user['email'] ?? '';
    });
  }

  void _loadTasks() async {
    tasks = await SharedPrefsService.loadTasks();
    setState(() {});
  }

  void _addTask(Task task) async {
    setState(() => tasks.add(task));
    await SharedPrefsService.saveTasks(tasks);
  }

  void _deleteTask(int index) async {
    setState(() => tasks.removeAt(index));
    await SharedPrefsService.saveTasks(tasks);
  }

  void _toggleComplete(int index) async {
    setState(() => tasks[index].isDone = !tasks[index].isDone);
    await SharedPrefsService.saveTasks(tasks);
  }

  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
          (route) => false,
    );
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: "Task Manager",
      applicationVersion: "1.0.0",
      applicationLegalese: "© 2025 DeveloperHub ",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TASK MANAGER",style: TextStyle(fontWeight:FontWeight.bold,color: Colors.white ),),
         backgroundColor: Color(0xFF6950a1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            //  User Info Header
            UserAccountsDrawerHeader(
              accountName: Text(username),
              accountEmail: Text(email),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.blue, size: 40),
              ),
            ),
            //  About Menu Item
            ListTile(
              leading: Icon(Icons.info),
              title: Text("About"),
              onTap: _showAboutDialog,
            ),
            //  Logout Menu Item
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: _logout,
            ),
          ],
        ),
      ),
      body: tasks.isEmpty
          ? Center(child: Text("No tasks yet."))
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (_, index) => TaskTile(
          task: tasks[index],
          index: index,
          taskList: tasks,
          onTaskListChanged: (updatedList) {
            setState(() {
              tasks = updatedList;
            });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddTaskScreen()),
          );
          if (newTask != null) _addTask(newTask);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
