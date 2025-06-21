import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Task Manager", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Version 1.0.0"),
            SizedBox(height: 20),
            Text("Developed by Bilal"),
            SizedBox(height: 10),
            Text("This app helps you manage daily tasks with a clean UI, persistent storage, and user profiles."),
          ],
        ),
      ),
    );
  }
}
