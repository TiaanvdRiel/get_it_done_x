import 'package:get/get.dart';

import '../../data/providers/task/provider.dart';
import '../../data/services/storage/repository.dart';
import 'controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
          () => HomeController(
        taskRepository: TodoListRepository(
          todoListProvider: TodoListProvider(),
        ),
      ),
    );
  }
}
