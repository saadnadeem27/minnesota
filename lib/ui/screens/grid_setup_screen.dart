import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../routes.dart';
import '../../../viewmodels/grid_vm.dart';
import '../widgets/app_button.dart';
import '../widgets/color_dot.dart';
import 'dialog_reset.dart';

class GridSetupScreen extends StatelessWidget {
  GridSetupScreen({super.key});

  final GridVM vm = Get.put(GridVM());

  @override
  Widget build(BuildContext context) {
    const int rows = 9;
    const int cols = 8;
    const double dotSize = 12;     // dot stays small (UI same)
    const double spacing = 35;    // area between dots (tap area)

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        leading: const SizedBox(),
        title: Text(
          'Grid Setup',
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

      backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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

                          // ------------------------------------------------
                          //   ✅ Added Vertical + Horizontal Lines
                          // ------------------------------------------------
                          CustomPaint(
                            size: Size(gridWidth, gridHeight),
                            painter: _CrossLinesPainter(),
                          ),

                          // ------------------------------------------------
                          //   DOT GRID (unchanged)
                          // ------------------------------------------------
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
                                onTapDown: (_) => vm.toggleSelect(dot.id),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: ColorDot(
                                    color: dot.selected
                                        ? dot.color
                                        : Colors.grey[300]!,
                                    visible: dot.visible,
                                    brightness: dot.brightness,
                                    size: dotSize,
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

            const SizedBox(height: 16),

            AppButton(
              label: 'Customize Dots',
              style: AppButtonStyle.primaryBlue,
              onTap: () => Get.toNamed(Routes.customize),
            ),

            const SizedBox(height: 16),

            AppButton(
              label: 'Start Session',
              style: AppButtonStyle.primaryGreen,
              onTap: () => Get.toNamed(Routes.sessionControl),
            ),

            const SizedBox(height: 16),

            AppButton(
              label: 'Reset Grid',
              style: AppButtonStyle.neutral,
              onTap: () => Get.dialog(
                DialogReset(),
                barrierColor: Colors.transparent,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Select your focus areas before starting session.',
              textAlign: TextAlign.center,
              style: GoogleFonts.mulish(
                color: const Color(0xFF6C6C6C),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Tip: Try focusing on symmetrical points for balanced therapy.',
              textAlign: TextAlign.center,
              style: GoogleFonts.mulish(
                color: const Color(0xFF6C6C6C),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
///  🎯 LINE PAINTER (only this is added)
/// ------------------------------------------------------------
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

