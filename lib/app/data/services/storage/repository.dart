import '../../modules/todo_list.dart';
import '../../providers/task/provider.dart';

class TodoListRepository {
  TodoListProvider todoListProvider;
  TodoListRepository({required this.todoListProvider});

  List<TodoList> readTasks() => todoListProvider.readTodoLists();
  void writeTasks(List<TodoList> tasks) => todoListProvider.writeTodoLists(tasks);
}
