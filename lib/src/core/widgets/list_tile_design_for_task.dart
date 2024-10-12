import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:next_room/src/core/data/model/note.dart';
import 'package:provider/provider.dart';

import '../../utils/date_time_util.dart';
import '../../features/todo_screen/provider/todo_provider.dart';

class TaskListTileWidget extends StatelessWidget {
  final Note note;
  final int listId;

  const TaskListTileWidget({
    super.key,
    required this.note,
    required this.listId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.check_box_outline_blank,
            color: Colors.black12,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 8),
              SizedBox(
                width: 150.w,
                child: Text(
                  note.task,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black45,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                formatDate(note.createdTime),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Provider.of<TodoNoteProvider>(context, listen: false)
                        .updateNote(
                            note: note.copy(
                                isImportant: note.isImportant ? false : true),
                            listId: listId);
                  },
                  icon: Icon(
                    note.isImportant
                        ? Icons.star
                        : Icons.star_border_purple500_outlined,
                    color: note.isImportant ? Colors.amber : Colors.grey,
                  )),
              IconButton(
                  onPressed: () {
                    Provider.of<TodoNoteProvider>(context, listen: false)
                        .deleteNoteById(noteId: note.id, listId: listId);
                  },
                  icon: const Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.red,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
