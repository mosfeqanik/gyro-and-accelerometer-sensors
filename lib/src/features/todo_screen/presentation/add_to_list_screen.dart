import 'package:flutter/material.dart';
import 'package:next_room/src/utils/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/list_tile_design_for_task.dart';
import '../provider/todo_provider.dart';
import 'add_task.dart';

class AddtoListScreen extends StatefulWidget {
  final String? listTitle;
  final String listSerial;

  const AddtoListScreen({super.key, this.listTitle, required this.listSerial});

  @override
  State<AddtoListScreen> createState() => _AddtoListScreenState();
}

class _AddtoListScreenState extends State<AddtoListScreen> {
  @override
  void initState() {
    Provider.of<TodoNoteProvider>(context, listen: false)
        .loadNotes(int.parse(widget.listSerial));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lists"),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "${widget.listTitle}",
              style: const TextStyle(fontSize: 16),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Consumer<TodoNoteProvider>(
                  builder: (context, provider, child) {
                    return provider.notes.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: provider.notes.length,
                            itemBuilder: (BuildContext context, int index) {
                              return TaskListTileWidget(
                                note: provider.notes[index],
                                listId: int.parse(widget.listSerial),
                              );
                            })
                        : Text(
                            "No task added",
                            style: const TextStyle(fontSize: 16),
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Card(
        elevation: 5,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddTaskScreen(
                  listId: int.parse(widget.listSerial),
                  listTitle: widget.listTitle!,
                ),
              ),
            );
          },
          child: Container(
            height: 40,
            width: MediaQuery.of(context).size.width * .80,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor, // Red background color
                    shape: BoxShape.circle, // Circular shape
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Add a Task",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
