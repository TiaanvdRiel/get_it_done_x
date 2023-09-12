import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it_done_x/app/data/services/storage/services.dart';
import 'app/modules/home/view.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Get(It Done)X',
      home: HomePage(),
    );
  }
}