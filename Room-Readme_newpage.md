username: The username of the user who is viewing the room.
userID: The ID of the user who is viewing the room.
roomId: The ID of the room.
roomImage: The image of the room.
roomName: The name of the room.
roomDesc: The description of the room.
roomOwnerId: The ID of the owner of the room.
passwordRoom: The password for the room.
apiroomID: The API ID of the room.
role: The role of the user in the room.
_remoteUid: The ID of the remote user.
_engine: The Agora RtcEngine instance.
_users: A list of the users in the room.
_isSpeaking: A boolean indicating whether the user is speaking.
_client: The Agora RtmClient instance.
_channel: The Agora RtmChannel instance.
_subchannel: The Agora RtmChannel instance for the subchannel.
myChannel: The name of the channel.
_isChannelCreated: A boolean indicating whether the channel has been created.
_channelFieldController: A TextEditingController for the channel name field.
_messageController: A TextEditingController for the message field.
listScrollController: A ScrollController for the list of messages.
listMessage: A list of the messages in the room.
roomUsersList: A list of the users in the room.
_seniorMember: A map of the senior members in the room.
_channelList: A map of the channels in the room.
_micUsersList: A list of the users who have their microphones turned on.
_infoStrings: A list of the information strings.
groupChatId: The ID of the group chat.
roomID: The ID of the room.
_roomUsersCount: The number of users in the room.
_isLoadingMics: A boolean indicating whether the microphones are being loaded.
_isLogin: A boolean indicating whether the user is logged in.
_isInChannel: A boolean indicating whether the user is in the channel.
isHaveFrame: A string indicating whether the user has a frame.
mute: A boolean indicating whether the user is muted.
micnum: The number of microphones.
micIndex: The index of the microphone.
onmic: A boolean indicating whether the user is on the microphone.
check: A variable used for checking.
message: A variable used for messages.
background: A variable used for the background.
roomModel: A RoomModel instance.
totalnum: A variable used for the total number.
limit: The limit for the number of messages to load.
_firestoreInstance: A FirebaseFirestore instance.
_isRoomOnFirebase: A boolean indicating whether the room is on Firebase.
expmodel: An ExpModel instance.
snapshot: A DocumentSnapshot instance.
The class also has a number of methods, including:

initState(): This method is called when the widget is first created. It initializes the Agora
RtcEngine and sets up the event handlers.
dispose(): This method is called when the widget is destroyed. It destroys the Agora RtcEngine and
leaves the channel.
initialize(): This method initializes the Agora RtcEngine and joins the channel.
pickImage(): This method picks an image from the gallery or camera.
imagePicker(): This method shows a dialog to pick an image from the gallery or camera.
uploadImage(): This method uploads an image to Firebase Storage.
onSendMessage(): This method sends a message to the room.
readLocal(): This method reads the local data for the room.
checkRoomFoundOrNot(): This method checks if the room is found or not in the firestore and updates
the _isRoomOnFirebase bool variable.
The class also has a number of properties, including:

_users: A list of the users in the room.
_isSpeaking: A boolean indicating whether the user is speaking.
_client: The Agora RtmClient instance.
_channel: The Agora RtmChannel instance.
_subchannel: The Agora RtmChannel instance for the subchannel.
myChannel: The name of the channel.
_isChannelCreated: A boolean indicating whether the channel has been created.
_channelFieldController: A TextEditingController for the channel name field.
_messageController: A TextEditingController for the message field.
listScrollController: A ScrollController for the list of messages.
listMessage: A list of the messages in the room.
roomUsersList: A list of the users in the room.
_seniorMember: A map of the senior members in the room.
_channelList: A map of the channels in the room.
_micUsersList: A list of the users who have their microphones turned on.
_infoStrings: A list of the information strings.
groupChatId: The ID of the group chat.
roomID: The ID of the room.
_roomUsersCount: The number of users in the room.
_isLoadingMics: A boolean indicating whether the microphones are being loaded.
_isLogin: A boolean indicating whether the user is logged in.
_isInChannel: A boolean indicating whether the user is in the channel.
isHaveFrame: A string indicating whether the user has a frame.
mute: A boolean indicating whether the user is muted.
micnum: The number of microphones.
micIndex: The index of the microphone.
onmic: A boolean indicating whether the user is on the microphone.
check: A variable used for checking.
message: A variable used for messages.
background: A variable used for the background.
roomModel: A RoomModel instance.
totalnum: A variable used for the total number.
limit: The limit for the number of messages to load.
_firestoreInstance: A FirebaseFirestore instance.
_isRoomOnFirebase: A boolean indicating whether the room is on Firebase.
expmodel: An ExpModel instance.
snapshot: A DocumentSnapshot instance.
The class also has a number of methods, including:

initState(): This method is called when the widget is first created. It initializes the Agora
RtcEngine and sets up the event handlers.
dispose(): This method is called when the widget is destroyed. It destroys the Agora RtcEngine and
leaves the channel.
initialize(): This method initializes the Agora RtcEngine and joins the channel.
pickImage(): This method picks an image from the gallery or camera.
imagePicker(): This method shows a dialog to pick an image from the gallery or camera.
uploadImage(): This method uploads an image to Firebase Storage.
onSendMessage(): This method sends a message to the room.
readLocal(): This method reads the local data for the room.
checkRoomFoundOrNot(): This method checks if the room is found or not in the firestore and updates
the _isRoomOnFirebase bool variable.