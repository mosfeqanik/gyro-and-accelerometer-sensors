import 'package:flutter/material.dart';
import 'package:next_room/src/features/todo_screen/presentation/todo_list_screen.dart';
import 'package:next_room/src/utils/app_assets.dart';
import 'package:next_room/src/utils/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/list_tile_design.dart';
import '../provider/todo_provider.dart';

import 'add_to_list_screen.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  void initState() {
    Provider.of<TodoNoteProvider>(context, listen: false).loadNoteList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.only(right: 20),
              child: Image.asset(
                AppAssets.proImage,
                width: 50,
              ),
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Zoyeb Ahmed",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "",
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.more_vert_outlined))
        ],
      ),
      body: Column(
        children: [
          Consumer<TodoNoteProvider>(
            builder: (context, provider, child) {

              return provider.list != null
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: provider.list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AddtoListScreen(
                                  listTitle: provider.list[index]["title"],
                                  listSerial:
                                      provider.list[index]["id"].toString(),
                                ),
                              ),
                            );
                          },
                          child: ListTileWidget(
                            listTitle: provider.list[index]["title"],
                            listSerial: provider.list[index]["id"].toString(),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const TodoListScreen(),
            ),
          );
        },
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
