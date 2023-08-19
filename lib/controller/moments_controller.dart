
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:project/models/share_with_model.dart';

// class MomentsController extends GetxController {
//   Position _currentPosition;
//   Position get currentPosition => _currentPosition;

//   // get location address
//   String _currentAddress = "الموقع";
//   String get currentAddress => _currentAddress;

//   int _shareSelectedType = 0;
//   int get shareSelectedType => _shareSelectedType;
//   String selectedTypeName;

//   // selected subject
//   String _selectedsubjectTitle = "اضافة موضوع";
//   String get selectedSubjectTitle => _selectedsubjectTitle;

//   void updateShareSelectedType(int index) {
//     _shareSelectedType = index;
//     update();
//   }

//   void setSelectedSubject(String subjectTitle) {
//     _selectedsubjectTitle = subjectTitle;
//     update();
//   }

//   List<ShareWithModel> _shareTypeItems = [
//     ShareWithModel(Icon(Icons.language), "عام", "كل الاصدقاء"),
//     ShareWithModel(Icon(Icons.people_alt_outlined), "عام", "الاصدقاء في يلا"),
//     ShareWithModel(Icon(Icons.lock_rounded), "خاص", "انا فقط"),
//   ];
//   List<ShareWithModel> get shareTypeItems => _shareTypeItems;
//   void getMyLocation() async {
//     Geolocator.getCurrentPosition(
//             desiredAccuracy: LocationAccuracy.best,
//             forceAndroidLocationManager: true)
//         .then((Position position) {
//       _currentPosition = position;
//       print(
//           "currentPosition: ${_currentPosition.latitude}, ${_currentPosition.longitude}");
//       _getAddressFromLatLng();
//     }).catchError((e) {
//       print(e);
//     });
//   }

//   _getAddressFromLatLng() async {
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//           _currentPosition.latitude, _currentPosition.longitude);
//       Placemark place = placemarks[0];
//       // _currentAddress = "loc: ${place.locality},cod: ${place.postalCode},coun: ${place.country}";
//       _currentAddress = "${place.locality}";
//       update();
//       print(_currentAddress);
//     } catch (e) {
//       print(e);
//     }
//   }
// }
