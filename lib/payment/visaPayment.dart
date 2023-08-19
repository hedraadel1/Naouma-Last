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
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:project/common_functions.dart';
import 'package:project/utils/constants.dart';

import '../view/home/homeCubit.dart';
import '../view/home/states.dart';
import '../wallet_screen.dart';

class VisaPayment extends StatefulWidget {
  String coins;

  VisaPayment({Key key, this.coins}) : super(key: key);

  @override
  State<VisaPayment> createState() => _VisaPaymentState();
}

class _VisaPaymentState extends State<VisaPayment> {
  GlobalKey<FormState> fomrkey = GlobalKey();

  TextEditingController nameController = TextEditingController();
  TextEditingController visaNumberController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  TextEditingController dateController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(listener: (context, state) {
      if (state is WalletSuccessStates) {
        CommonFunctions.showToast(
            "الي محفظتك ${widget.coins}تم ايضافة", Colors.green);
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
            leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
            Get.to(WalletScreen());
          },
        )),
        body: Form(
          key: fomrkey,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                  child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 140,
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: CommonFunctions()
                                          .nbAppTextFieldWidget(
                                        nameController,
                                        'Name',
                                        "ادخل الاسم",
                                        'برجاء ادخال الاسم',
                                        TextFieldType.NAME,
                                      ),
                                    ),
                                  ),
                                  // _sizedBox(height: 16),
                                  // CommonFunctions().nbAppTextFieldWidget(
                                  //   phoneNumberController,
                                  //   'phone',
                                  //   "Enter your phone",
                                  //   'phone is required',
                                  //   TextFieldType.PHONE,
                                  // ),
                                  Spacer(),
                                  Text(
                                    "*الاسم الثلاثي",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 140,
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: CommonFunctions()
                                          .nbAppTextFieldWidget(
                                        visaNumberController,
                                        'visaNumber',
                                        "0000****",
                                        'برجاء ادخال رقم البطاقة',
                                        TextFieldType.PASSWORD,
                                      ),
                                    ),
                                  ),
                                  // _sizedBox(height: 16),
                                  // CommonFunctions().nbAppTextFieldWidget(
                                  //   phoneNumberController,
                                  //   'phone',
                                  //   "Enter your phone",
                                  //   'phone is required',
                                  //   TextFieldType.PHONE,
                                  // ),
                                  Spacer(),
                                  Text(
                                    "*رقم البطاقة",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 140,
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: CommonFunctions()
                                          .nbAppTextFieldWidget(
                                        cvvController,
                                        'Cvv',
                                        "       /        /         ",
                                        'Cvv برجاء ادخال رقم ال',
                                        TextFieldType.PHONE,
                                      ),
                                    ),
                                  ),
                                  // _sizedBox(height: 16),
                                  // CommonFunctions().nbAppTextFieldWidget(
                                  //   phoneNumberController,
                                  //   'phone',
                                  //   "Enter your phone",
                                  //   'phone is required',
                                  //   TextFieldType.PHONE,
                                  // ),
                                  Spacer(),
                                  Text(
                                    "*Cvv  رقم ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 140,
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: TextFormField(
                                          readOnly: true,
                                          onTap: () => _selectDate(context),
                                          controller: dateController,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0)),
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.grey.shade400),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0)),
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.grey.shade400),
                                              ),
                                              hintText: "1/2/1990")),
                                    ),
                                  ),
                                  // _sizedBox(height: 16),
                                  // CommonFunctions().nbAppTextFieldWidget(
                                  //   phoneNumberController,
                                  //   'phone',
                                  //   "Enter your phone",
                                  //   'phone is required',
                                  //   TextFieldType.PHONE,
                                  // ),
                                  Spacer(),
                                  Text(
                                    "تاريخ الميلاد",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Text(widget.coins),
                                  Spacer(),
                                  Text(
                                    "قيمة الشحن",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                          child: InkWell(
                        child: Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              topLeft: Radius.circular(10),
                            ),
                            // border: Border.all(
                            //   width: 1,
                            //   color: kPrimaryColor,
                            //   style: BorderStyle.solid,
                            // ),
                            // shape: BoxShape.circle,
                          ),
                          child: ConditionalBuilder(
                            condition: state is! WalletLoadingState,
                            builder: (context) => Center(
                                child: Text(
                              "الشحن",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )),

                            // controller.loginFormKey.currentState.save();
                            // // No any error in validation
                            // controller.loginEmail =
                            //     controller.phoneNumberController.text;
                            // controller.password =
                            //     controller.passwordController.text;

                            // controller.login();

                            fallback: (context) => Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                        onTap: () {
                          if (fomrkey.currentState.validate()) {
                            HomeCubit.get(context)
                                .postWallet(amount: widget.coins.toInt());
                          }
                        },
                      ))
                    ],
                  ),
                ],
              )),

              //  HomeCubit.get(context).postWallet(amount: 100);

              // Expanded(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.stretch,
              //     children: <Widget>[
              //       Expanded(
              //         child: Container(
              //           color: Colors.purple,
              //         ),
              //       ),
              //       Expanded(
              //         child: Container(
              //           color: Colors.black,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      );
    });
  }
}
