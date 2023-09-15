import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it_done_x/app/modules/list_details/widgets/doing_list.dart';
import 'package:get_it_done_x/app/modules/list_details/widgets/done_list.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../../core/utils/extensions.dart';
import '../../core/values/colors.dart';
import '../home/controller.dart';
import '../home/widgets/add_dialogue.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key});

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    var task = homeController.task.value;
    var color = HexColor.fromHex(task!.color);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Form(
          key: homeController.formKey,
          child: ListView(
            children: [
              //TODO: Back button
              Padding(
                padding: EdgeInsets.all(2.0.wp),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        homeController.updateTodos(); //TODO: I really don't know if I need this?
                        homeController.changeTask(null); //TODO: This I do need though
                        homeController.editController.clear();
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ],
                ),
              ),
              //TODO: List name and icon
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
                child: Row(
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 22.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              //TODO: Progress indicator
              Obx(() {
                var totalTasks = homeController.doingTodos.length + homeController.doneTodos.length;
                return Padding(
                  padding: EdgeInsets.only(left: 8.0.wp, right: 8.0.wp, top: 3.0.wp),
                  child: SizedBox(
                    height: 5.0.hp,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$totalTasks Task",
                          style: TextStyle(color: Colors.grey, fontSize: 12.0.sp),
                        ),
                        SizedBox(
                          width: 3.0.wp,
                        ),
                        Expanded(
                          child: StepProgressIndicator(
                            totalSteps: totalTasks == 0 ? 1 : totalTasks,
                            currentStep: homeController.doneTodos.length,
                            size: 5,
                            padding: 0,
                            selectedGradientColor: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                color.withOpacity(.5),
                                color,
                              ],
                            ),
                            unselectedGradientColor: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.grey[300]!,
                                Colors.grey[300]!,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              //TODO: This is for "doing todos"? I guess just remove all of this nonsense
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0.wp, vertical: 2.0.wp),
                child: TextFormField(
                  controller: homeController.editController,
                  autofocus: true,
                  validator: (value) {
                    if (value!.isEmpty || value.trim().isEmpty) {
                      return 'Please enter your todo item.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[300]!,
                        width: 1,
                      ),
                    ),
                    prefixIcon: const Icon(CupertinoIcons.circle, color: Colors.grey),
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (homeController.formKey.currentState!.validate()) {
                          var success = homeController.addTodo(homeController.editController.text);
                          if (success) {
                            EasyLoading.showSuccess("Todo item add success");
                          } else {
                            EasyLoading.showError('Todo item is already exist');
                          }
                          homeController.editController.clear();
                        }
                      },
                      icon: const Icon(
                        CupertinoIcons.checkmark_alt,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
              DoingList(),
              DoneList(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.bottomSheet(
            //AddDialog(),
            //Text('Test'),
            WillPopScope(
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
                                  if (homeController.task.value == null) {
                                    //TODO: validating that task type is selected - probably don't need
                                    EasyLoading.showError("Please select task type.");
                                  } else {
                                    var success = homeController.updateTask(
                                      homeController.task.value!,
                                      //TODO:I don't need this I think, so what this is doing is setting the element to task.value, I can just give this the element directly
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
                    ],
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          backgroundColor: yellow,
          child: const Icon(
            CupertinoIcons.add,
          ),
        ),
      ),
    );
  }
}
