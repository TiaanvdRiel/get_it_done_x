import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it_done_x/app/core/utils/extensions.dart';
import '../../../core/values/colors.dart';
import '../../home/controller.dart';

class CompletedList extends StatelessWidget {
  CompletedList({super.key});
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeController.doneTodos.isNotEmpty
          ? ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.0.wp, vertical: 3.0.wp),
                  child: Text(
                    "Completed tasks (${homeController.doneTodos.length}):",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0.sp,
                    ),
                  ),
                ),
                ...homeController.doneTodos
                    .map(
                      (element) => Dismissible(
                        key: ObjectKey(element),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) => homeController.deleteDoneItem(element),
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
                              const SizedBox(
                                width: 20,
                                height: 20,
                                child: Icon(
                                  CupertinoIcons.checkmark_alt,
                                  color: Colors.green,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                                child: Text(
                                  element['title'],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey,
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
              ],
            )
          : Container(),
    );
  }
}
