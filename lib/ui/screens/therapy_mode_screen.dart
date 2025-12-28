import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../viewmodels/grid_vm.dart';
import '../../../viewmodels/session_vm.dart';
import '../widgets/app_button.dart';
import '../widgets/color_dot.dart';

class TherapyModeScreen extends StatefulWidget {
  const TherapyModeScreen({super.key});

  @override
  State<TherapyModeScreen> createState() => _TherapyModeScreenState();
}

class _TherapyModeScreenState extends State<TherapyModeScreen> {
  final GridVM vm = Get.find();
  final SessionVM sessionVM = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      sessionVM.startSession();
    });
  }

  @override
  void dispose() {
    sessionVM.stopSession();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const int rows = 9;
    const int cols = 8;

    const double dotSize = 12;
    const double spacing = 35;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: Column(
            children: [
              Text(
                'Therapy Mode',
                style: GoogleFonts.mulish(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),

              Expanded(
                child: Obx(() {
                  final double gridWidth =
                      (cols * dotSize) + ((cols - 1) * spacing);
                  final double gridHeight =
                      (rows * dotSize) + ((rows - 1) * spacing);

                  return Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: SizedBox(
                      width: gridWidth,
                      height: gridHeight,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          /// -----------------------------------------
                          ///  CENTER LINES (same as grid setup)
                          /// -----------------------------------------
                          CustomPaint(
                            size: Size(gridWidth, gridHeight),
                            painter: _CrossLinesPainter(),
                          ),

                          /// -----------------------------------------
                          ///  DOT GRID (no change)
                          /// -----------------------------------------
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
                              return Center(
                                child: ColorDot(
                                  size: dotSize,
                                  color: dot.selected
                                      ? dot.color
                                      : Colors.grey[300]!,
                                  visible: dot.visible,
                                  brightness: dot.brightness,
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

              AppButton(
                label: 'End Session',
                style: AppButtonStyle.dangerRed,
                onTap: () {
                  sessionVM.stopSession();
                  Get.back();
                },
              ),

              const SizedBox(height: 20),
              Text(
                'Ensure your device is at eye level and you are seated comfortably before starting.',
                textAlign: TextAlign.center,
                style: GoogleFonts.mulish(
                  color: Color(0xFF6C6C6C),
                  fontSize: 14,
                ),
              ),
            ],
          ),
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
