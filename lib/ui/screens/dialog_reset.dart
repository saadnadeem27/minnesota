import 'dart:ui'; // 👈 Required for blur
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../viewmodels/grid_vm.dart';
import '../widgets/app_button.dart';

class DialogReset extends StatelessWidget {
  DialogReset({super.key});
  final GridVM vm = Get.find();   // backend controller

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ✅ Background blur
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Container(
            color: Colors.black.withOpacity(0.1),
          ),
        ),

        // ✅ The actual dialog
        Center(
          child: Dialog(
            elevation: 0,
            backgroundColor: Colors.white.withOpacity(0.95),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/images/reset_icon.png",
                    height: 90,
                    width: 90,
                  ),
                  const SizedBox(height: 10),

                  Text(
                    'Are you sure you want to reset all selections?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.mulish(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 🔥 Backend Connected Button
                  AppButton(
                    label: 'Yes, Reset',
                    style: AppButtonStyle.primaryBlue,
                    onTap: () {
                      vm.resetGrid();      // <-- backend function used
                      Get.back();          // close dialog
                    },
                  ),

                  const SizedBox(height: 12),

                  AppButton(
                    label: 'Cancel',
                    style: AppButtonStyle.dangerRed,
                    onTap: () => Get.back(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
