import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it_done_x/app/core/utils/extensions.dart';
import 'package:get_it_done_x/app/modules/home/widgets/add_card.dart';
import 'package:get_it_done_x/app/modules/home/widgets/task_card.dart';
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
                  ...controller.tasks.map((element) => TaskCard(task: element)).toList(),
                  TaskCard(task: const Task(title: 'title', icon: 0xe59c, color: '#ffffffff')),
                  AddCard()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
