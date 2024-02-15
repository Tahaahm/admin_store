import 'package:admin_store_commerce_shop/pages/settings/controller/theme_controller.dart';
import 'package:admin_store_commerce_shop/repository/authentication_repository.dart';
import 'package:admin_store_commerce_shop/repository/fetch_repository/fetch_repository.dart';
import 'package:admin_store_commerce_shop/util/newtork_manager/network_manager.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthenticationRepository());
    Get.put(NetworkManager());
    Get.put(ThemeController());
    Get.put(FetchRepository());
  }
}
