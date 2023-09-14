import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it_done_x/app/core/utils/extensions.dart';
import '../controller.dart';

//TODO: I beleive that this adds ListItems to our TodoList
class AddDialog extends StatelessWidget {
  AddDialog({super.key});

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Form(
          key: homeController.formKey,
          child: ListView(
            children: [
              //TODO: Top Row
              Padding(
                padding: EdgeInsets.all(3.0.wp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                        homeController.editController.clear();
                        homeController.changeTask(null);
                      },
                      icon: const Icon(Icons.close),
                    ),
                    TextButton(
                      onPressed: () {
                        if (homeController.formKey.currentState!.validate()) {
                          if (homeController.task.value == null) { //TODO: validating that task type is selected - probably don't need
                            EasyLoading.showError("Please select task type.");
                          } else {
                            var success = homeController.updateTask(
                              homeController.task.value!, //TODO:I don't need this I think, so what this is doing is setting the element to task.value, I can just give this the element directly
                              homeController.editController.text,
                            );
                            if (success) {
                              EasyLoading.showSuccess("Add Todo item success");
                            } else {
                              EasyLoading.showError("Todo item is already exist.");
                            }
                          }
                          homeController.editController.clear();
                          Get.back();
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
              //TODO: New Task
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
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                      ),
                    ),
                  ),
                  controller: homeController.editController,
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your task here.';
                    }
                    return null;
                  },
                ),
              ),
              //TODO: Remove this label
              Padding(
                padding: EdgeInsets.only(top: 5.0.wp, left: 5.0.wp, right: 5.0.wp, bottom: 2.0.wp),
                child: Text(
                  "Add to:",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0.sp,
                  ),
                ),
              ),
              //TODO: Remove this map method - unnecessary
              ...homeController.tasks
                  .map((element) => Obx(
                        () => InkWell(
                          //TODO: I guess this is how you add the element
                          onTap: () => homeController.changeTask(element), //TODO: set the list that we want to add the item to
                          //TODO: I think that we can just like... when you press the plus button from the page, do this same thing, and then use the rest of the logic
                          //probably change it to homeController.selectTodoList(element)
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 3.0.wp,
                              horizontal: 5.0.wp,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      IconData(element.icon, fontFamily: 'MaterialIcons'),
                                      color: HexColor.fromHex(element.color),
                                    ),
                                    SizedBox(
                                      width: 3.0.wp,
                                    ),
                                    Text(
                                      element.title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                if (homeController.task.value == element)
                                  const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
