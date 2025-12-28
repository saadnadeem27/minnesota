import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../routes.dart';
import '../../../viewmodels/grid_vm.dart';
import '../widgets/app_button.dart';
import '../widgets/color_dot.dart';

class SessionControlScreen extends StatelessWidget {
  SessionControlScreen({super.key});

  final GridVM vm = Get.find(); // backend controller

  @override
  Widget build(BuildContext context) {
    const int rows = 9;
    const int cols = 8;

    const double dotSize = 12;
    const double spacing = 35;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Session Control',
          style: GoogleFonts.mulish(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.only(right: 15, left: 15, bottom: 10),
        child: Column(
          children: [
            Text(
              'Review your grid setup before starting the visual therapy session.',
              textAlign: TextAlign.center,
              style: GoogleFonts.mulish(
                color: Color(0xFF6C6C6C),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Obx(() {
                  final double gridWidth =
                      (cols * dotSize) + ((cols - 1) * spacing);
                  final double gridHeight =
                      (rows * dotSize) + ((rows - 1) * spacing);

                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                      width: gridWidth,
                      height: gridHeight,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          /// -----------------------------------------
                          /// CENTER LINES ADDED (NO UI CHANGE)
                          /// -----------------------------------------
                          CustomPaint(
                            size: Size(gridWidth, gridHeight),
                            painter: _CrossLinesPainter(),
                          ),

                          /// DOT GRID
                          GridView.builder(
                            itemCount: vm.dots.length,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: cols,
                              crossAxisSpacing: spacing,
                              mainAxisSpacing: spacing,
                            ),
                            itemBuilder: (context, index) {
                              final dot = vm.dots[index];

                              return GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () => vm.toggleSelect(dot.id),
                                child: SizedBox(
                                  width: spacing,
                                  height: spacing,
                                  child: Center(
                                    child: ColorDot(
                                      color: dot.selected
                                          ? dot.color
                                          : Colors.grey[300]!,
                                      visible: dot.visible,
                                      brightness: dot.brightness,
                                      size: dotSize,
                                    ),
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

            Text(
              'Review your grid setup before starting the visual therapy session.',
              textAlign: TextAlign.center,
              style: GoogleFonts.mulish(
                color: Color(0xFF6C6C6C),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------
///  PERFECT CENTER LINES (No overlap on dots)
/// ---------------------------------------------------------
class _CrossLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.35)
      ..strokeWidth = 1.2;

    // --------- CONSTANTS (same as screen) ----------
    const double dotSize = 12;
    const double spacing = 35;
    const int totalRows = 9;

    // ---------- Vertical Center Line (unchanged) ----------
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      paint,
    );

    // ---------- Horizontal Line After 5th Row ----------
    //
    // Row indexes: 0 1 2 3 4 (5th row)
    // We draw line AFTER row index 4.
    //
    final double y = (spacing * 4.7) + (dotSize / 2);

    canvas.drawLine(
      Offset(0, y),
      Offset(size.width, y),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
