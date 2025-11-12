import 'package:get/get.dart';
import 'ui/screens/splash_screen.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/grid_setup_screen.dart';
import 'ui/screens/dot_customization_screen.dart';
import 'ui/screens/session_control_screen.dart';
import 'ui/screens/therapy_mode_screen.dart';
import 'ui/screens/settings_screen.dart';
import 'ui/screens/dialog_reset.dart';

class Routes {
  static const splash = '/';
  static const home = '/home';
  static const gridSetup = '/grid';
  static const customize = '/customize';
  static const sessionControl = '/sessionControl';
  static const session = '/therapy';
  static const settings = '/settings';
  static const dialogReset = '/dialogReset';

  static final pages = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: gridSetup, page: () => GridSetupScreen()),
    GetPage(name: customize, page: () => const DotCustomizationScreen()),
    GetPage(name: sessionControl, page: () => SessionControlScreen()),
    GetPage(name: session, page: () => TherapyModeScreen()),
    GetPage(name: settings, page: () => SettingsScreen()),
    GetPage(name: dialogReset, page: () => DialogReset()),
  ];
}
