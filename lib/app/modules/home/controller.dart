import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/modules/task.dart';
import '../../data/services/storage/repository.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;

  HomeController({required this.taskRepository});

  final formKey = GlobalKey<FormState>();
  final editController = TextEditingController();
  final iconChipIndex = 0.obs; //TODO this is the chip index for the icon -> remove this
  final deleting = false.obs; //TODO delete task
  final tasks = <Task>[].obs; // TODO this .obs means observable -> whenever they change, redraw the page
  final task = Rx<Task?>(null); //TODO this is the todoListItem, NO this should be selected list, but I still think I can get rid of this
  final doingTodos = [].obs; //inProgressItems
  final doneTodos = [].obs; //completedListItems
  final tabIdx = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks)); //TODO if ever a task changes we write the task
  }

  @override
  void onClose() {
    editController.dispose();
    super.onClose();
  }

  void changeCheapIdx(int value) {
    iconChipIndex.value = value;
  }

  void changeTabIdx(int value) {
    tabIdx.value = value;
  }

  void changeDeleting(bool val) {
    deleting.value = val;
  }

  //TODO: call this deleteTodoList
  void deleteTask(Task task) {
    tasks.remove(task);
  }

  void changeTask(Task? select) {
    task.value = select;
  }

  //updateTodoList
  updateTask(Task todoList, String title) {
    var todoListItems = todoList.todos ?? []; //var todoListItems = todoList.todoListItems
    if (containsItem(todoListItems, title)) return false;
    var item = {'title': title, 'done': false}; //var item = {'title: title, 'done': false}
    todoListItems.add(item); // todoListItems.add(item)
    var newTask = todoList.copyWith(todos: todoListItems); //var newTodoList = todoList.copyWith(todoListItems: todoListItems)
    int oldIndex = tasks.indexOf(todoList); // int oldIndex = todoLists.indexOf(todoList)
    tasks[oldIndex] = newTask; //todoLists[oldIndex] = newTodoList
    tasks.refresh(); //todoLists.refresh()
    return true;
  }

  //createTodoList
  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }

  //containsItem
  bool containsItem(List todoListItems, title) {
    return todoListItems.any((element) => element['title'] == title);
  }

  //setListItems
  void changeTodos(List<dynamic> select) {
    doingTodos.clear();
    doneTodos.clear();
    for (var i = 0; i < select.length; i++) {
      var listItem = select[i];
      var status = listItem['done'];
      if (status == true) {
        doneTodos.add(listItem);
      } else {
        doingTodos.add(listItem);
      }
    }
  }

  //TODO: Do I need this? Probably not huh
  //add a list item
  bool addTodo(String title) {
    var todoDoing = {'title': title, 'done': false};
    var todoDone = {'title': title, 'done': false};
    //TODO: this just checks if it already exists
    if (doingTodos.any((element) => mapEquals<String, dynamic>(todoDoing, element))) {
      return false;
    }
    if (doneTodos.any((element) => mapEquals<String, dynamic>(todoDone, element))) {
      return false;
    }
    doingTodos.add(todoDoing);
    return true;
  }

  //TODO: Update the list of items
  void updateTodos() {
    var newListItems = <Map<String, dynamic>>[];
    newListItems.addAll([...doingTodos, ...doneTodos]);
    var newTodoList = task.value!.copyWith(todos: newListItems);
    int oldIndex = tasks.indexOf(task.value);
    tasks[oldIndex] = newTodoList;
    tasks.refresh();
  }

  //TODO: completeListItem
  void doneTodo(String title) {
    var doingTodo = {'title': title, 'done': false};
    int index = doingTodos.indexWhere((element) => mapEquals<String, dynamic>(doingTodo, element));
    doingTodos.removeAt(index);
    var doneTodo = {'title': title, 'done': true};
    doneTodos.add(doneTodo);
    doneTodos.refresh();
    doingTodos.refresh();
  }

  //TODO: deleteCompletedItem
  void deleteDoneItem(doneTodo) {
    int index = doneTodos.indexWhere((element) => mapEquals(doneTodo, element));
    doneTodos.removeAt(index);
    doneTodos.refresh();
  }


  //TODO: deleteCompletedItem
  void deleteTodoItem(doingTodo) {
    int index = doingTodos.indexWhere((element) => mapEquals(doingTodo, element));
    doingTodos.removeAt(index);
    doingTodos.refresh();
  }

  //TODO: isListEmpty
  bool isTodosEmpty(Task task) {
    return task.todos == null || task.todos!.isEmpty;
  }

  int getDoneTodo(Task task) {
    int res = 0;
    for (int i = 0; i < task.todos!.length; i++) {
      if (task.todos![i]['done'] == true) {
        res++;
      }
    }
    return res;
  }

  int getTotalTasks() {
    int res = 0;
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].todos != null) {
        res += tasks[i].todos!.length;
      }
    }
    return res;
  }

  int getTotalDoneTask() {
    int res = 0;
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].todos != null) {
        for (var j = 0; j < tasks[i].todos!.length; j++) {
          if (tasks[i].todos![j]['done'] == true) {
            res += 1;
          }
        }
      }
    }
    return res;
  }
}
