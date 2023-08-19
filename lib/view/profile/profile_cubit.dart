import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:project/models/get_profile_model.dart';
import 'package:project/models/get_user_exp_model.dart';
import 'package:project/network/cache_helper.dart';

import 'package:project/utils/constants.dart';
import 'package:project/dioHelper.dart';
import 'package:project/models/getProfile_model.dart';
import 'package:project/view/profile/profile_states.dart';

import '../../endpoint.dart';
import '../../models/get_wallet_model.dart';
import '../../models/profileGifts_model.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileIntialStates());

  static ProfileCubit get(context) => BlocProvider.of(context);

  GetProfileModel profileModel;

  void getprofile() {
    DioHelper.getdata(url: profile, token: token).then((value) {
      profileModel = GetProfileModel.fromJson(value.data);
      print(value.data);
      emit(ProfileSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(ProfileErrorStates());
    });
  }

  ProfileGiftsModel profileGiftsModel;
  void giftuserProfile({@required id}) {
    emit(ProfileGiftLoadingStates());

    DioHelper.getdata(url: 'gifts/$id', token: token).then((value) {
      profileGiftsModel = ProfileGiftsModel.fromJson(value.data);

      print(value.data);

      emit(ProfileGiftSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(ProfileGiftErrorState());
    });
  }

  GetUserExpModel getUserExpModel;
  void getuserExp({@required id}) {
    emit(GetUserExpLoadingStates());

    DioHelper.getdata(url: 'getExpLevel/$id', token: token).then((value) {
      getUserExpModel = GetUserExpModel.fromJson(value.data);

      print(value.data);

      emit(GetUserExpSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserExpErrorState());
    });
  }

  GetWalletModel getWalletModel;
  void getWalletAmount() {
    DioHelper.getdata(
        url: "$getwallet/${CacheHelper.getData(key: "id")}", token: token)
        .then((value) {
      getWalletModel = GetWalletModel.fromJson(value.data);
      print(value.data);
      emit(GetWalletSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(GetWalletErrorStates());
    });
  }
//  void userlogin({@required mobile, @required password}) {
//   emit(ShopLoginLoadingState());
//   DioHelper.postdata(
//       url: Login,
//       data: {'mobile': mobile, 'password': password}).then((value) {
//     print(value.data);
//     authModel = AuthModel.fromJson(value.data);

//     emit(ShopLoginSuccessStates(authModel));
//     flag = 1;
//   }).catchError((error) {
//     emit(ShopLoginErrorStates(error.toString()));
//   });
// }
}
