import 'dart:developer';

import 'package:fcm_mobile/app/modules/home/widgets/dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ODP'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GetBuilder<HomeController>(
            builder: (_) {
              return FlutterMap(
                mapController: controller.mapController,
                options: MapOptions(
                    center: LatLng(-0.424905, 115.867316),
                    zoom: 10,
                    onMapReady: () {
                      controller.getUserPosition();
                    }),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.boredvio',
                  ),
                  GetBuilder<HomeController>(
                    builder: (context) {
                      return MarkerLayer(
                        markers: controller.listOdpMarker,
                      );
                    },
                  ),
                ],
              );
            },
          ),

          // Filter
          Positioned(
            top: 16,
            right: 16,
            left: 16,
            child: Container(
              height: 120,
              color: Colors.white,
              child: GetBuilder<HomeController>(builder: (_) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          controller.OdpName ?? "User Error",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Text(" | "),
                        Text(
                          controller.OdpDay,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Kabupaten"),
                        const SizedBox(
                          width: 8,
                        ),
                        DropdownWidget(
                          item: controller.filterKab,
                          items: controller.listFilterKab,
                          onChanged: (String? value) {
                            if (value == "~ ~ Pilih Kabupaten ~ ~") {
                              controller.filterKabSelected = false;
                            } else {
                              controller.filterKabSelected = true;
                            }
                            log(controller.filterKabSelected.toString());
                            controller.filterKab = value!;
                            controller.OdpKab = value;
                            controller.update();
                          },
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Kecamatan"),
                        const SizedBox(
                          width: 8,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        DropdownWidget(
                          item: controller.filterKec,
                          items: controller.listFilterKec,
                          onChanged: (String? value) {
                            if (value == "~ ~ Pilih Kecamatan ~ ~") {
                              controller.filterKecSelected = false;
                            } else {
                              controller.filterKecSelected = true;
                            }
                            log(controller.filterKecSelected.toString());
                            controller.filterKec = value!;
                            controller.OdpKec = value;

                            if (controller.filterKabSelected &&
                                controller.filterKecSelected) {
                              controller.getOdpUser();
                            }
                            controller.update();
                          },
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
          ),
          // Information

          GetBuilder<HomeController>(builder: (_) {
            return controller.isOdpActive
                ? Positioned(
                    bottom: 16,
                    left: 32,
                    right: 32,
                    child: Container(
                      color: Colors.white,
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.odpActiveName,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              onPressed: () {
                                Get.toNamed("/odp-detail");
                              },
                              icon: const Icon(
                                Icons.location_pin,
                                color: Colors.red,
                                size: 30,
                              ))
                        ],
                      ),
                    ),
                  )
                : Container();
          })
        ],
      ),
    );
  }
}
