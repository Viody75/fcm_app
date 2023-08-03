import 'dart:developer';
import 'package:fcm_mobile/app/services/storages/local_storage.dart';
import 'package:intl/intl.dart';
import 'package:fcm_mobile/app/services/apis/odp_api_provider.dart';
import 'package:fcm_mobile/app/services/locations/location_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    OdpDay = getDay();
    OdpName = await LocalStorage().getUser();
    getListKab();
    getListKec();
    update();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Map
  MapController mapController = MapController();
  getUserPosition() async {
    await LocationServices().determineUserPosition();
    try {
      mapController.move(
        LatLng(LocationServices.userPosition.latitude,
            LocationServices.userPosition.longitude),
        14,
      );
      update();
    } catch (e) {
      log(e.toString());
    }
  }

  // ODP
  List<Marker> listOdpMarker = [];
  List<dynamic> listOdpUser = [];
  String? OdpName = '';
  String OdpKab = '';
  String OdpKec = '';
  String OdpDay = '';

  getOdpUser() async {
    Response response =
        await OdpAPIsProvider().getOdp(day: OdpDay, kec: OdpKec, kab: OdpKab);
    if (response.statusCode == 200) {
      listOdpUser = response.body;
      log(listOdpUser.toString());
      setOdpMarker();
    }
  }

  String getDay() {
    String day = DateFormat('EEEE').format(DateTime.now());
    switch (day) {
      case "Monday":
        day = "SENIN";
        break;
      case "Tuesday":
        day = "SELASA";
        break;
      case "Wednesday":
        day = "RABU";
        break;
      case "Thursday":
        day = "KAMIS";
        break;
      case "Friday":
        day = "JUMAT";
        break;
      case "Saturday":
        day = "SABTU";
        break;
      case "Sunday":
        day = "MINGGU";
        break;
      default:
    }
    return day;
  }

  String filterKab = "~ ~ Pilih Kabupaten ~ ~";
  List<String> listFilterKab = ["~ ~ Pilih Kabupaten ~ ~"];
  bool filterKabSelected = false;
  void getListKab() async {
    Response response = await OdpAPIsProvider().getKab();
    log(response.body.toString());
    for (var i = 0; i < response.body.length; i++) {
      listFilterKab.add(response.body[i]["KABUPATEN"]);
    }
    update();
  }

  String filterKec = "~ ~ Pilih Kecamatan ~ ~";
  List<String> listFilterKec = ["~ ~ Pilih Kecamatan ~ ~"];
  bool filterKecSelected = false;
  void getListKec() async {
    Response response = await OdpAPIsProvider().getKec();
    log(response.body.toString());
    for (var i = 0; i < response.body.length; i++) {
      listFilterKec.add(response.body[i]["KECAMATAN"]);
    }
    update();
  }

  String odpActiveName = "";
  bool isOdpActive = false;
  setOdpMarker() {
    listOdpMarker.clear();
    update();
    for (var i = 0; i < listOdpUser.length; i++) {
      switch (listOdpUser[i]['STATUS_ODP']) {
        case "ODP MERAH":
          listOdpMarker.add(
            Marker(
              point: LatLng(
                double.parse(listOdpUser[i]['LATITUDE']),
                double.parse(listOdpUser[i]['LONGITUDE']),
              ),
              builder: (context) => IconButton(
                onPressed: () {
                  odpActiveName = listOdpUser[i]['ODP_NAME'];
                  isOdpActive = true;
                  update();
                },
                icon: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 30,
                ),
              ),
            ),
          );
          break;
        case "ODP KUNING":
          listOdpMarker.add(
            Marker(
              point: LatLng(
                double.parse(listOdpUser[i]['LATITUDE']),
                double.parse(listOdpUser[i]['LONGITUDE']),
              ),
              builder: (context) => IconButton(
                onPressed: () {
                  odpActiveName = listOdpUser[i]['ODP_NAME'];
                  isOdpActive = true;
                  update();
                },
                icon: const Icon(
                  Icons.location_on,
                  color: Colors.yellowAccent,
                  size: 30,
                ),
              ),
            ),
          );
          break;
        case "ODP HIJAU":
          listOdpMarker.add(
            Marker(
              point: LatLng(
                double.parse(listOdpUser[i]['LATITUDE']),
                double.parse(listOdpUser[i]['LONGITUDE']),
              ),
              builder: (context) => IconButton(
                onPressed: () {
                  odpActiveName = listOdpUser[i]['ODP_NAME'];
                  isOdpActive = true;
                  update();
                },
                icon: const Icon(
                  Icons.location_on,
                  color: Colors.green,
                  size: 30,
                ),
              ),
            ),
          );
          break;
        case "ODP HITAM":
          listOdpMarker.add(
            Marker(
              point: LatLng(
                double.parse(listOdpUser[i]['LATITUDE']),
                double.parse(listOdpUser[i]['LONGITUDE']),
              ),
              builder: (context) => IconButton(
                onPressed: () {
                  Get.toNamed("/odp-detail");
                },
                icon: const Icon(
                  Icons.location_on,
                  color: Colors.black,
                  size: 30,
                ),
              ),
            ),
          );
          break;
        default:
      }
    }
    update();
  }
}
