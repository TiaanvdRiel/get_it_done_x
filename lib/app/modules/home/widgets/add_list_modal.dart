import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it_done_x/app/core/utils/extensions.dart';

import '../../../core/constants/colors.dart';
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
                        Fluttertoast.showToast(
                          msg: homeController.createTodoList(task) ? "List created!" : "List duplicated",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.SNACKBAR,
                          backgroundColor: green,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
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
                      color: lightGrey,
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
