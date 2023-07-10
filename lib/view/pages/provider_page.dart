import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/model/todo_model.dart';
import 'package:flutter_todo/provider/constants/all_providers.dart';
import 'package:flutter_todo/view/pages/add_todo_page.dart';

class ProviderPage extends ConsumerWidget {
  const ProviderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<TodoModel> todos = ref.watch(myTodoNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: todos.isNotEmpty
          ? ListView.separated(
              itemCount: todos.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(todos[index].id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    ref
                        .read(myTodoNotifierProvider.notifier)
                        .deleteTodo(todos[index].id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Item was removed"),
                        action: SnackBarAction(
                            label: "Get back",
                            onPressed: () {
                              ref
                                  .read(myTodoNotifierProvider.notifier)
                                  .addTodo(todos[index]);
                            }),
                      ),
                    );
                  },
                  child: CheckboxListTile(
                    value: todos[index].checked,
                    onChanged: (value) {
                      ref
                          .read(myTodoNotifierProvider.notifier)
                          .toggleChecked(todos[index].id);
                    },
                    title: Text(
                      todos[index].description,
                      style: TextStyle(
                        decoration: todos[index].checked
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                  ),
                );
              },
            )
          : const Center(child: Text("Empty")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddTodoPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
