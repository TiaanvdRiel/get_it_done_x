import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it_done_x/app/core/constants/colors.dart';
import 'package:get_it_done_x/app/core/utils/extensions.dart';

import '../../home/controller.dart';

class TodoList extends StatelessWidget {
  TodoList({super.key});
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeController.todoItems.isEmpty && homeController.completedItems.isEmpty
          ? SizedBox(
              height: 20.0.hp,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No items in this list :(",
                    style: TextStyle(
                      color:labelColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 12.0.sp,
                    ),
                  ),
                ],
              ),
            )
          : ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                homeController.todoItems.isNotEmpty ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.0.wp, vertical: 3.0.wp),
                  child: Text(
                    "Tasks Todo (${homeController.todoItems.length}):",
                    style: TextStyle(
                      color: labelColor,
                      fontSize: 14.0.sp,
                    ),
                  ),
                ) : Container(),
                ...homeController.todoItems
                    .map(
                      (element) => Dismissible(
                        key: ObjectKey(element),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) => homeController.deleteListItem(element),
                        background: Container(
                          color: Colors.red.withOpacity(.8),
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 6.0.wp),
                            child: const Icon(
                              CupertinoIcons.trash,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 9.0.wp, vertical: 3.0.wp),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: Checkbox(
                                  fillColor: MaterialStateProperty.resolveWith((states) => Colors.white),
                                  value: element['done'],
                                  shape: const CircleBorder(),
                                  side: const BorderSide(width: 1.5, color: Colors.grey),
                                  onChanged: (value) {
                                    homeController.completeListItem(element['title']);
                                    homeController.completedItems.refresh();
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                                child: Text(
                                  element['title'],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: labelColor,
                                    fontSize: 12.0.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
                if (homeController.completedItems.isNotEmpty && homeController.todoItems.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.0.wp),
                    child: const Divider(thickness: 1),
                  ),
              ],
            ),
    );
  }
}
