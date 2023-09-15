import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it_done_x/app/core/values/colors.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../../../core/utils/extensions.dart';
import '../../../data/modules/task.dart';
import '../../list_details/view.dart';
import '../controller.dart';

class ListCard extends StatelessWidget {
  ListCard({super.key, required this.task});

  final Task task;
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        homeController.changeTask(task); //TODO: Pass the list to the details page
        homeController.changeTodos(task.todos ?? []); //TODO: Pass the listItems to the details page
        Get.to(() => DetailPage());
      },
      child: Container(
        height: 14.0.hp,
        margin: EdgeInsets.only(top: 3.0.wp),
        decoration: const BoxDecoration(color: grey, borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //TODO: This is the list's name
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
                        "${task.todos?.length ?? 0} Tasks",
                        style: TextStyle(
                          fontSize: 11.0.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "${homeController.isTodosEmpty(task) ? "0" : homeController.getDoneTodo(task)}/${homeController.isTodosEmpty(task) ? "0" : task.todos!.length}",
                        style: TextStyle(
                          fontSize: 10.0.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.0.wp,
                  ),
                  //TODO: Change this to my own linearProgressIndicator
                  StepProgressIndicator(
                    totalSteps: homeController.isTodosEmpty(task) ? 1 : task.todos!.length,
                    currentStep: homeController.isTodosEmpty(task) ? 0 : homeController.getDoneTodo(task),
                    size: 10,
                    padding: 0,
                    selectedGradientColor: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [yellow, yellow],
                    ),
                    unselectedGradientColor: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.white, Colors.white],
                    ),
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
