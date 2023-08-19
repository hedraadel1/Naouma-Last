import 'package:get/get.dart';

class ProfileController extends GetxController{
  String _selectedGender;
  String get selectedGender=> _selectedGender;

  String _selectedDate ="01-01-2000";
  String get selectedDate=> _selectedDate;

  List<String> _genderList = ["ذكر", "انثي"];
  List<String> get genderList => _genderList;

  List<String> get countries => _countries;
  List<String> _countries = [
    'India',
    'Japan',
    'China',
    'USA',
    'France',
    'Egypt',
    'Norway',
    'Nigeria',
    'Colombia',
    'Australia',
    'South Korea',
    'Bangladesh',
    'Mozambique',
    'Canada',
    'Germany',
    'Belgium',
    'Vietnam',
    'Bhutan',
    'Israel',
    'Brazil'
  ];

  void updateGender(String gender){
    _selectedGender = gender;
    update();
  }

  void updateDate(String date){
    _selectedDate = date;
    update();
  }
}