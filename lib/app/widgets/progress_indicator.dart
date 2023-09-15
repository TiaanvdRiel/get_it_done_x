import 'package:flutter/material.dart';
import 'package:get_it_done_x/app/core/utils/extensions.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../core/constants/colors.dart';

class TaskProgressIndicator extends StatelessWidget {
  final int totalTasks;
  final int completedTasks;

  const TaskProgressIndicator({super.key,
    required this.totalTasks,
    required this.completedTasks,
  });

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      animation: true,
      lineHeight: 1.0.hp,
      animationDuration: 2000,
      percent: (completedTasks == 0 ? 0 : completedTasks) /
          (totalTasks == 0 ? 1 : totalTasks),
      barRadius: const Radius.circular(100),
      progressColor: yellow,
      backgroundColor: Colors.white,
    );
  }
}
