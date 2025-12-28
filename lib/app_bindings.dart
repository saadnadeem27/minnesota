import 'package:get/get.dart';
import '../viewmodels/grid_vm.dart';
import '../viewmodels/settings_vm.dart';
import '../viewmodels/session_vm.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {

    /// ORDER IS EXTREMELY IMPORTANT
    /// 1️⃣ GridVM FIRST (SettingsVM depends on it)
    Get.put(GridVM(), permanent: true);

    /// 2️⃣ SettingsVM SECOND (it calls Get.find<GridVM>())
    Get.put(SettingsVM(), permanent: true);

    /// 3️⃣ SessionVM LAST (it depends on both)
    Get.put(SessionVM(), permanent: true);
  }
}
