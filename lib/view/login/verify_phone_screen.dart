// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:naouma/controller/auth_controller.dart';
// import 'package:naouma/models/state_model.dart';
// import 'package:naouma/utils/constants.dart';

// class VerifyPhoneScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     TextStyle style = TextStyle(fontFamily: 'Almarai', fontSize: 15.0);

//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//           backgroundColor: Colors.white,
//           appBar: AppBar(
//             title: Text("التحقق من رقم الهاتف"),
//             backgroundColor: Colors.white,
//           ),
//           body: GetBuilder<AuthController>(
//             init: AuthController(),
//             builder: (controller) => Container(
//               padding: const EdgeInsets.all(20.0),
//               child: Form(
//                 key: controller.loginFormKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   // mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "ادخل رقم الهاتف الذى تريد ربطة بحسابك.",
//                       style: theme.textTheme.bodyText1
//                           .copyWith(color: Colors.black, fontSize: 17),
//                       textAlign: TextAlign.start,
//                     ),
//                     _buildSizedBox(height: 30),
//                     Row(
//                       children: [
//                         SizedBox(
//                           width: 150,
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             mainAxisSize: MainAxisSize.min,
//                             children: <Widget>[
//                               Icon(
//                                 Icons.location_city,
//                                 size: 20,
//                               ),
//                               Expanded(
//                                 child: DropdownButtonHideUnderline(
//                                   child: ButtonTheme(
//                                     alignedDropdown: true,
//                                     child: DropdownButton<StateModel>(
//                                       isExpanded: true,
//                                       value: controller.selectedState,
//                                       iconSize: 28,
//                                       icon: (null),
//                                       style: theme.textTheme.bodyText2.copyWith(
//                                           color: Colors.grey, fontSize: 14),
//                                       hint: Text('اختر المدينة'),
//                                       onChanged: (StateModel newValue) {
//                                         print(newValue.id);
//                                         print(newValue.name);
//                                         controller
//                                             .updateSelectedState(newValue);
//                                       },
//                                       items: controller.countries?.map((item) {
//                                             return new DropdownMenuItem(
//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: new Text(
//                                                   item.name,
//                                                   textAlign: TextAlign.right,
//                                                   textDirection:
//                                                       TextDirection.rtl,
//                                                 ),
//                                               ),
//                                               value: item,
//                                             );
//                                           })?.toList() ??
//                                           [],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         _buildSizedBox(width: 8.0),
//                         Expanded(
//                           child: TextFormField(
//                             obscureText: false,
//                             style: style,
//                             enabled: true,
//                             maxLength: 11,
//                             keyboardType: TextInputType.phone,
//                             onSaved: (value) {
//                               controller.phone = value;
//                             },
//                             validator: (String val) {
//                               if (val.isEmpty) {
//                                 return "يجب ادخال رقم الهاتف اولا";
//                               } else {
//                                 return null;
//                               }
//                             },
//                             maxLines: 1,
//                             decoration: InputDecoration(
//                               fillColor: Colors.white,
//                               contentPadding:
//                                   EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 16.0),
//                               errorStyle: TextStyle(
//                                 fontFamily: "Cairo",
//                                 color: Colors.red,
//                                 fontSize: 13,
//                               ),
//                               labelText: "رقم الهاتف",
//                               labelStyle: TextStyle(fontSize: 15),
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(6.0)),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     _buildSizedBox(height: 15),
//                     Divider(),
//                     _buildSizedBox(height: 6),
//                     RichText(
//                       text: TextSpan(
//                         style: TextStyle(color: Colors.black, fontSize: 14),
//                         children: <TextSpan>[
//                           TextSpan(text: 'بالمتابعة أنت توافق على '),
//                           TextSpan(
//                               text: 'شروط الخدمة ',
//                               style: TextStyle(color: Colors.orange)),
//                           TextSpan(text: 'و '),
//                           TextSpan(
//                               text: 'سياسة الخصوصية ',
//                               style: TextStyle(color: Colors.orange)),
//                           TextSpan(
//                             text: ' فى يلا',
//                           )
//                         ],
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     _buildSizedBox(height: 36),
//                     Center(
//                       child: Material(
//                         elevation: 2.0,
//                         borderRadius: BorderRadius.circular(24.0),
//                         color: kPrimaryColor,
//                         child: MaterialButton(
//                             height: 36,
//                             minWidth: 240,
//                             onPressed: () {
//                               if (controller.loginFormKey.currentState
//                                   .validate()) {
//                                 controller.loginFormKey.currentState.save();
//                                 // No any error in validation
//                                 controller.login();
//                               }
//                             },
//                             child: Text(
//                               "تسجيل الدخول/التسجيل",
//                               textAlign: TextAlign.center,
//                               style: theme.textTheme.button,
//                             )),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           )),
//     );
//   }

//   Widget _buildSizedBox({double width, double height}) {
//     return SizedBox(
//       width: width,
//       height: height,
//     );
//   }
// }
