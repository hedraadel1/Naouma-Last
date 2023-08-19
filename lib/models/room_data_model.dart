import 'package:project/models/user_data_model.dart';
import 'package:project/utils/images.dart';

class RoomDataModel {
  final String id;
  final String name;
  final String image;
  final String roomDesc;
  final List<UserDataModel> users;
  final int speakerCount;
  final String roomOwnerId;

  RoomDataModel(
      {this.id,
      this.name,
      this.image,
      this.roomDesc,
      this.roomOwnerId,
      this.users,
      this.speakerCount});

  factory RoomDataModel.fromJson(json) {
    return RoomDataModel(
      name: json['name'],
      roomOwnerId: json['roomOwnerId'],
      users: json['users'].map<UserDataModel>((userDataModel) {
        return UserDataModel(
          id: userDataModel['id'],
          name: userDataModel['name'],
          phone: userDataModel['phone'],
          email: userDataModel['email'],
          image: userDataModel['image'],
        );
      }).toList(),
      speakerCount: json['speakerCount'],
    );
  }
}

List<RoomDataModel> roomsList = [
  RoomDataModel(
      id: "11",
      name: "نعومة جروب",
      image: kRoomImage,
      roomOwnerId: "0Fz5SnlyExQxQHhC2rU9DR0d3Vl1",
      roomDesc: "نعومة نحكي نعومة نحكي نعومة نحكي ",
      users: []),
  RoomDataModel(
      id: "114",
      name: "كورة اون لاين",
      image: kDefaultProfileImage,
      roomOwnerId: "dddsds",
      roomDesc: "يلا نحكي يلا نحكي يلا نحكي",
      users: []),
];
