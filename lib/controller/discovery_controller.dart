import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/models/country_model.dart';
import 'package:project/models/discovery_martba_model.dart';

class DiscoveryController extends GetxController {
  // for martaa...
  List<DiscovertMartbaItem> _martbaList = [
    DiscovertMartbaItem(
        Icons.access_time, "هدايا الغرفة", Icons.image, Colors.blue),
    DiscovertMartbaItem(
        Icons.access_time, "الهدايا المرسلة", Icons.image, Colors.orange),
    DiscovertMartbaItem(Icons.access_time, "الهدايا المستلمة", Icons.image,
        Colors.deepPurpleAccent),
    DiscovertMartbaItem(
        Icons.access_time, "مليادير نعومة", Icons.image, Colors.redAccent),
  ];
  List<DiscovertMartbaItem> get martbaList => _martbaList;

  // for countries...
  List<CountryModel> _countriesList = [
    CountryModel(Icons.flag, "السعودية"),
    CountryModel(Icons.flag, "مصر"),
    CountryModel(
      Icons.flag,
      "الكويت",
    ),
    CountryModel(
      Icons.flag,
      "الامارات",
    ),
    CountryModel(
      Icons.flag,
      "البحرين",
    ),
    CountryModel(
      Icons.flag,
      "قطر",
    ),
  ];
  List<CountryModel> get countriesList => _countriesList;
}
