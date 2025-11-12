import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../routes.dart';
import '../../../viewmodels/grid_vm.dart';
import '../widgets/app_button.dart';
import '../widgets/color_dot.dart';

class SessionControlScreen extends StatelessWidget {
  SessionControlScreen({super.key});
  final GridVM vm = Get.find();

  @override
  Widget build(BuildContext context) {
    const int rows = 8;
    const int cols = 8;
    const double dotSize = 10;
    const double spacing = 48;


    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Get.back(),
            child: Icon(Icons.arrow_back_ios)),
        title:Text('Session Control',style: GoogleFonts.mulish(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w700),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 15,left: 15,bottom: 10),
        child: Column(
          children: [
             Text(
              'Review your grid setup before starting the visual therapy session.',
              textAlign: TextAlign.center,
              style: GoogleFonts.mulish(color: Color(0xFF6C6C6C),fontSize: 14,fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Align(
                alignment: Alignment.center, // ✅ Moves grid upward
                child: Obx(() {
                  final double gridWidth = (cols * 10) + ((cols - 1) * spacing);
                  final double gridHeight = (rows * 10) + ((rows - 1) * spacing);

                  return Padding(
                    padding: const EdgeInsets.only(top: 10), // ✅ Reduced top spacing
                    child: SizedBox(
                      width: gridWidth,
                      height: gridHeight,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // ✅ Cross lines (centered)
                          CustomPaint(
                            size: Size(gridWidth, gridHeight),
                            painter: _CrossLinesPainter(),
                          ),

                          // ✅ Grid dots
                          GridView.builder(
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
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
            AppButton(
              label: 'Start Blinking',
              style: AppButtonStyle.primaryBlue,
              onTap: () => Get.toNamed(Routes.session),
            ),
            const SizedBox(height: 10),
            AppButton(
              label: 'Edit Dots',
              style: AppButtonStyle.primaryGreen,
              onTap: () => Get.toNamed(Routes.customize),
            ),
            const SizedBox(height: 10),
            AppButton(
              label: 'Settings',
              style: AppButtonStyle.neutral,
              onTap: () => Get.toNamed(Routes.settings),
            ),
            const SizedBox(height: 10),
            Text(
              'Review your grid setup before starting the visual therapy session.',
              textAlign: TextAlign.center,
              style: GoogleFonts.mulish(color: Color(0xFF6C6C6C),fontSize: 14,fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}


class _CrossLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.35)
      ..strokeWidth = 1.2;

    // vertical center line
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      paint,
    );

    // horizontal center line
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
