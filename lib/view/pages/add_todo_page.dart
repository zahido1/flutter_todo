import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/model/todo_model.dart';
import 'package:flutter_todo/provider/constants/all_providers.dart';

class AddTodoPage extends ConsumerWidget {
  AddTodoPage({super.key});

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Todo',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              style: const TextStyle(fontSize: 18),
              decoration: const InputDecoration(
                labelText: 'Todo Description',
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 0, 67, 95),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 0, 67, 95),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 0, 67, 95),
                  ),
                ),
              ),
              onChanged: (value) {
                ref.watch(controllerProvider.notifier).state = value;
              },
              onSubmitted: (value) {
                ref.watch(myTodoNotifierProvider.notifier).addTodo(
                      TodoModel(
                        id: ref.watch(myTodoNotifierProvider).length + 1,
                        description: controller.text,
                        checked: false,
                      ),
                    );
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      ref.watch(myTodoNotifierProvider.notifier).addTodo(
                            TodoModel(
                              id: ref.watch(myTodoNotifierProvider).length + 1,
                              description: controller.text,
                              checked: false,
                            ),
                          );
                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Description should not be empty"),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Todo'),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.clear();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    ),
                  ),
                  child: const Text('Clear'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
