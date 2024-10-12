import 'package:flutter/material.dart';
import 'package:next_room/src/core/data/model/note.dart';
import 'package:next_room/src/utils/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../utils/date_time_util.dart';
import '../components/list_tile_design_for_task.dart';
import '../provider/todo_provider.dart';

class AddTaskScreen extends StatefulWidget {
  final int listId;
  final String listTitle;

  const AddTaskScreen(
      {super.key, required this.listId, required this.listTitle});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController addTaskEditingController =
      TextEditingController();
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        print(_selectedDate);
      });
    }
  }

  @override
  void initState() {
    Provider.of<TodoNoteProvider>(context, listen: false)
        .loadNotes(widget.listId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task to ${widget.listTitle}"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Consumer<TodoNoteProvider>(
              builder: (context, provider, child) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.notes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TaskListTileWidget(
                        note: provider.notes[index],
                        listId: widget.listId,
                      );
                    });
              },
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<TodoNoteProvider>(
                      builder: (context, provider, child) {
                        return Row(
                          children: [
                            const Icon(
                              Icons.check_box_outline_blank,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: addTaskEditingController,
                                decoration: const InputDecoration(
                                  hintText: 'Add a task',
                                  border: InputBorder.none,
                                ),
                                textInputAction: TextInputAction.done,
                                onSubmitted: (value) {
                                  provider.addNoteToList(
                                    note: Note(
                                        task: addTaskEditingController.text,
                                        createdTime: _selectedDate!,
                                        listId: widget.listId,
                                        isImportant: false,
                                        number: 1),
                                    listId: widget.listId,
                                  );
                                  addTaskEditingController.clear();
                                  setState(() {
                                    _selectedDate = null;
                                  });
                                  provider.isValidLength = false;
                                },
                                onChanged: (value) {
                                  provider.checkLength(value);
                                },
                                autofocus: true,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.check_circle,
                                color: provider.isValidLength
                                    ? AppColors.primaryColor
                                    : Colors.grey,
                              ),
                              onPressed: () {},
                            )
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.notifications_none),
                          onPressed: () {
                            // Notification logic
                          },
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.calendar_today_outlined),
                              onPressed: () {
                                _selectDate(context);
                              },
                            ),
                            Text(
                              _selectedDate == null
                                  ? 'No date selected'
                                  : 'Selected date: ${formatDate(_selectedDate!)}',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Padding to prevent elements from being blocked by the keyboard
          ],
        ),
      ),
    );
  }
}
