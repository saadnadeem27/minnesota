import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app_bindings.dart';
import 'core/theme.dart';
import 'routes.dart';

Future<void> main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetStorage BEFORE using Get.put()
  await GetStorage.init();

  // Start app — AppBindings will register controllers
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Vision Therapy',
      debugShowCheckedModeBanner: false,

      // 🟢 ViewModels are registered here safely
      initialBinding: AppBindings(),

      initialRoute: Routes.splash,
      getPages: Routes.pages,

      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.light,
    );
  }
}
