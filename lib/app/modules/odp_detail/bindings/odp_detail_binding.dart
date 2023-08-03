import 'package:get/get.dart';

import '../controllers/odp_detail_controller.dart';

class OdpDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OdpDetailController>(
      () => OdpDetailController(),
    );
  }
}
