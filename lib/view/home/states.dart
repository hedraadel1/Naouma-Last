import '../../models/addExperience_model.dart';
import '../../models/get_user_exp_model.dart';

abstract class HomeStates {}

class HomeIntialStates extends HomeStates {}

class HomeSuccessStates extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeErrorStates extends HomeStates {
  final String error;
  HomeErrorStates(this.error);
}

class GetMyRoomSuccessStates extends HomeStates {}

class GetMyRoomLoadingState extends HomeStates {}

class GetMyRoomErrorStates extends HomeStates {
  final String error;
  GetMyRoomErrorStates(this.error);
}

// class ProfileSuccessStates extends HomeStates {}

// class ProfileErrorStates extends HomeStates {}

class JoinedSuccessStates extends HomeStates {}

class JoinedErrorStates extends HomeStates {}

class GetWalletSuccessStates extends HomeStates {}

class GetWalletErrorStates extends HomeStates {}

class WalletSuccessStates extends HomeStates {}

class WalletLoadingState extends HomeStates {}

class WalletErrorStates extends HomeStates {
  final String error;
  WalletErrorStates(this.error);
}

class UnfollowUserSuccessStates extends HomeStates {}

class UnfollowUserLoadingState extends HomeStates {}

class UnfollowUserErrorStates extends HomeStates {
  final String error;
  UnfollowUserErrorStates(this.error);
}

class SetPasswordRoomSuccessStates extends HomeStates {}

class SetPasswordRoomLoadingState extends HomeStates {}

class SetPasswordRoomErrorStates extends HomeStates {
  final String error;
  SetPasswordRoomErrorStates(this.error);
}

class GetGiftSuccessStates extends HomeStates {}

class GetGiftErrorStates extends HomeStates {}
// class GetProductsLoadingState extends HomeState {}

// class GetProductsSuccesState extends HomeState {}

// class GetProductsErrorState extends HomeState {
//   final String error;
//   GetProductsErrorState(this.error);
// }

class GetallUsersErrorStates extends HomeStates {}

class GetallUsersSuccessStates extends HomeStates {}

class GetallUsersErrorState extends HomeStates {
  final String error;
  GetallUsersErrorState(this.error);
}

class SendMassegesSuccessStates extends HomeStates {}

class SendMassegesErrorState extends HomeStates {}

class GetMessageSuccessStates extends HomeStates {}

class GetMessageErrorState extends HomeStates {}

class CreateroomSuccessStates extends HomeStates {}

class CreateroomErrorState extends HomeStates {}

class NotificationSuccessStates extends HomeStates {}

class NotificationErrorState extends HomeStates {}

class FcmSuccessStates extends HomeStates {}

class FcmErrorState extends HomeStates {
  final String error;
  FcmErrorState(this.error);
}

class InroomLoadingStates extends HomeStates {}

class InroomSuccessStates extends HomeStates {}

class InroomErrorState extends HomeStates {}

class SendGiftSuccessStates extends HomeStates {}

class SendGiftLoadingState extends HomeStates {}

class SendGiftErrorStates extends HomeStates {
  final String error;
  SendGiftErrorStates(this.error);
}

class EditRoomSuccessStates extends HomeStates {}

class EditRoomLoadingState extends HomeStates {}

class EditRoomErrorStates extends HomeStates {
  final String error;
  EditRoomErrorStates(this.error);
}

class FollowSuccessStates extends HomeStates {}

class FollowLoadingState extends HomeStates {}

class FollowErrorStates extends HomeStates {
  final String error;
  FollowErrorStates(this.error);
}

class MyroomCheckSuccessStates extends HomeStates {}

class MyroomCheckLoadingState extends HomeStates {}

class MyroomCheckErrorStates extends HomeStates {
  final String error;
  MyroomCheckErrorStates(this.error);
}

class FollowingSuccessStates extends HomeStates {}

class FollowingLoadingState extends HomeStates {}

