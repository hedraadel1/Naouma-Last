/*
 * Copyright (c) 2023. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:project/network/cache_helper.dart';

// import 'package:mime/mime.dart';
// import 'package:dsio/dio.dart';

import 'package:project/utils/constants.dart';

// import 'package:project/constants.dart';
import 'package:project/dioHelper.dart';
import 'package:project/endpoint.dart';
import 'package:project/models/accept_request_model.dart';
import 'package:project/models/addBlockList_model.dart';
import 'package:project/models/blockList_model.dart.dart';
import 'package:project/models/create_room_model.dart';
import 'package:project/models/create_user_model.dart';
import 'package:project/models/deleteFriend_model.dart';
import 'package:project/models/firebase_room_model.dart';
import 'package:project/models/follow_room_model.dart';
import 'package:project/models/friendRequest_model.dart';
import 'package:project/models/getMyroom_model.dart';
import 'package:project/models/get_user_exp_model.dart';
import 'package:project/models/get_wallet_model.dart';
import 'package:project/models/gift_model.dart';
import 'package:project/models/inRoomUser_model.dart';
import 'package:project/models/mics_model.dart';
import 'package:project/models/myroomCheck_model.dart';
import 'package:project/models/oneMessage_model.dart';
import 'package:project/models/post_wallet_model.dart';
import 'package:project/models/roomUser.dart';
import 'package:project/models/room_data_model.dart';
import 'package:project/models/room_index.dart';
import 'package:project/models/room_user_model.dart';
import 'package:project/models/send_gift_model.dart';
import 'package:project/models/show_friends_model.dart';
import 'package:project/models/unfollow_model.dart';
import 'package:project/models/user_data_model.dart';
import 'package:project/models/user_mic_model.dart';
import 'package:project/utils/constants.dart';
import 'package:project/utils/preferences_services.dart';
import 'package:project/view/home/home_screen.dart';
import 'package:project/view/home/states.dart';

import '../../auth_model.dart';
import '../../common_functions.dart';
import '../../models/IsFollow_model.dart';
import '../../models/addExperience_model.dart';
import '../../models/addFriends_model.dart';
import '../../models/addSupervisor_model.dart';
import '../../models/isFriend_model.dart';
import '../../models/notification_model.dart';
import '../../models/profileGifts_model.dart';
import '../../models/users_following_room_model.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeIntialStates());

  static HomeCubit get(context) => BlocProvider.of(context);
  static Dio dio;

  CreateRoomModel createRoomModel;

  void createroom({roomname, roomdesc}) {
    emit(HomeLoadingState());

    DioHelper.postdata(
        url: roomstore,
        token: token,
        data: {'room_name': roomname, 'room_desc': roomdesc}).then((value) {
      print(value.data);

      createRoomModel = CreateRoomModel.fromJson(value.data);
      userCreate(
          roomName: roomname,
          roomDesc: roomdesc,
          roomid: createRoomModel.data.id.toString());
      emit(HomeSuccessStates());
    }).catchError((error) {
      emit(HomeErrorStates(error.toString()));
    });
  }

  void userCreate(
      {@required String roomName,
      @required String roomDesc,
      @required String roomid}) {
    RoomModel model =
        RoomModel(roomname: roomName, roomDesc: roomDesc, roomID: roomid);
    FirebaseFirestore.instance
        .collection('rooms')
        .doc(roomid)
        .set(
          model.toMap(),
        )
        .then((value) {
      //add success
      emit(CreateroomSuccessStates());
      // _addMicsToFirebase(roomid);
      print("add Room success");
      // print("id: ${value.id}");
      // print(value.toString());
      CommonFunctions.showToast("تم انشاء غرفة بنجاح", Colors.greenAccent);
      // Get.to(HomeScreen());
      // Get.offAll(HomeScreen(),
      //     duration: Duration(milliseconds: 1000),
      //     transition: Transition.leftToRightWithFade);
    }).catchError((error) {
      emit(CreateroomErrorState());
    });
  }

  // void _addMicsToFirebase(String roomID) async {
  //   // await _firestoreInstance.collection('roomUsers')
  //   //     .doc(roomID).collection(roomID).doc().delete();
  //   List<UserMicModel> _micsList = [];

  //   _micsList.add(UserMicModel(
  //       id: null,
  //       userId: null,
  //       userName: null,
  //       isLocked: false,
  //       roomOwnerId: PreferencesServices.getString(ID_KEY),
  //       micNumber: 0,
  //       micStatus: false));
  //   _micsList.add(UserMicModel(
  //       id: null,
  //       userId: null,
  //       userName: null,
  //       isLocked: false,
  //       roomOwnerId: PreferencesServices.getString(ID_KEY),
  //       micNumber: 1,
  //       micStatus: false));
  //   _micsList.add(UserMicModel(
  //       id: null,
  //       userId: null,
  //       userName: null,
  //       isLocked: false,
  //       roomOwnerId: PreferencesServices.getString(ID_KEY),
  //       micNumber: 2,
  //       micStatus: false));
  //   _micsList.add(UserMicModel(
  //       id: null,
  //       userId: null,
  //       userName: null,
  //       isLocked: false,
  //       roomOwnerId: PreferencesServices.getString(ID_KEY),
  //       micNumber: 3,
  //       micStatus: false));
  //   _micsList.add(UserMicModel(
  //       id: null,
  //       userId: null,
  //       userName: null,
  //       isLocked: false,
  //       roomOwnerId: PreferencesServices.getString(ID_KEY),
  //       micNumber: 4,
  //       micStatus: false));
  //   CollectionReference _collectionRef = FirebaseFirestore.instance
  //       .collection('roomUsers')
  //       .doc(roomID)
  //       .collection(roomID);
  //   await _collectionRef
  //       .doc(_micsList[0].micNumber.toString())
  //       .set(_micsList[0].toJson());
  //   await _collectionRef
  //       .doc(_micsList[1].micNumber.toString())
  //       .set(_micsList[1].toJson());
  //   await _collectionRef
  //       .doc(_micsList[2].micNumber.toString())
  //       .set(_micsList[2].toJson());
  //   await _collectionRef
  //       .doc(_micsList[3].micNumber.toString())
  //       .set(_micsList[3].toJson());
  //   await _collectionRef
  //       .doc(_micsList[4].micNumber.toString())
  //       .set(_micsList[4].toJson());
  //   _micsList.forEach((element) async {
  //     await _collectionRef
  //         .doc("${_micsList.indexOf(element)}")
  //         .set(element.toJson());
  //   });
  // }

  GetMyRoomModel getMyRoomModel;

  void getmyroom() {
    emit(GetMyRoomLoadingState());

    DioHelper.getdata(url: getroom, token: token).then((value) {
      getMyRoomModel = GetMyRoomModel.fromJson(value.data);
      print(value.data);

      emit(GetMyRoomSuccessStates());
    }).catchError((error) {
      emit(GetMyRoomErrorStates("Error In getmyroom" + error.toString()));
    });
  }

  RoomIndexModel roomIndexModel;

  void getCategory() {
    DioHelper.getdata(url: roomstore, token: token).then((value) {
      roomIndexModel = RoomIndexModel.fromJson(value.data);
      print(value.data);
      emit(JoinedSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(JoinedErrorStates());
    });
  }

  void pageniaton() {
    return getCategory();
  }

  GetWalletModel getWalletModel;

  void getWalletAmount() {
    DioHelper.getdata(
            url: "$getwallet/${CacheHelper.getData(key: 'id')}", token: token)
        .then((value) {
      getWalletModel = GetWalletModel.fromJson(value.data);
      print(value.data);
      emit(GetWalletSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(GetWalletErrorStates());
    });
  }

  PostWalletModel postWalletModel;

  void postWallet({@required amount}) {
    emit(WalletLoadingState());
    DioHelper.postdata(url: postwallet, token: token, data: {'amount': amount})
        .then((value) {
      print(value.data);
      postWalletModel = PostWalletModel.fromJson(value.data);

      emit(WalletSuccessStates());
    }).catchError((error) {
      emit(WalletErrorStates(error.toString()));
    });
  }

  GiftModel giftModel;

  Future<void> getGift() {
    DioHelper.getdata(url: gift, token: token).then((value) {
      giftModel = GiftModel.fromJson(value.data);
      print(value.data);
      emit(GetGiftSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(GetGiftErrorStates());
    });
  }

  CreateUserModel createUserModel;

  AuthModel usermodel;
  List<CreateUserModel> users = [];

  void getusers() {
    // if (users.length == 0)
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uid'] != senderId)
          // print(createUserModel.uid);
          users.add(CreateUserModel.fromJson(element.data()));
      });
      emit(GetallUsersSuccessStates());
      print("ok");
    }).catchError((error) {
      emit(GetallUsersErrorState(error.toString()));
    });
  }

  void sendmassege({
    @required String receverId,
    @required String datatime,
    @required String text,
  }) {
    OneMasseageModel model = OneMasseageModel(
        text: text,
        datatime: datatime,
        reciverId: receverId,
        senderId: senderId);
    print(receverId);

    FirebaseFirestore.instance
        .collection('users')
        .doc(senderId)
        .collection('chats')
        .doc(receverId)
        .collection('masseges')
        .add(model.toMap())
        .then((value) {
      emit(SendMassegesSuccessStates());
    }).catchError((error) {
      emit(SendMassegesErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receverId)
        .collection('chats')
        .doc(senderId)
        .collection('masseges')
        .add(model.toMap())
        .then((value) {
      emit(SendMassegesSuccessStates());
    }).catchError((error) {
      emit(SendMassegesErrorState());
    });
  }

  List<OneMasseageModel> masseges = [];

  void getmasseges({@required String receverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(senderId)
        .collection('chats')
        .doc(receverId)
        .collection('masseges')
        .orderBy('datatime')
        .snapshots()
        .listen((event) {
      masseges = [];
      print(masseges);
      event.docs.forEach((element) {
        masseges.add(OneMasseageModel.fromJson(element.data()));
      });

      emit(GetMessageSuccessStates());
    });
    //     .orderBy('datetime')
    //     .snapshots()
    //     .listen((event) {
    //   masseges = [];
    //   print(masseges);
    //   event.docs.forEach((element) {
    //     masseges.add(OneMasseageModel.fromJson(element.data()));
    //   });

    //   emit(GetMessageSuccessStates());
    // });
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

  void addfirendFirebase({
    @required String receverId,
    @required String name,
  }) {
    IsFriendFirebaseModel model = IsFriendFirebaseModel(
      isfriend: true,
      reciverId: receverId,
      senderId: senderId,
    );
    print(receverId);

    var documentReference = FirebaseFirestore.instance
        .collection('users')
        .doc(senderId)
        .collection('friends')
        .doc(receverId);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        {
          // 'username': username,
          'username': name,
          'userID': receverId,
          'isFriend': true
          // 'roomId': roomid,
          // 'state': state
          // 'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
          // 'content': content,
          // 'type': type,
          // 'userLevel': userCurrentlevel,
          // 'ApiUserID': userId
        },
      );
    });
    // .add(model.toMap())
    //     .then((value) {
    //   emit(SendMassegesSuccessStates());
    // }).catchError((error) {
    //   emit(SendMassegesErrorState());
    // });

    var documentReferencee = FirebaseFirestore.instance
        .collection('users')
        .doc(receverId)
        .collection('friends')
        .doc(senderId);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        documentReferencee,
        {
          // 'username': username,
          'username': username,
          'userID': senderId,
          'isFriend': true
          // 'roomId': roomid,
          // 'state': state
          // 'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
          // 'content': content,
          // 'type': type,
          // 'userLevel': userCurrentlevel,
          // 'ApiUserID': userId
        },
      );
    });

    // FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(receverId)
    //     .collection('friends')
    //     .add(model.toMap())
    //     .then((value) {
    //   emit(SendMassegesSuccessStates());
    // }).catchError((error) {
    //   emit(SendMassegesErrorState());
    // });
  }

  NotificationModel notificationModel;

  void getnotification({@required id, @required password}) {
    print(id);
    DioHelper.postdata(
      url: 'getNotification?room_id=/$id',
      token: token,
      data: {
        'room_id': id,
      },
    ).then((value) {
      print(value.data);
      notificationModel = NotificationModel.fromJson(value.data);
      // print(notificationModel.shopid);
      print("getnotification() Has been Complete and data is " +
          value.data +
          "--- Hedra Adel ---");

      emit(NotificationSuccessStates());
    }).catchError((error) {
      print("Error in getnotification In homeCubit" + error.toString());
      emit(NotificationErrorState());
    });
  }

  void logoutUserRoom({@required id}) {
    print(id);
    DioHelper.getdata(url: 'rooms/$id/logout', token: token).then((value) {
      print(value.data);
    }).catchError((error) {
      print(error.toString());
    });
  }

  void patchfcmtoken({
    @required fcmtoken,
  }) {
    DioHelper.postdata(
            url: fcmtokenUrl,
            data: {
              'fcm_token': fcm_token,
            },
            token: token)
        .then((value) {
      print(value.data);

      emit(FcmSuccessStates());
      // emit(ShopRegisterSuccessStates(RegisterModel));
    }).catchError((error) {
      emit(FcmErrorState(error.toString()));
    });
  }

  InRoomUserModelModel roomUserModel;

  List<InRoomUserModelModel> userList = [];

  void getroomuser({@required id}) {
    emit(InroomLoadingStates());

    DioHelper.getdata(url: 'get-room-followers/$id', token: token)
        .then((value) {
      roomUserModel = InRoomUserModelModel.fromJson(value.data);

      print("getroomuser() Has been Complete and data is " +
          value.data +
          "--- Hedra Adel ---");

      for (int i = 0; i < roomUserModel.data.length; i++) {
        if (apiid == roomUserModel.data[i].userId.toString()) {
          print("roomUserModel apiid is " +
              apiid.toString() +
              "--- Hedra Adel ---");
          userstateInroom = roomUserModel.data[i].typeUser;
          specialId = roomUserModel.data[i].spacialId;
          nameOFPackage = roomUserModel.data[i].package.first.name;
          packageColor = roomUserModel.data[i].package.first.color;
          packagebadge = roomUserModel.data[i].package.first.url;

          if (roomUserModel.data[i].isPurchaseId == true) {
            hasSpecialID = true;
          } else {
            hasSpecialID = false;
          }
        }
      }

      for (int i = 0; i < roomUserModel.data.length; i++) {
        roomUsersNow(
            username: roomUserModel.data[i].name,
            roomid: id,
            state: true,
            userid: roomUserModel.data[i].spacialId);
      }

      emit(InroomSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(InroomErrorState());
    });
  }

  void roomUsersNow({
    @required String username,
    @required String roomid,
    @required String userid,
    @required bool state,
  }) {
    RoomModel model = RoomModel(roomID: roomid);
    if (ismuted = null) {
      ismuted = true;
    }
    var documentReference = FirebaseFirestore.instance
        .collection('UsersInRoom')
        .doc(roomid)
        .collection(roomid)
        .doc(userid);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        {
          'username': username,
          'userID': userid,
          'roomId': roomid,
          'state': state
          // 'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
          // 'content': content,
          // 'type': type,
          // 'userLevel': userCurrentlevel,
          // 'ApiUserID': userId
        },
      );
    });
    FirebaseFirestore.instance
        .collection('rooms')
        .doc(roomid)
        .set(
          model.toMap(),
        )
        .then((value) {
      //add success
      emit(UserInroomSuccessStates());
      // _addMicsToFirebase(roomid);
      print("add Room success");
      // print("id: ${value.id}");
      // print(value.toString());

      // Get.to(HomeScreen());
      // Get.offAll(HomeScreen(),
      //     duration: Duration(milliseconds: 1000),
      //     transition: Transition.leftToRightWithFade);
    }).catchError((error) {
      emit(UsersInroomErrorState());
    });
  }

  SendgiftModel sendGiftModel;

  void sendgift(
      {@required id,
      @required type,
      @required received,
      @required giftid,
      @required count}) {
    emit(SendGiftLoadingState());
    print(type);

    DioHelper.postdata(
            url: 'room/$id/send-gift/$giftid',
            token: token,
            data: {'type': type, 'received': received, 'count': count})
        .then((value) {
      sendGiftModel = SendgiftModel.fromJson(value.data);

      showgift = sendGiftModel.data.user.entry;
      print(value.data);

      emit(SendGiftSuccessStates());
      print('send');
    }).catchError((error) {
      emit(SendGiftErrorStates(error.toString()));
    });
  }

  IsFollowModel isFollowModel;
  Map<int, bool> isfollow = {};

  void followroom({
    @required id,
  }) {
    emit(FollowLoadingState());

    DioHelper.postdata(url: 'follow-room/$id', token: token, data: {})
        .then((value) {
      isFollowModel = IsFollowModel.fromJson(value.data);
      print(value.data);

      emit(FollowSuccessStates());
    }).catchError((error) {
      emit(FollowErrorStates(error.toString()));
    });
  }

  FollowModel followModel;

  void followingroom() {
    emit(FollowingLoadingState());

    DioHelper.getdata(url: getroom, token: token).then((value) {
      followModel = FollowModel.fromJson(value.data);
      print(value.data);
      emit(FollowingSuccessStates());
    }).catchError((error) {
      emit(FollowingErrorStates(error.toString()));
    });
  }

  UserFollowingRoomModel userFollowingRoomModel;

  void usersfollowingroom({@required id}) {
    emit(UsersFollowingLoadingState());

    DioHelper.getdata(url: 'get-room-followers/$id', token: token)
        .then((value) {
      userFollowingRoomModel = UserFollowingRoomModel.fromJson(value.data);
      print("usersfollowingroom() Has been Complete and data is " +
          value.data +
          "--- Hedra Adel ---");

      print(value.data);

      for (int i = 0;
          i < userFollowingRoomModel.data.first.followers.length;
          i++) {
        if (specialId ==
            userFollowingRoomModel.data.first.followers[i].userId) {
          print('${userFollowingRoomModel.data.first.followers[i].userId}');
          iFollow = true;
        } else {
          iFollow = false;
        }
        allUserFollowRoom = userFollowingRoomModel.data.first.followers.length;
      }

      emit(UsersFollowingSuccessStates());
    }).catchError((error) {
      emit(UsersFollowingErrorStates(error.toString()));
    });
  }

  AddSupervsorModel addSupervsorModel;

  void postSupervsorroom({@required id}) {
    emit(AddSupervsorLoadingState());

    DioHelper.postdata(url: 'supervisor-add/$id', token: token, data: {})
        .then((value) {
      addSupervsorModel = AddSupervsorModel.fromJson(value.data);

      print(value.data);

      emit(AddSupervsorSuccessStates());
    }).catchError((error) {
      emit(AddSupervsorErrorStates(error.toString()));
    });
  }

  AddSupervsorModel aaddSupervsorModel;

  void deleteSupervsorroom({@required id}) {
    emit(DeleteSupervsorLoadingState());

    DioHelper.deletedata(url: 'supervisor-delete/$id', token: token, data: {})
        .then((value) {
      aaddSupervsorModel = AddSupervsorModel.fromJson(value.data);

      print(value.data);

      emit(DeleteSupervsorSuccessStates());
    }).catchError((error) {
      emit(DeletSupervsorErrorStates(error.toString()));
    });
  }

  MyroomCheckModel myroomCheckModel;

  void myroomcheckroom() {
    emit(MyroomCheckLoadingState());

    DioHelper.getdata(url: MyFollowedRooms, token: token).then((value) {
      myroomCheckModel = MyroomCheckModel.fromJson(value.data);
      print(value.data);
      emit(MyroomCheckSuccessStates());
    }).catchError((error) {
      emit(MyroomCheckErrorStates(error.toString()));
    });
  }

  MicModel micModel;

  void joinmics({
    @required id,
    @required micsnumber,
  }) {
    DioHelper.postdata(
            url: 'room/$id/setmic/$micsnumber', data: {}, token: token)
        .then((value) {
      // micModel = MicModel.fromJson(value.data);

      // print(value.data);

      emit(JoinmicSuccessStates());
      print('succes');
      // emit(ShopRegisterSuccessStates(RegisterModel));
    }).catchError((error) {
      emit(JoinmicsErrorStates(error.toString()));
    });
  }

  AddfriendsModel addfriendsModel;

  void addfriend({
    @required id,
  }) {
    DioHelper.postdata(url: 'addfriend/$id', data: {}, token: token)
        .then((value) {
      addfriendsModel = AddfriendsModel.fromJson(value.data);
      print(value.data);
      CommonFunctions.showToast("تم ارسال طلب الصداقة", Colors.green);
      emit(AddFriendSuccessStates());
      // print('succes');
      // emit(ShopRegisterSuccessStates(RegisterModel));
    }).catchError((error) {
      emit(AddFriendErrorStates(error.toString()));
    });
  }

  ShowFriendsModel showFriendsModel;

  void showfriends() {
    emit(ShowFriendLoadingState());

    DioHelper.getdata(url: showfriend, token: token).then((value) {
      showFriendsModel = ShowFriendsModel.fromJson(value.data);
      print(value.data);

      emit(ShowFriendSuccessStates());
    }).catchError((error) {
      emit(ShowFriendErrorStates(error.toString()));
    });
  }

  FriendRequestsModel friendRequestsModel;

  void getfriendRequests() {
    emit(FriendRequestsLoadingState());

    DioHelper.getdata(url: friendsrequest, token: token).then((value) {
      friendRequestsModel = FriendRequestsModel.fromJson(value.data);
      print(value.data);

      emit(FriendRequestsSuccessStates());
    }).catchError((error) {
      emit(FriendRequestsErrorStates(error.toString()));
    });
  }

  AcceptRequestsModel acceptRequestsModel;

  void acceptfriendrequest({
    @required id,
  }) {
    emit(AcceptFriendRequestsLoadingState());

    DioHelper.postdata(
            url: acceptrequest, data: {'friend_id': id}, token: token)
        .then((value) {
      acceptRequestsModel = AcceptRequestsModel.fromJson(value.data);

      print(value.data);

      emit(AcceptFriendRequestsSuccessStates());
      print('succes');
      // emit(ShopRegisterSuccessStates(RegisterModel));
    }).catchError((error) {
      emit(AcceptFriendRequestsErrorStates(error.toString()));
    });
  }

  DeleteFriendModel deleteFriendModel;

  void deletefriend({
    @required id,
  }) {
    emit(DeleteFriendRequestsLoadingState());
    print(id);
    DioHelper.deletedata(
            url: deleterequest, data: {'friend_id': id}, token: token)
        .then((value) {
      deleteFriendModel = DeleteFriendModel.fromJson(value.data);

      print(value.data);

      emit(DeleteFriendRequestsSuccessStates());
      print('delte');
      // emit(ShopRegisterSuccessStates(RegisterModel));
    }).catchError((error) {
      emit(DeleteFriendRequestsErrorStates(error.toString()));
    });
  }

  AddExpModel addExpModel;

  void addExperience({int exp}) {
    emit(AddExpsLoadingState());

    DioHelper.postdata(url: addExp, data: {'exp': exp}, token: token)
        .then((value) {
      addExpModel = AddExpModel.fromJson(value.data);

      print(value.data);

      emit(AddExpSuccessStates(addExpModel));

      // emit(ShopRegisterSuccessStates(RegisterModel));
    }).catchError((error) {
      emit(AddExpErrorStates(error.toString()));
    });
  }

  GetUserExpModel getUserExpModel;

  void getuserExp({@required id}) {
    emit(GetExpsLoadingState());

    DioHelper.getdata(url: 'getExpLevel/$id', token: token).then((value) {
      getUserExpModel = GetUserExpModel.fromJson(value.data);

      print(value.data);

      emit(GetExpSuccessStates(getUserExpModel));
    }).catchError((error) {
      print(error.toString());
      emit(GetExpErrorStates(error.toString()));
    });
  }

  // void editRoom(
  //     {@required name,
  //     @required roomdesc,
  //     @required countMics,
  //     @required supervisor,
  //     @required imagefile}) async {
  //   Blob blob = new Blob(imageFile.readAsBytesSync());
  //   print(blob.bytes);
  //   print(name);
  //   print(roomdesc);
  //   print(countMics);

  //   print(supervisor);
  //   print(imagefile);
  //   emit(EditRoomLoadingState());

  //   //  final mimeTypeData =
  //   //     lookupMimeType(imageFile.path, headerBytes: [0xFF, 0xD8]).split('/');
  //   //     FormData formData = FormData.fromMap({

  //   //       "image": await MultipartFile.fromFile(imageFile,
  //   //           contentType: MediaType(mimeTypeData[0], mimeTypeData[1])),
  //   //     });
  //   DioHelper.postdata(url: roomsetting, token: token, data: {
  //     'name': name,
  //     'room_desc': roomdesc,
  //     'countMics': countMics,
  //     'supervisor_lockmic_access': supervisor,
  //     'room_background': blob.bytes
  //   }).then((value) {
  //     print(value.data);

  //     emit(EditRoomSuccessStates());
  //     print('send');
  //   }).catchError((error) {
  //     emit(EditRoomErrorStates(error.toString()));
  //   });
  // }

  void editRoom({
    @required name,
    @required roomdesc,
    @required countMics,
    @required supervisor,
    @required imagefile,
    @required filename,
  }) async {
    print(name);
    print(roomdesc);
    print(countMics);

    print(supervisor);
    // print(imagefile);
    var formData = FormData.fromMap({
      "name": name,
      "room_desc": roomdesc,
      "countMics": countMics,
      "supervisor_lockmic_access": supervisor,
      "room_background": image != null
          ? await MultipartFile.fromFile(
              imageFile.path,
              filename: imagename,
              contentType: new MediaType("image", "jpeg"),
            )
          : "",
    });
    emit(EditRoomLoadingState());

    //  final mimeTypeData =
    //     lookupMimeType(imageFile.path, headerBytes: [0xFF, 0xD8]).split('/');
    //     FormData formData = FormData.fromMap({

    //       "image": await MultipartFile.fromFile(imageFile,
    //           contentType: MediaType(mimeTypeData[0], mimeTypeData[1])),
    //     });

    DioHelper.editroom(url: roomsetting, token: token, data: formData)
        .then((value) {
      print(value.data);

      emit(EditRoomSuccessStates());

      // emit(ShopRegisterSuccessStates(RegisterModel));
    }).catchError((error) {
      emit(EditRoomErrorStates(error.toString()));
    });
    // DioHelper.editroom(url: roomsetting, token: token, data: {
    //   'name': name,
    //   'room_desc': roomdesc,
    //   'countMics': countMics,
    //   'supervisor_lockmic_access': supervisor,
    //   'room_background': imagefile
    // }, roomname: null).then((value) {
    //   print(value.data);

    //   emit(EditRoomSuccessStates());
    //   print('send');
    // }).catchError((error) {
    //   emit(EditRoomErrorStates(error.toString()));
    // });
  }

  AddBlockListModel addBlockListModel;

  // Map<int, bool> isfollow = {};
  void addBlockList({
    @required id,
  }) {
    emit(AddBlockListLoadingState());

    DioHelper.postdata(url: 'room-blacklist/$id', token: token, data: {})
        .then((value) {
      addBlockListModel = AddBlockListModel.fromJson(value.data);
      print(value.data);

      emit(AddBlockListSuccessStates());
    }).catchError((error) {
      emit(AddBlockListErrorStates(error.toString()));
    });
  }

  BlockListModel userBlockListRoomModel;

  void getBlockList() {
    emit(BlockListLoadingState());

    DioHelper.getdata(url: roomBlackList, token: token).then((value) {
      userBlockListRoomModel = BlockListModel.fromJson(value.data);
      print(value.data);

      emit(BlockListSuccessStates());
    }).catchError((error) {
      emit(BlockListErrorStates(error.toString()));
    });
  }

  void loginroom(
      {@required String name,
      @required String phone,
      @required String roomid,
      String userid}) {
    InroomUserrModel model = InroomUserrModel(
      name: name,
      phone: phone,
      roomid: roomid,
    );
    var documentReference = FirebaseFirestore.instance
        .collection('UsersInRoom')
        .doc(roomid)
        .collection(roomid)
        .doc(userid);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        {
          // 'username': username,
          // 'idFrom': userid,
          // 'idTo': widget.roomId,
          // 'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
          // 'content': content,
          // 'type': type,
          // 'userLevel': userCurrentlevel,
          // 'ApiUserID': userId
        },
      );
    });

    // FirebaseFirestore.instance
    //     .collection('UsersInRoom')
    //     .doc(uid)
    //     .set(
    //       model.toMap(),
    //     )
    //     .then((value) {
    //   emit(LoginRoomSuccessStates());
    //   print("ok");
    // }).catchError((error) {
    //   emit(LoginRoomErrorState(error.toString()));
    // });
  }

  UnfollowUserModel unfollowUserModel;

  void postUnfollowser({@required idRoom, @required idUser}) {
    emit(UnfollowUserLoadingState());
    DioHelper.postdata(
        url: 'room/$idRoom/unfollow/$idUser',
        token: token,
        data: {}).then((value) {
      print(value.data);
      unfollowUserModel = UnfollowUserModel.fromJson(value.data);

      emit(UnfollowUserSuccessStates());
    }).catchError((error) {
      emit(UnfollowUserErrorStates(error.toString()));
    });
  }

  // DeleteFriendModel deleteFriendModel;
  void removeBlacklist({
    @required id,
  }) {
    emit(DeleteBlockListLoadingState());
    print(id);
    DioHelper.deletedata(url: 'room-blacklist/$id', data: {}, token: token)
        .then((value) {
      // deleteFriendModel = DeleteFriendModel.fromJson(value.data);

      print(value.data);

      emit(DeleteBlockListSuccessStates());
      // print('delte');
      // emit(ShopRegisterSuccessStates(RegisterModel));
    }).catchError((error) {
      emit(DeleteBlockListErrorStates(error.toString()));
    });
  }

  void setRoomPassword({@required roompassword}) {
    emit(SetPasswordRoomLoadingState());
    DioHelper.postdata(
        url: setLocks,
        token: token,
        data: {'password': roompassword}).then((value) {
      print(value.data);

      emit(SetPasswordRoomSuccessStates());
    }).catchError((error) {
      emit(SetPasswordRoomErrorStates(error.toString()));
    });
  }

// void leavemice(
//     // @required id,
//     // @required micsnumber,
//     ) {
//   // emit(JoinmicLoadingState());
//   DioHelper.postdata(url: 'room/2/un-setmic/1', data: {}, token: token)
//       .then((value) {
//     micModel = MicModel.fromJson(value.data);

//     print(value.data);

//     emit(JoinmicSuccessStates());
//     // emit(ShopRegisterSuccessStates(RegisterModel));
//   }).catchError((error) {
//     emit(JoinmicsErrorStates(error.toString()));
//   });
// }
}
