abstract class SearchAppStates {}

class SearchcubitIntialStates extends SearchAppStates {}

class SearchSuccessStates extends SearchAppStates {
  SearchSuccessStates();
}

class SearchLoadingState extends SearchAppStates {}

class SearchErrorStates extends SearchAppStates {
  final String error;
  SearchErrorStates(this.error);
}

class UserSearchSuccessStates extends SearchAppStates {
  UserSearchSuccessStates();
}

class UserSearchLoadingState extends SearchAppStates {}

class UserSearchErrorStates extends SearchAppStates {
  final String error;
  UserSearchErrorStates(this.error);
}

class RoomUserFollowSuccessStates extends SearchAppStates {
  RoomUserFollowSuccessStates();
}

class RoomUserFollowLoadingState extends SearchAppStates {}

class RoomUserFollowErrorStates extends SearchAppStates {
  final String error;
  RoomUserFollowErrorStates(this.error);
}
