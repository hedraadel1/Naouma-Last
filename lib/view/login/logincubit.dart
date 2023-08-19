import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:project/auth_model.dart';
import 'package:project/models/create_user_model.dart';
import 'package:project/models/myroomCheck_model.dart';
import 'package:project/utils/constants.dart';
import 'package:project/dioHelper.dart';
import 'package:project/endpoint.dart';
import 'package:project/view/login/loginstates.dart';

class LoginScreenCubit extends Cubit<LoginAppStates> {
  LoginScreenCubit() : super(LogincubitIntialStates());
  static LoginScreenCubit get(context) => BlocProvider.of(context);

  AuthModel authModel;

  void userlogin({@required name, @required password}) {
    emit(ShopLoginLoadingState());
    DioHelper.postdata(
        url: Login,
        data: {
          'name': name,
          'password': password,
        },
        token: token)
        .then((value) {
      print(value.data);
      authModel = AuthModel.fromJson(value.data);
      userCreate(
          name: authModel.user.name, phone: '11111', uid: authModel.user.userId);
      print(authModel.user.userId);

      emit(ShopLoginSuccessStates(authModel));
    }).catchError((error) {
      emit(ShopLoginErrorStates(error.toString()));
    });
  }

  void userCreate(
      {@required String name, @required String phone, @required String uid}) {
    CreateUserModel model = CreateUserModel(
      name: name,
      phone: phone,
      uid: uid,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(
      model.toMap(),
    )
        .then((value) {
      emit(CreateUserSuccessStates());
      print("ok");
    }).catchError((error) {
      emit(CreateUserErrorStates(error.toString()));
    });
  }

  Widget nbAppButtonWidget(BuildContext context, String text, Function onTap) {
    return AppButton(
      text: text,
      textStyle: boldTextStyle(color: white),
      color: kPrimaryColor,
      onTap: onTap,
      width: context.width(),
    ).cornerRadiusWithClipRRect(20);
  }
}
