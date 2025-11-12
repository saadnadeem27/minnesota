import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../viewmodels/grid_vm.dart';
import '../widgets/app_button.dart';
import '../widgets/color_dot.dart';

class TherapyModeScreen extends StatelessWidget {
  TherapyModeScreen({super.key});
  final GridVM vm = Get.find();

  @override
  Widget build(BuildContext context) {
    const int rows = 8;
    const int cols = 8;
    const double dotSize = 12;
    const double spacing = 48;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: Column(
            children: [
              Text('Therapy Mode',style: GoogleFonts.mulish(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w700),),
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
                label: 'End Session',
                style: AppButtonStyle.dangerRed,
                onTap: () => Get.back(),
              ),
              const SizedBox(height: 20),
              Text(
                'Ensure your device is at eye level and you are seated comfortably before starting',
                textAlign: TextAlign.center,
                style: GoogleFonts.mulish(color: Color(0xFF6C6C6C),fontSize: 14,fontWeight: FontWeight.w500),
              ),
            ],
          ),
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
