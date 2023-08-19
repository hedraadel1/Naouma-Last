import 'package:project/models/perimem_puchase_model.dart';
import 'package:project/models/permeim_model.dart';

import 'models/shop_intres_model.dart';

abstract class ShopIntresStates {}

class ShopCubitIntialStates extends ShopIntresStates {}

class ShopIntresSuccessStates extends ShopIntresStates {}

class ShopIntresLoadingState extends ShopIntresStates {}

class ShopIntresErrorStates extends ShopIntresStates {
  final String error;
  ShopIntresErrorStates(this.error);
}

class FrameSuccessStates extends ShopIntresStates {}

class FrameLoadingState extends ShopIntresStates {}

class FrameErrorStates extends ShopIntresStates {
  final String error;
  FrameErrorStates(this.error);
}

class PermemSuccessStates extends ShopIntresStates {
  final PermiemModel permiemModel;
  PermemSuccessStates(this.permiemModel);
}

class PermemLoadingState extends ShopIntresStates {}

class PermemErrorStates extends ShopIntresStates {
  final String error;
  PermemErrorStates(this.error);
}

class BuyPermemSuccessStates extends ShopIntresStates {}

class BuyPermemLoadingState extends ShopIntresStates {}

class BuyPermemErrorStates extends ShopIntresStates {
  final String error;
  BuyPermemErrorStates(this.error);
}

class RoomLocksSuccessStates extends ShopIntresStates {}

class RoomLocksLoadingState extends ShopIntresStates {}

class RoomLocksErrorStates extends ShopIntresStates {
  final String error;
  RoomLocksErrorStates(this.error);
}

class LockPurchaseSuccessStates extends ShopIntresStates {}

class LockPurchaseLoadingState extends ShopIntresStates {}

class LockPurchaseErrorStates extends ShopIntresStates {
  final String error;
  LockPurchaseErrorStates(this.error);
}

class BackgroundLoadingStates extends ShopIntresStates {}

class BackgroundSuccessStates extends ShopIntresStates {}

class BackgroundErrorStates extends ShopIntresStates {
  final String error;
  BackgroundErrorStates(this.error);
}

class MyBackgroundLoadingStates extends ShopIntresStates {}

class MyBackgroundSuccessStates extends ShopIntresStates {}

class MyBackgroundErrorStates extends ShopIntresStates {
  final String error;
  MyBackgroundErrorStates(this.error);
}

class MyIntesLoadingStates extends ShopIntresStates {}

class MyIntesSuccessStates extends ShopIntresStates {}

class MyIntesErrorStates extends ShopIntresStates {
  final String error;
  MyIntesErrorStates(this.error);
}

class WalletLoadingStates extends ShopIntresStates {}

class WalletSuccessStates extends ShopIntresStates {}

class WalletErrorStates extends ShopIntresStates {
  final String error;
  WalletErrorStates(this.error);
}

class ShopPurchaseLoadingStates extends ShopIntresStates {}

class ShopPurchaseSuccessStates extends ShopIntresStates {}

class ShopPurchaseErrorStates extends ShopIntresStates {
  final String error;
  ShopPurchaseErrorStates(this.error);
}

class PersonalPurchaseIDLoadingStates extends ShopIntresStates {}

class PersonalPurchaseIDSuccessStates extends ShopIntresStates {}

class PersonalPurchaseIDErrorStates extends ShopIntresStates {
  final String error;
  PersonalPurchaseIDErrorStates(this.error);
}

class BackGroundPurchaseLoadingStates extends ShopIntresStates {}

class BackGroundPurchaseSuccessStates extends ShopIntresStates {}

class BackGroundPurchaseErrorStates extends ShopIntresStates {
  final String error;
  BackGroundPurchaseErrorStates(this.error);
}

class SpecialIDLoadingStates extends ShopIntresStates {}

class SpecialIDSuccessStates extends ShopIntresStates {}

class SpecialIDErrorStates extends ShopIntresStates {
  final String error;
  SpecialIDErrorStates(this.error);
}

class SpecialRoomIDLoadingStates extends ShopIntresStates {}

class SpecialRoomIDSuccessStates extends ShopIntresStates {}

class SpecialRoomIDErrorStates extends ShopIntresStates {
  final String error;
  SpecialRoomIDErrorStates(this.error);
}
