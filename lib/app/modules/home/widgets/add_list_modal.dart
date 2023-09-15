import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it_done_x/app/core/utils/extensions.dart';
import '../../../core/values/colors.dart';
import '../../../data/modules/task.dart';
import '../../../widgets/icons.dart';
import '../controller.dart';


class AddList extends StatelessWidget {
  AddList({super.key});

  final homeController = Get.find<HomeController>(); //Define homeController

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    return Scaffold(
      //key: homeController.formKey,
      body: Form(
        key: homeController.formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close),
                  ),
                  TextButton(
                    onPressed: () {
                      if (homeController.formKey.currentState!.validate()) {
                        int icon = icons[homeController.iconChipIndex.value].icon!.codePoint;
                        String color = icons[homeController.iconChipIndex.value].color!.toHex();
                        //TODO: Need to remove icon and color here
                        var task = Task(
                          title: homeController.editController.text,
                          icon: icon,
                          color: color,
                        );
                        Get.back();
                        //TODO: Remove this easyLoading stuff and just use a toast
                        homeController.addTask(task) ? EasyLoading.showSuccess("Create success") : EasyLoading.showError("Task duplicated");
                      }
                    },
                    style: const ButtonStyle(
                      overlayColor: MaterialStatePropertyAll(Colors.transparent),
                    ),
                    child: Text(
                      "Done",
                      style: TextStyle(fontSize: 14.0.sp),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: Text(
                "Create List",
                style: TextStyle(
                  fontSize: 20.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: TextFormField(
                controller: homeController.editController,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[400]!,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please give your list a name.';
                  }
                  return null;
                },
              ),
            ),
            //TODO: remove all this icon nonsense
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0.wp),
              child: Wrap(
                spacing: 2.0.wp,
                children: icons
                    .map(
                      (elem) => Obx(() {
                        final index = icons.indexOf(elem);
                        return ChoiceChip(
                          backgroundColor: Colors.white,
                          selectedColor: Colors.grey.shade200,
                          pressElevation: 0,
                          label: elem,
                          selected: homeController.iconChipIndex.value == index,
                          onSelected: (bool selected) {
                            homeController.iconChipIndex.value = selected ? index : 0;
                          },
                        );
                      }),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
