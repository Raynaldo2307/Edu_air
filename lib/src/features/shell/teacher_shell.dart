// lib/src/features/shell/teacher_shell.dart
import 'package:flutter/material.dart';

class TeacherShell extends StatelessWidget {
  const TeacherShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Teacher Home')),
      body: const Center(child: Text('Teacher dashboard goes here 🍎')),
    );
  }
}
