import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MahamItemModel{
  final Icon icon;
  final String title;
  final String subTitle;
  final Icon subTitleIcon;

  MahamItemModel(this.icon, this.title, this.subTitle, this.subTitleIcon);

}

List<MahamItemModel> dailyMaham = [
  MahamItemModel(Icon(Icons.mic, color: Colors.white,), "اخذ المايك لمدة 10 دقائق", "10 +", Icon(Icons.fiber_manual_record_sharp, color: Colors.blue)),
  MahamItemModel(Icon(Icons.mic, color: Colors.white,), "اخذ المايك لمدة 10 دقائق", "10 +", Icon(Icons.fiber_manual_record_sharp, color: Colors.blue)),
  MahamItemModel(Icon(Icons.mic, color: Colors.white,), "اخذ المايك لمدة 10 دقائق", "10 +", Icon(Icons.fiber_manual_record_sharp, color: Colors.blue)),
];

List<MahamItemModel> developingMaham = [
  MahamItemModel(Icon(Icons.mic, color: Colors.white,), "اخذ المايك لمدة 10 دقائق", "10 +", Icon(Icons.fiber_manual_record_sharp, color: Colors.blue)),
  MahamItemModel(Icon(Icons.mic, color: Colors.white,), "اخذ المايك لمدة 10 دقائق", "10 +", Icon(Icons.fiber_manual_record_sharp, color: Colors.blue)),
  MahamItemModel(Icon(Icons.mic, color: Colors.white,), "اخذ المايك لمدة 10 دقائق", "10 +", Icon(Icons.fiber_manual_record_sharp, color: Colors.blue)),
];