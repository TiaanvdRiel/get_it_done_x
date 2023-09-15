import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/modules/todo_list.dart';
import '../../data/services/storage/repository.dart';

class HomeController extends GetxController {
  TodoListRepository taskRepository;
  HomeController({required this.taskRepository});

  final formKey = GlobalKey<FormState>();
  final editController = TextEditingController();
  final todoLists = <TodoList>[].obs;
  final todoList = Rx<TodoList?>(null);
  final todoItems = [].obs;
  final completedItems = [].obs;

  @override
  void onInit() {
    super.onInit();
    todoLists.assignAll(taskRepository.readTasks());
    ever(todoLists, (_) => taskRepository.writeTasks(todoLists));
  }

  @override
  void onClose() {
    editController.dispose();
    super.onClose();
  }

  void deleteTodoList(TodoList todoList) {
    todoLists.remove(todoList);
  }

  void changeTodoList(TodoList? select) {
    todoList.value = select;
  }

  updateTodoList(TodoList todoList, String title) {
    var todoListItems = todoList.listItems ?? [];
    if (containsItem(todoListItems, title)) return false;
    var item = {'title': title, 'done': false};
    todoListItems.add(item);
    var newTodoList = todoList.copyWith(listItems: todoListItems);
    int oldIndex = todoLists.indexOf(todoList);
    todoLists[oldIndex] = newTodoList;
    todoLists.refresh();
    return true;
  }

  bool createTodoList(TodoList todoList) {
    if (todoLists.contains(todoList)) {
      return false;
    }
    todoLists.add(todoList);
    return true;
  }

  bool containsItem(List todoListItems, title) {
    return todoListItems.any((element) => element['title'] == title);
  }

  void setListItems(List<dynamic> select) {
    todoItems.clear();
    completedItems.clear();
    for (var i = 0; i < select.length; i++) {
      var listItem = select[i];
      var status = listItem['done'];
      if (status == true) {
        completedItems.add(listItem);
      } else {
        todoItems.add(listItem);
      }
    }
  }

  bool addListItem(String title) {
    var todoItem = {'title': title, 'done': false};
    if (todoItems.any((element) => mapEquals<String, dynamic>(todoItem, element))) {
      return false;
    }
    if (completedItems.any((element) => mapEquals<String, dynamic>(todoItem, element))) {
      return false;
    }
    todoItems.add(todoItem);
    return true;
  }

  void updateListItems() {
    if (todoList.value != null) {
      var newListItems = <Map<String, dynamic>>[];
      newListItems.addAll([...todoItems, ...completedItems]);
      var newTodoList = todoList.value!.copyWith(listItems: newListItems);
      int oldIndex = todoLists.indexOf(todoList.value);
      todoLists[oldIndex] = newTodoList;
    }
    todoLists.refresh();
  }

  void completeListItem(String title) {
    var listItem = {'title': title, 'done': false};
    int index = todoItems.indexWhere((element) => mapEquals<String, dynamic>(listItem, element));
    todoItems.removeAt(index);
    var doneTodo = {'title': title, 'done': true};
    completedItems.add(doneTodo);
    completedItems.refresh();
    todoItems.refresh();
  }

  void deleteCompletedItem(completedItem) {
    int index = completedItems.indexWhere((element) => mapEquals(completedItem, element));
    completedItems.removeAt(index);
    completedItems.refresh();
  }
  
  void deleteListItem(todoItems) {
    int index = todoItems.indexWhere((element) => mapEquals(todoItems, element));
    todoItems.removeAt(index);
    todoItems.refresh();
  }

  bool isListEmpty(TodoList list) {
    return list.listItems == null || list.listItems!.isEmpty;
  }

  int getDoneTodo(TodoList list) {
    int res = 0;
    for (int i = 0; i < list.listItems!.length; i++) {
      if (list.listItems![i]['done'] == true) {
        res++;
      }
    }
    return res;
  }
}
