import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/odp_detail_controller.dart';

class OdpDetailView extends GetView<OdpDetailController> {
  const OdpDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OdpDetailView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'OdpDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
