import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it_done_x/app/core/utils/extensions.dart';
import '../../../data/modules/todo_list.dart';
import '../controller.dart';


class AddList extends StatelessWidget {
  AddList({super.key});
  final homeController = Get.find<HomeController>(); //Define homeController

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        var task = TodoList(
                          title: homeController.editController.text,
                        );
                        Get.back();
                        //TODO: Remove this easyLoading stuff and just use a toast
                        homeController.createTodoList(task) ? EasyLoading.showSuccess("Create success") : EasyLoading.showError("Task duplicated");
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
          ],
        ),
      ),
    );
  }
}
