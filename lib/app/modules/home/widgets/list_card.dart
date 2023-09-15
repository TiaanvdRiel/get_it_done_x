import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it_done_x/app/core/constants/colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../core/utils/extensions.dart';
import '../../../data/modules/todo_list.dart';
import '../../list_details/view.dart';
import '../controller.dart';

class ListCard extends StatelessWidget {
  ListCard({super.key, required this.task});
  final TodoList task;
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        homeController.changeTodoList(task); //TODO: Pass the list to the details page
        homeController.setListItems(task.listItems ?? []); //TODO: Pass the listItems to the details page
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
                    task.title,
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
                        "${task.listItems?.length ?? 0} Tasks",
                        style: TextStyle(
                          fontSize: 11.0.sp,
                          fontWeight: FontWeight.bold,
                          color: labelColor,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "${homeController.isListEmpty(task) ? "0" : homeController.getDoneTodo(task)}/${homeController.isListEmpty(task) ? "0" : task.listItems!.length}",
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
                 LinearPercentIndicator(
                    animation: true,
                    lineHeight: 1.0.hp,
                    animationDuration: 2000,
                    percent: (homeController.isListEmpty(task) ? 0 : homeController.getDoneTodo(task)) /
                        (homeController.isListEmpty(task) ? 1 : task.listItems!.length),
                    barRadius: Radius.circular(1.0.hp),
                    progressColor: yellow,
                    backgroundColor: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
