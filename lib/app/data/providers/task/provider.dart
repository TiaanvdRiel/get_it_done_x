import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_it_done_x/app/data/services/storage/services.dart';
import '../../../core/utils/keys.dart';
import '../../modules/task.dart';


//TODO Rename all of these tasks to lists
class TaskProvider {
  final _storageService = Get.find<StorageService>();

  List<Task> readTasks() {
    var tasks = <Task>[];
    jsonDecode(_storageService.read(taskKey).toString()).forEach(
          (e) => tasks.add(Task.fromJson(e)),
    );
    return tasks;
  }

  //TODO change this to createList or createTodoList or something
  void writeTasks(List<Task> tasks) {
    _storageService.write(taskKey, jsonEncode(tasks));
  }
}
