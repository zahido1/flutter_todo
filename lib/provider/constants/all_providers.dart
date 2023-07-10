import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/model/todo_model.dart';
import 'package:flutter_todo/provider/business/todo_manager.dart';

final controllerProvider = StateProvider<String>((ref) {
  return "";
});

final myTodoNotifierProvider =
    StateNotifierProvider<TodoNotifierManager, List<TodoModel>>((ref) {
  return TodoNotifierManager();
});
