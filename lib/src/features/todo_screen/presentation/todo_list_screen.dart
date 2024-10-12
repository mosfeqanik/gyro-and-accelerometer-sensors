import 'package:flutter/material.dart';
import 'package:next_room/src/utils/app_colors.dart';
import 'package:provider/provider.dart';

import '../provider/todo_provider.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TextEditingController listEdtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lists"),
        centerTitle: false,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TextField(
                controller: listEdtController,
                decoration: const InputDecoration(hintText: "Enter List title"),
                textInputAction: TextInputAction.done,
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    Provider.of<TodoNoteProvider>(context, listen: false).createNoteList(
                        listTitle:value);
                    listEdtController.clear();
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('List "$value" added')),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
