import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it_done_x/app/core/utils/extensions.dart';
import 'package:get_it_done_x/app/modules/home/widgets/add_card.dart';
import 'package:get_it_done_x/app/modules/home/widgets/add_list_item_modal.dart';
import 'package:get_it_done_x/app/modules/home/widgets/list_card.dart';
import '../../core/values/colors.dart';
import '../../data/modules/task.dart';
import 'controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            //TODO change out with Image
            Padding(
              padding: EdgeInsets.only(left: 4.0.wp),
              child: Text(
                "My Lists",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Obx(
              () => ListView.builder(
                itemCount: controller.tasks.length,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  final task = controller.tasks[index];
                  return Dismissible(
                    key: Key(task.title.toString()), // Provide a unique key for each item.
                    onDismissed: (_) {
                      // Handle item dismissal here, e.g., remove the item from the list.
                      //controller.removeTask(task);
                    },
                    background: Container(
                      alignment: Alignment.centerRight,
                      color: Colors.red,
                      child: const Icon(CupertinoIcons.trash, color: Colors.white),
                    ),
                    child: ListCard(task: task),
                  );
                },
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
                        child: ListCard(task: element),
                      ),
                      child: ListCard(task: element),
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
      floatingActionButton: DragTarget<Task>(
        builder: (_, __, ___) {
          return Obx(
            () => FloatingActionButton(
              onPressed: () => Get.to(() => AddListItem(), transition: Transition.downToUp),
              backgroundColor: controller.deleting.value ? Colors.red : yellow,
              child: Icon(
                controller.deleting.value ? Icons.delete : CupertinoIcons.add,
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
