import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/model/todo_model.dart';

class TodoNotifierManager extends StateNotifier<List<TodoModel>> {
  TodoNotifierManager() : super([]);

  void addTodo(TodoModel todo) {
    state = [...state, todo];
  }

  void toggleChecked(int id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          TodoModel(
            id: todo.id,
            description: todo.description,
            checked: !todo.checked,
          )
        else
          todo,
    ];
  }

  void deleteTodo(int id) {
    state = [
      for (final todo in state)
        if (todo.id != id) todo,
    ];
  }
}
