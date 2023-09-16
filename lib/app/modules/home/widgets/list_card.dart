import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it_done_x/app/core/constants/colors.dart';

import '../../../core/utils/extensions.dart';
import '../../../data/modules/todo_list.dart';
import '../../../widgets/progress_indicator.dart';
import '../../list_details/view.dart';
import '../controller.dart';

class ListCard extends StatelessWidget {
  ListCard({super.key, required this.todoList});
  final TodoList todoList;
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        homeController.changeTodoList(todoList);
        homeController.setListItems(todoList.listItems ?? []);
        Get.to(() => DetailPage());
      },
      child: Container(
        height: 14.0.hp,
        margin: EdgeInsets.only(top: 3.0.wp),
        decoration: const BoxDecoration(color: lightGrey, borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0.wp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todoList.title,
                    style: TextStyle(
                      fontSize: 16.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 2.0.wp,
                  ),
                  Row(
                    children: [
                      Text(
                        "${todoList.listItems?.length ?? 0} Items",
                        style: TextStyle(
                          fontSize: 11.0.sp,
                          fontWeight: FontWeight.bold,
                          color: labelColor,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "${homeController.isListEmpty(todoList) ? "0" : homeController.getDoneTodo(todoList)}/${homeController.isListEmpty(todoList) ? "0" : todoList.listItems!.length}",
                        style: TextStyle(
                          fontSize: 10.0.sp,
                          fontWeight: FontWeight.bold,
                          color: darkGrey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.0.wp,
                  ),
                  TaskProgressIndicator(
                    totalTasks:  todoList.listItems!.length,
                    completedTasks: homeController.getDoneTodo(todoList),

                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
