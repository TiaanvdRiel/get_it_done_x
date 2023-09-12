import '../../modules/task.dart';
import '../../providers/task/provider.dart';

class TaskRepository {
  TaskProvider taskProvider;
  TaskRepository({required this.taskProvider});

  //TODO update the names of these methods as well
  //TODO also rename everything called "Task"
  List<Task> readTasks() => taskProvider.readTasks();
  void writeTasks(List<Task> tasks) => taskProvider.writeTasks(tasks);
}
