import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../viewmodels/grid_vm.dart';
import '../widgets/app_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final GridVM vm = Get.find();
  Color selectedColor = Colors.red;
  double brightness = 0.5;
  String speed = 'Medium';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F6FF),
      appBar: AppBar(
        leading: SizedBox(),
        title:Text('Dot Customization',style: GoogleFonts.mulish(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w700),),
        centerTitle: true,
        backgroundColor: const Color(0xFFE8F6FF),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 20,left: 20,bottom: 20),
        child: Column(
          children: [
            Text(
              'Adjust how your selected dots appear during the therapy session.',
              textAlign: TextAlign.center,
              style: GoogleFonts.mulish(color: Color(0xFF6C6C6C),fontWeight: FontWeight.w500,fontSize: 17),
            ),
            const SizedBox(height: 20),


            Container(
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Color Picker',
                    style: GoogleFonts.mulish(color: Color(0xFF1E1E1E),fontWeight: FontWeight.w700,fontSize: 14),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (final color in [
                        Color(0XFFEC584C),
                        Color(0XFF49B456),
                        Color(0XFF5188CF),
                        Color(0XFFF6CE4B),
                        Color(0XFFFAFAFA),
                        Color(0XFFD9D9D9),
                      ])
                        GestureDetector(
                          onTap: () => setState(() => selectedColor = color),
                          child: CircleAvatar(
                            backgroundColor: color,
                            radius: 20,
                            child: selectedColor == color
                                ? const Icon(Icons.check, color: Colors.white)
                                : null,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),



            const SizedBox(height: 30),

            Container(
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Brightness',
                    style: GoogleFonts.mulish(color: Color(0xFF1E1E1E),fontWeight: FontWeight.w700,fontSize: 14),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            backgroundColor: Color(0XFFEC584C),
                            radius: 25,
                          ),

                          // ✅ Slider + labels stacked in one column
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(height: 10,),
                                Slider(
                                  value: brightness,
                                  min: 0.1,
                                  max: 1.0,
                                  onChanged: (v) => setState(() => brightness = v),
                                  activeColor: Colors.blue,
                                  thumbColor: const Color(0XFF8F8F90),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        'Low',
                                        style: TextStyle(fontSize: 13, color: Color(0xFF6C6C6C)),
                                      ),
                                      Text(
                                        'High',
                                        style: TextStyle(fontSize: 13, color: Color(0xFF6C6C6C)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )

                    ],
                  )

                ],
              ),
            ),
            const SizedBox(height: 20),

            Container(
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Blink Speed',
                      style: GoogleFonts.mulish(color: Color(0xFF1E1E1E),fontWeight: FontWeight.w700,fontSize: 14),
                    ),),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: ['Slow', 'Medium', 'Fast'].map((s) {
                      final bool isSelected = speed == s;
                      return GestureDetector(
                        onTap: () => setState(() => speed = s),
                        child: Row(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              height: 22,
                              width: 22,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected ? Color(0XFF1086C6) : Colors.transparent,
                                border: Border.all(
                                  color: isSelected ? Colors.blue : const Color(0xFF6C6C6C),
                                  width: 2,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              s,
                              style: TextStyle(fontSize: 14, color: Color(0xFF6C6C6C)),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  )

                ],
              ),
            ),


            const Spacer(),
            Text(
              'Helps in focus training and motion tracking.',
              textAlign: TextAlign.center,
              style: GoogleFonts.mulish(color: Color(0xFF6C6C6C),fontWeight: FontWeight.w500,fontSize: 14),
            ),
            SizedBox(height: 10,),
            AppButton(
              label: 'Apply to Selection',
              style: AppButtonStyle.primaryGreen,
              onTap: () {
                vm.applyColor(selectedColor);
                Get.back();
              },
            ),
            const SizedBox(height: 10),
            AppButton(
              label: 'Back to Grid',
              style: AppButtonStyle.neutral,
              onTap: () => Get.back(),
            ),
            SizedBox(height: 10,),
            Text(
              'Tip: Use contrating colors and moderate brightness for effective eye training',
              textAlign: TextAlign.center,
              style: GoogleFonts.mulish(color: Color(0xFF6C6C6C),fontWeight: FontWeight.w500,fontSize: 12),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
