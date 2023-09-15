import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it_done_x/app/modules/list_details/widgets/completed_list.dart';
import 'package:get_it_done_x/app/modules/list_details/widgets/todo_list.dart';

import '../../core/constants/colors.dart';
import '../../core/utils/extensions.dart';
import '../../widgets/progress_indicator.dart';
import '../home/controller.dart';
import 'widgets/add_list_item_modal.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key});

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    var task = homeController.todoList.value;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Form(
          key: homeController.formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(2.0.wp),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        homeController.updateListItems();
                        homeController.changeTodoList(null);
                        homeController.editController.clear();
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
                child: Row(
                  children: [
                    Text(
                      task!.title,
                      style: TextStyle(
                        fontSize: 22.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3.0.wp),
              Obx(() {
                var totalTasks = homeController.todoItems.length + homeController.completedItems.length;
                var completedTasks = homeController.completedItems.length;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
                  child: SizedBox(
                    height: 5.0.hp,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$totalTasks Task",
                          style: TextStyle(color: darkGrey, fontSize: 12.0.sp),
                        ),
                        SizedBox(
                          width: 3.0.wp,
                        ),
                        Expanded(
                          child: TaskProgressIndicator(
                            totalTasks: totalTasks,
                            completedTasks: completedTasks,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              TodoList(),
              CompletedList(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.bottomSheet(
            AddListItem(),
            backgroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          backgroundColor: yellow,
          child: const Icon(
            CupertinoIcons.add,
          ),
        ),
      ),
    );
  }
}
