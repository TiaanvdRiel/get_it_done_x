import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it_done_x/app/core/utils/extensions.dart';

import '../../../core/constants/colors.dart';
import '../../../widgets/show_toast.dart';
import '../../home/controller.dart';

class AddListItem extends StatelessWidget {
  AddListItem({super.key});

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                      homeController.editController.clear();
                      homeController.changeTodoList(null);
                    },
                    icon: const Icon(Icons.close),
                  ),
                  TextButton(
                    onPressed: () {
                      if (homeController.formKey.currentState!.validate()) {
                        showToastMessage(
                          homeController.addListItem(homeController.editController.text) ? "Todo item added!" : "Todo item is already exist.",
                        );
                        homeController.editController.clear();
                        Get.back();
                      }
                    },
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
                "New Item",
                style: TextStyle(
                  fontSize: 20.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: TextFormField(
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: lightGrey,
                    ),
                  ),
                ),
                controller: homeController.editController,
                autofocus: true,
                validator: (value) {
                  if (value!.isEmpty || value.trim().isEmpty) {
                    return 'Please enter your todo item.';
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
