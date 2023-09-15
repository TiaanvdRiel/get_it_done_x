import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it_done_x/app/core/utils/extensions.dart';
import '../../home/controller.dart';

class DoingList extends StatelessWidget {
  DoingList({super.key});

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeController.doingTodos.isEmpty && homeController.doneTodos.isEmpty
          ? SizedBox(
              height: 20.0.hp,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No items in this list :(",
                    style: TextStyle(
                      color: Colors.black,
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
                homeController.doingTodos.isNotEmpty ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.0.wp, vertical: 3.0.wp),
                  child: Text(
                    "My tasks (${homeController.doingTodos.length}):",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0.sp,
                    ),
                  ),
                ) : Container(),
                ...homeController.doingTodos
                    .map(
                      (element) => Dismissible(
                        key: ObjectKey(element),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) => homeController.deleteTodoItem(element),
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
                                    homeController.doneTodo(element['title']);
                                    homeController.doneTodos.refresh();
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                                child: Text(
                                  element['title'],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black,
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
                if (homeController.doneTodos.isNotEmpty && homeController.doingTodos.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.0.wp),
                    child: const Divider(thickness: 1),
                  ),
              ],
            ),
    );
  }
}
