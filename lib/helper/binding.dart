import 'package:get/get.dart';
import 'package:project/controller/auth_controller.dart';
import 'package:project/controller/discovery_controller.dart';
import 'package:project/controller/home_controller.dart';
import 'package:project/controller/home_tab_controller.dart';
import 'package:project/controller/splash_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => SplashController());
    // Get.lazyPut(() => AuthController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => HomeTabController());
    Get.lazyPut(() => DiscoveryController());
  }
}
