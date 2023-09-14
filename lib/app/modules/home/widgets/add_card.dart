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

//TODO: I suppose this will need to be like a floatign action button right?
class AddCard extends StatelessWidget {
  AddCard({super.key});

  final homeController = Get.find<HomeController>(); //Define homeController

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    return Container(
      margin: EdgeInsets.all(3.0.wp),
      child: GestureDetector(
        onTap: () async {
          await Get.bottomSheet(
            backgroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            // child:
            Form(
              key: homeController.formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                    child: TextFormField(
                      controller: homeController.editController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title',
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
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0.wp),
                    child: CupertinoButton.filled(
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
                      child: const Text("Create List"),
                    ),
                  ),
                ],
              ),
            ),
          );
          homeController.editController.clear();
          //TODO: remove this
          homeController.iconChipIndex.value = 0;
        },
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: const [8, 4],
          child: Center(
            child: Icon(
              Icons.add,
              size: 10.0.wp,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