class FollowingErrorStates extends HomeStates {
  final String error;
  FollowingErrorStates(this.error);
}

class UsersFollowingSuccessStates extends HomeStates {}

class UsersFollowingLoadingState extends HomeStates {}

class UsersFollowingErrorStates extends HomeStates {
  final String error;
  UsersFollowingErrorStates(this.error);
}

class JoinmicSuccessStates extends HomeStates {}

class JoinmicLoadingState extends HomeStates {}

class JoinmicsErrorStates extends HomeStates {
  final String error;
  JoinmicsErrorStates(this.error);
}

class AddSupervsorSuccessStates extends HomeStates {}

class AddSupervsorLoadingState extends HomeStates {}

class AddSupervsorErrorStates extends HomeStates {
  final String error;
  AddSupervsorErrorStates(this.error);
}

class DeleteSupervsorSuccessStates extends HomeStates {}

class DeleteSupervsorLoadingState extends HomeStates {}

class DeletSupervsorErrorStates extends HomeStates {
  final String error;
  DeletSupervsorErrorStates(this.error);
}

class AddFriendSuccessStates extends HomeStates {}

class AddFriendLoadingState extends HomeStates {}

class AddFriendErrorStates extends HomeStates {
  final String error;
  AddFriendErrorStates(this.error);
}

class AddBlockListSuccessStates extends HomeStates {}

class AddBlockListLoadingState extends HomeStates {}

class AddBlockListErrorStates extends HomeStates {
  final String error;
  AddBlockListErrorStates(this.error);
}

class ShowFriendSuccessStates extends HomeStates {}

class ShowFriendLoadingState extends HomeStates {}

class ShowFriendErrorStates extends HomeStates {
  final String error;
  ShowFriendErrorStates(this.error);
}

class BlockListSuccessStates extends HomeStates {}

class BlockListLoadingState extends HomeStates {}

class BlockListErrorStates extends HomeStates {
  final String error;
  BlockListErrorStates(this.error);
}

class FriendRequestsSuccessStates extends HomeStates {}

class FriendRequestsLoadingState extends HomeStates {}

class FriendRequestsErrorStates extends HomeStates {
  final String error;
  FriendRequestsErrorStates(this.error);
}

class AddExpSuccessStates extends HomeStates {
  final AddExpModel addExpModel;
  AddExpSuccessStates(this.addExpModel);
}

class AddExpsLoadingState extends HomeStates {}

class AddExpErrorStates extends HomeStates {
  final String error;
  AddExpErrorStates(this.error);
}

class GetExpSuccessStates extends HomeStates {
  final GetUserExpModel getUserExpModel;
  GetExpSuccessStates(this.getUserExpModel);
}

class GetExpsLoadingState extends HomeStates {}

class GetExpErrorStates extends HomeStates {
  final String error;
  GetExpErrorStates(this.error);
}

class AcceptFriendRequestsSuccessStates extends HomeStates {}

class AcceptFriendRequestsLoadingState extends HomeStates {}

class AcceptFriendRequestsErrorStates extends HomeStates {
  final String error;
  AcceptFriendRequestsErrorStates(this.error);
}

class DeleteFriendRequestsSuccessStates extends HomeStates {}

class DeleteFriendRequestsLoadingState extends HomeStates {}

class DeleteFriendRequestsErrorStates extends HomeStates {
  final String error;
  DeleteFriendRequestsErrorStates(this.error);
}

class DeleteBlockListSuccessStates extends HomeStates {}

class DeleteBlockListLoadingState extends HomeStates {}

class DeleteBlockListErrorStates extends HomeStates {
  final String error;
  DeleteBlockListErrorStates(this.error);
}

class UserInroomSuccessStates extends HomeStates {}

class UsersInroomErrorState extends HomeStates {}

class LoginRoomSuccessStates extends HomeStates {}

class LoginRoomErrorState extends HomeStates {
  final String error;
  LoginRoomErrorState(this.error);
}
