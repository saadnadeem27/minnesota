import 'package:flutter/material.dart';
import 'package:get/get.dart'; // ✅ import
import 'package:get_storage/get_storage.dart';
import 'app_bindings.dart';
import 'core/theme.dart';
import 'routes.dart';

// Import ViewModels
import 'viewmodels/grid_vm.dart';
import 'viewmodels/settings_vm.dart';
import 'viewmodels/session_vm.dart';

Future<void> main() async {
  // ✅ Ensure Flutter binding is ready
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialize GetStorage BEFORE any Get.put() or runApp()
  await GetStorage.init();

  // ✅ Register ViewModels globally (after GetStorage init)
  Get.put(GridVM(), permanent: true);
  Get.put(SettingsVM(), permanent: true);
  Get.put(SessionVM(), permanent: true);

  // ✅ Now start the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Vision Therapy',
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),
      initialRoute: Routes.splash,
      getPages: Routes.pages,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.light,
    );
  }
}
