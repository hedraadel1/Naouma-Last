/*
 * Copyright (c) 2023. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ola_like_country_picker/ola_like_country_picker.dart';
import 'package:project/utils/images.dart';
import 'package:project/view/profile/profile_cubit.dart';
import 'package:project/view/profile/profile_states.dart';
import 'package:project/utils/constants.dart';

import 'models/getProfile_model.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  CountryPicker countryPicker;
  Country country = Country.fromJson(countryCodes[0]);

  void initState() {
    super.initState();

    countryPicker = CountryPicker(onCountrySelected: (Country country) {
      print(country);
      setState(() {
        this.country = country;
      });
    });
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  TextEditingController username = TextEditingController();
  TextEditingController sex = TextEditingController();
  TextEditingController date = TextEditingController();

  // TextEditingController username = TextEditingController();
  var usernameController = TextEditingController();
  var sexController = TextEditingController();
  var dateController = TextEditingController();
  var markController = TextEditingController();
  var countryController = TextEditingController();

  var fileController = TextEditingController();
  bool sexx = false;
  String _selected = '';
  List<String> _items = [
    'ذكر',
    'انثي',
    'غير محدد',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ProfileCubit.get(context).profileModel;
        // usernameController.text = model.data.first.name;
        sexController.text = _selected;
        countryController.text = 'مصر';
        dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
        markController.text = 'اختيار إشارات';
        fileController.text = 'إضافة تعريف الملف الشخيصة';
        return ConditionalBuilder(
          condition: ProfileCubit.get(context).profileModel != null,
          builder: (context) =>
              getprofileItem(ProfileCubit.get(context).profileModel),
          fallback: (context) => Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  Widget getprofileItem(GetProfileModel model) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "تعديل",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    // height: 0,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                          kDefaultProfileImage,
                        ),
                        backgroundColor: kPrimaryColor,
                        radius: 35,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                          labelText: 'اسم المستخدم',
                          labelStyle: TextStyle(color: Colors.grey))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      onTap: () => showModal(context),
                      readOnly: true,
                      controller: sexController,
                      decoration: InputDecoration(
                          labelText: 'الجنس',
                          labelStyle: TextStyle(color: Colors.grey))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      controller: dateController,
                      decoration: InputDecoration(
                          labelText: 'تاريخ الميلاد',
                          labelStyle: TextStyle(color: Colors.grey))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      readOnly: true,
                      onTap: () => countryPicker.launch(context),
                      controller: countryController,
                      decoration: InputDecoration(
                          labelText: 'البلد',
                          labelStyle: TextStyle(color: Colors.grey))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      readOnly: true,
                      controller: markController,
                      decoration: InputDecoration(
                          labelText: 'إشارة',
                          labelStyle: TextStyle(color: Colors.grey))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      onTap: () {},
                      readOnly: true,
                      controller: fileController,
                      decoration: InputDecoration(
                          labelText: 'تعريف الملف الشخضي',
                          labelStyle: TextStyle(color: Colors.grey))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showModal(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(8),
            height: 150,
            alignment: Alignment.center,
            child: ListView.separated(
                itemCount: _items.length,
                separatorBuilder: (context, int) {
                  return Divider();
                },
                itemBuilder: (context, index) {
                  return Center(
                    child: GestureDetector(
                        child: Text(_items[index]),
                        onTap: () {
                          setState(() {
                            _selected = _items[index];
                          });
                          Navigator.of(context).pop();
                        }),
                  );
                }),
          );
        });
  }
}
