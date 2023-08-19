// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:naouma/Wallet_States.dart';
// import 'package:naouma/models/post_wallet_model.dart';
// import 'package:naouma/utils/constants.dart';

// import 'models/get_wallet_model.dart';
// import 'network/endpoint.dart';
// import 'network/remote/dioHelper.dart';

// class WalletCubit extends Cubit<WalletStates> {
//   WalletCubit() : super(WalletIntialStates());
//   static WalletCubit get(context) => BlocProvider.of(context);

  // PostWalletModel postWalletModel;

  // void PostWallet({@required amount}) {
  //   emit(WalletLoadingState());
  //   DioHelper.postdata(url: postwallet, data: {'amount': amount}).then((value) {
  //     print(value.data);
  //     postWalletModel = PostWalletModel.fromJson(value.data);

  //     emit(WalletSuccessStates());
  //   }).catchError((error) {
  //     emit(WalletErrorStates(error.toString()));
  //   });
  // }

//   GetWalletModel getWalletModel;

//   void getWalletAmount() {
//     emit(GetWalletLoadingStates());
//     DioHelper.getdata(url: getwallet, token: token).then((value) {
//       getWalletModel = GetWalletModel.fromJson(value.data);
//       print(value.data);
//       emit(GetWalletSuccessStates());
//     }).catchError((error) {
//       print(error.toString());
//       emit(GetWalletErrorStates(error.toString()));
//     });
//   }
// }
