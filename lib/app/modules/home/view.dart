import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it_done_x/app/core/utils/extensions.dart';
import 'package:get_it_done_x/app/modules/home/widgets/add_list_modal.dart';
import 'package:get_it_done_x/app/modules/home/widgets/list_card.dart';

import '../../core/constants/colors.dart';
import 'controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
          child: ListView(
            children: [
               Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Image(image: const AssetImage('assets/images/logo.png'), height: 13.0.hp,),
                 ],
               ),
              Text(
                "My Lists",
                style: TextStyle(
                  color: labelColor,
                  fontSize: 15.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Obx(
                () => ListView.builder(
                  itemCount: controller.todoLists.length,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final task = controller.todoLists[index];
                    return Dismissible(
                      key: ObjectKey(task),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) => controller.deleteTodoList(task),
                      background: Container(
                        alignment: Alignment.centerRight,
                        color: Colors.red,
                        child: Padding(
                          padding: EdgeInsets.only(right: 6.0.wp),
                          child: const Icon(
                            CupertinoIcons.trash,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      child: ListCard(task: task),
                    );
                  },
                ),
              ),
              //AddCard()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.bottomSheet(
            AddList(),
            backgroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          );
          controller.editController.clear();
        },
        backgroundColor: yellow,
        child: const Icon(
          CupertinoIcons.add,
        ),
      ),
    );
  }
}
