// import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;
// import 'dart:convert';
// import 'package:naouma/models/state_model.dart';
// import 'package:naouma/onlineDatabase/laravel_impl.dart';
// import 'package:naouma/utils/common_functions.dart';
// import 'package:naouma/utils/constants.dart';
// import 'package:naouma/utils/preferences_services.dart';
// import 'package:naouma/view/home/home_screen.dart';
// import 'package:naouma/view/login/login_view.dart';

// class AuthController extends GetxController {
//   String name, loginEmail, registerEmail, password;
//   TextEditingController phoneNumberController;
//   TextEditingController passwordController;
//   TextEditingController nameController;
//   TextEditingController signEmailController;
//   TextEditingController signPasswordController;
//   TextEditingController conPassController;

//   // LOADING
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
//   updateIsLoading(bool value) {
//     _isLoading = value;
//     update();
//   }

//   FirebaseAuth auth = FirebaseAuth.instance;

//   final _loginFormKey = GlobalKey<FormState>();
//   GlobalKey<FormState> get loginFormKey => _loginFormKey;

//   final _signFormKey = GlobalKey<FormState>();
//   GlobalKey<FormState> get signFormKey => _signFormKey;

//   List<StateModel> countries = [
//     StateModel(id: 1, name: "مصر", image: ""),
//     StateModel(id: 1, name: "السعودية", image: ""),
//     StateModel(id: 1, name: "الكويت", image: ""),
//   ];

//   StateModel _selectedState;
//   StateModel get selectedState => _selectedState;

//   String phone = "";

//   void updateSelectedState(StateModel state) {
//     _selectedState = state;
//     update();
//   }

//   void login() async {
//     // if(phone.length==0){
//     //   CommonFunctions.showToast("ادخل رقم الهاتف اولا!", Colors.red);
//     //   return;
//     // }else if(_selectedState == null){
//     //   CommonFunctions.showToast("اختر المدينة اولا!", Colors.red);
//     //   return;
//     // }else {
//     //   print("Login Now...");
//     //   print("phoneNum: $phone");
//     //   Map<String, dynamic> jsonData = await LaravelImpl().signInWithPhone(phone: phone);
//     //
//     // }
//     updateIsLoading(true);
//     try {
//       UserCredential userCredential = await auth.signInWithEmailAndPassword(
//         email: loginEmail,
//         password: password,
//       );
//       User user = userCredential.user;
//       updateIsLoading(false);
//       if (user != null) {
//         print("${user.uid}");
//         print("${user.email}");
//         print("${user.displayName}");
//         PreferencesServices.setBool(IS_LOGIN, true);
//         PreferencesServices.setString(ID_KEY, user.uid);
//         PreferencesServices.setString(Email_KEY, user.email);
//         PreferencesServices.setString(Name_KEY, user.displayName);
//         CommonFunctions.showToast("login successfully", Colors.greenAccent);
//         Get.to(HomeScreen(),
//             duration: Duration(milliseconds: 1000),
//             transition: Transition.leftToRightWithFade);
//       }
//     } on FirebaseAuthException catch (e) {
//       updateIsLoading(false);
//       if (e.code == 'user-not-found') {
//         CommonFunctions.showToast("user not found", Colors.red);
//         print('No user found for that email.');
//       } else if (e.code == 'wrong-password') {
//         CommonFunctions.showToast("Wrong email or password", Colors.red);
//         print('Wrong password provided.');
//       }
//     }
//   }

//   void signUp() async {
//     updateIsLoading(true);
//     try {
//       UserCredential userCredential = await auth.createUserWithEmailAndPassword(
//         email: registerEmail,
//         password: password,
//       );
//       User _user = userCredential.user;
//       await _user.updateProfile(displayName: name);
//       await _user.reload();
//       _user = auth.currentUser;
//       updateIsLoading(false);
//       CommonFunctions.showToast("signUp successfully", Colors.greenAccent);
//       Get.off(LoginView(),
//           duration: Duration(milliseconds: 1000),
//           transition: Transition.leftToRightWithFade);
//     } on FirebaseAuthException catch (e) {
//       updateIsLoading(false);
//       if (e.code == 'weak-password') {
//         CommonFunctions.showToast(
//             "The password provided is too weak", Colors.greenAccent);
//         print('The password provided is too weak.');
//       } else if (e.code == 'email-already-in-use') {
//         print('The account already exists for that email.');
//         CommonFunctions.showToast(
//             "This email already exists", Colors.greenAccent);
//       }
//     } catch (e) {
//       updateIsLoading(false);
//       print(e);
//     }
//   }

//   void getCountries() async {
//     Map<String, dynamic> jsonData = await LaravelImpl().getCities();
//   }

//   void getUserInfo(String token) async {
//     Map<String, dynamic> jsonData =
//         await LaravelImpl().getUserInfo(token: token);
//   }

//   void updateUserData(String token, File image, String gender, String birthdate,
//       String city) async {
//     Map<String, dynamic> jsonData = await LaravelImpl().updateUserInfo(
//         token: token,
//         userImage: image,
//         gender: gender,
//         city: city,
//         birthDate: birthdate);
//   }

//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     // COUNTRIES
//     // getCountries();
//     phoneNumberController = TextEditingController()..text = registerEmail ?? "";
//     passwordController = TextEditingController()..text = password ?? "";
//     nameController = TextEditingController();
//     signEmailController = TextEditingController();
//     signPasswordController = TextEditingController();
//   }
// }
