import 'package:project/models/register_model.dart';

abstract class RegisterAppStates {}

class RegistercubitIntialStates extends RegisterAppStates {}

class ShopRegisterSuccessStates extends RegisterAppStates {
  final RegisterModel registerModel;

  ShopRegisterSuccessStates(this.registerModel);
}

class ShopRegisterLoadingState extends RegisterAppStates {}

class ShopRegisterErrorStates extends RegisterAppStates {
  final String error;
  ShopRegisterErrorStates(this.error);
}

class CreateUserSuccessState extends RegisterAppStates {}

class CreateUserErrorState extends RegisterAppStates {
  final String error;
  CreateUserErrorState(this.error);
}

class ShopRegisterChangePasswordVisibilityState extends RegisterAppStates {}
