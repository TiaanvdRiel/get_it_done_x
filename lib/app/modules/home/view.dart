import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it_done_x/app/core/utils/extensions.dart';
import 'package:get_it_done_x/app/modules/home/widgets/add_card.dart';
import 'package:get_it_done_x/app/modules/home/widgets/add_dialogue.dart';
import 'package:get_it_done_x/app/modules/home/widgets/task_card.dart';
import '../../core/values/colors.dart';
import '../../data/modules/task.dart';
import 'controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            //TODO change out with Image
            Padding(
              padding: EdgeInsets.all(4.0.wp),
              child: Text(
                "My Lists",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // TODO: Wrap with observable
            Obx(
              () => GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  //TODO: maybe I can change this to somehow being a swiping to delete
                  //TODO: I DONT NEED THIS changeDeleting thing -> all it does is just change the icon
                  ...controller.tasks.map(
                    (element) => LongPressDraggable(
                      data: element,
                      //TODO: this is where you pass it the task object
                      onDragStarted: () => controller.changeDeleting(true),
                      onDraggableCanceled: (_, __) => controller.changeDeleting(false),
                      onDragEnd: (_) => controller.changeDeleting(false),
                      feedback: Opacity(
                        opacity: 0.8,
                        child: TaskCard(task: element),
                      ),
                      child: TaskCard(task: element),
                    ),
                  ),
                  AddCard()
                ],
              ),
            )
          ],
        ),
      ),
      //TODO: Just remove this entire damn thing almost none of this is necessary
      floatingActionButton: DragTarget<Task>(builder: (_, __, ___) {
        return Obx(
          () => FloatingActionButton(
            onPressed: () => Get.to(() => AddDialog(), transition: Transition.downToUp),
            backgroundColor: controller.deleting.value ? Colors.red : blue,
            child: Icon(
              controller.deleting.value ? Icons.delete : Icons.add,
            ),
          ),
        );
      },
      onAccept: (Task task) {
        controller.deleteTask(task); //TODO: this will have to be moved to a showmodal thing I think -> pass the modal the todoList  (task)
        },
      ),
    );
  }
}
