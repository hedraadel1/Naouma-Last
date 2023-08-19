import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/dioHelper.dart';
import 'package:project/endpoint.dart';
import 'package:project/models/search_model.dart';
import 'package:project/models/userSearch_model.dart';
import 'package:project/utils/constants.dart';
import 'package:project/view/search/states.dart';

class SearchScreenCubit extends Cubit<SearchAppStates> {
  SearchScreenCubit() : super(SearchcubitIntialStates());
  static SearchScreenCubit get(context) => BlocProvider.of(context);

  SearchModel searchModel;

  void search({String roomId}) {
    emit(SearchLoadingState());
    DioHelper.postdata(
            url: searchroom,
            data: {
              'room_id': roomId,
            },
            token: token)
        .then((value) {
      print(value.data);
      searchModel = SearchModel.fromJson(value.data);

      emit(SearchSuccessStates());
    }).catchError((error) {
      emit(SearchErrorStates(error.toString()));
    });
  }

  UserSearchModel userSearchModel;
  void Usersearch({String userId}) {
    emit(UserSearchLoadingState());
    DioHelper.postdata(
            url: usersearch,
            data: {
              'user_id': userId,
            },
            token: token)
        .then((value) {
      print(value.data);
      userSearchModel = UserSearchModel.fromJson(value.data);

      emit(UserSearchSuccessStates());
    }).catchError((error) {
      emit(UserSearchErrorStates(error.toString()));
    });
  }

  // UserSearchModel userSearchModel;
  // void RoomUserFollow({String userId}) {
  //   emit(RoomUserFollowLoadingState());
  //   DioHelper.postdata(
  //           url: usersearch,
  //           data: {
  //             'user_id': userId,
  //           },
  //           token: token)
  //       .then((value) {
  //     print(value.data);
  //     userSearchModel = UserSearchModel.fromJson(value.data);

  //     emit(RoomUserFollowSuccessStates());
  //   }).catchError((error) {
  //     emit(RoomUserFollowErrorStates(error.toString()));
  //   });
  // }
}
