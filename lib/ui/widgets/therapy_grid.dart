import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../viewmodels/grid_vm.dart';
import 'color_dot.dart';

class TherapyGrid extends StatelessWidget {
  final GridVM vm = Get.find();

  TherapyGrid({super.key});

  @override
  Widget build(BuildContext context) {
    const int cols = 8;
    const double dotSize = 10;
    const double spacing = 18; // more spacing between dots

    return Obx(() => GridView.builder(
      itemCount: vm.dots.length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cols,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
      ),
      itemBuilder: (context, index) {
        final dot = vm.dots[index];
        return GestureDetector(
          onTap: () => vm.toggleSelect(dot.id),
          child: SizedBox(
            height: dotSize,
            width: dotSize,
            child: ColorDot(
              color: dot.selected ? dot.color : Colors.grey[300]!,
            ),
          ),
        );
      },
    ));
  }
}
