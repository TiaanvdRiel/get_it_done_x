import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_it_done_x/app/data/services/storage/services.dart';
import '../../../core/utils/keys.dart';
import '../../modules/todo_list.dart';

class TodoListProvider {
  final _storageService = Get.find<StorageService>();

  List<TodoList> readTodoLists() {
    var todoLists = <TodoList>[];
    jsonDecode(_storageService.read(todoListKey).toString()).forEach(
          (e) => todoLists.add(TodoList.fromJson(e)),
    );
    return todoLists;
  }

  void writeTodoLists(List<TodoList> tasks) {
    _storageService.write(todoListKey, jsonEncode(tasks));
  }
}
