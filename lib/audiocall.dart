// import 'package:agora_rtc_engine/rtc_engine.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/route_manager.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:project/appbrain.dart';

// class AudioCall extends StatefulWidget {
//   const AudioCall({Key key}) : super(key: key);

//   @override
//   State<AudioCall> createState() => _AudioCallState();
// }

// class _AudioCallState extends State<AudioCall> {
//   int _remoteUid;
//   RtcEngine _engine;

//   @override
//   void initState() {
//     initAgora();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }

//   Future<void> initAgora() async {
//     await [Permission.microphone, Permission.camera].request();
//     _engine = await RtcEngine.create(Agoramanager.GetAppId);
//     _engine.enableAudio();
//     _engine.setEventHandler(RtcEngineEventHandler(
//         joinChannelSuccess: (String channel, int uid, int elapsed) {
//       print('local user $uid  jioned successfuly');
//     }, userJoined: (int uid, int elapsed) {
//       print('remote user $uid  jioned successfuly');
//       setState(() {
//         _remoteUid = uid;
//       });
//     }, userOffline: (int uid, UserOfflineReason reason) {
//       print('remote user $uid left call');
//       setState(() {
//         Navigator.of(context).pop(true);
//       });
//     }));
//     await _engine.joinChannel(
//         Agoramanager.GetAgoraToken, Agoramanager.ChannelName, null, 0);
//   }
// }
