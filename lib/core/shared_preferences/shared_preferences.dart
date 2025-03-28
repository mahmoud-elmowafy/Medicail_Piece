//
//
// import 'package:shared_preferences/shared_preferences.dart';
//
// class AppSettingsPreferences {
//   AppSettingsPreferences._internal();
//
//   static SharedPreferences? sharedPreferences;
//
//   static init() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//   }
//   static final AppSettingsPreferences _instance =
//       AppSettingsPreferences._internal();
//
//   factory AppSettingsPreferences() {
//     return _instance;
//   }
//
//   Future<void> intiPreferences() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//   }
//
//   Future<void> saveOnBoardingScreenState({required String state}) async {
//     await  sharedPreferences!.setString('state', state);
//   }
//
//   String get state =>  sharedPreferences!.getString('state') ?? "0";
//
//   /******************************************************/
//
//   // Future<void> saveUser({required UserData user}) async {
//   //   sharedPreferences!.setString('id', user.id ?? "");
//   //    sharedPreferences!.setString('name', user.name ?? "");
//   //    sharedPreferences!.setString('email', user.email ?? "");
//   //   sharedPreferences!.setString('password', user.password ?? "");
//   //   sharedPreferences!.setBool('isGuest', false);
//   // }
//   Future<void> setOnboarding({required bool value}) async {
//     sharedPreferences!.setBool('isOnboarding', value);
//   }
//
//
//   // UserData user() {
//   //   UserData user = new UserData(
//   //       id:  sharedPreferences!.getString('id')!,
//   //       name:  sharedPreferences!.getString('name')!,
//   //       email:  sharedPreferences!.getString('email')!,
//   //       password:  sharedPreferences!.getString('password')!,
//   //   );
//   //
//   //   return user;
//   // }
//
//   Future<void> updateLoggedIn() async {
//     print( sharedPreferences!.getString('token'));
//     await  sharedPreferences!.setString('token', '');
//     await  sharedPreferences!.setString('id', '');
//     handleClearPrefs();
//     print( sharedPreferences!.getString('token'));
//   }
//
//   String get id =>  sharedPreferences!.getString('id') ?? '';
//   String get phoneNumber =>  sharedPreferences!.getString('phoneNumber') ?? '';
//   String get email =>  sharedPreferences!.getString('email') ?? '';
//   String get userType =>  sharedPreferences!.getString('userType') ?? '';
//   String get name =>  sharedPreferences!.getString('name') ?? '';
//   String get image =>  sharedPreferences!.getString('image') ?? '';
//   int get availableCups =>  sharedPreferences!.getInt('availableCups') ?? 0;
//   double get package1 =>  sharedPreferences!.getDouble('package1') ?? 0;
//   double get package2 =>  sharedPreferences!.getDouble('package2') ?? 0;
//   bool get isVerified =>  sharedPreferences!.getBool('isVerified') ?? false;
//   bool get isGuest =>  sharedPreferences!.getBool('isGuest') ?? false;
//   bool get isOnboarding =>  sharedPreferences!.getBool('isOnboarding') ?? false;
//
//   void handleClearPrefs() {
//      sharedPreferences!.clear();
//     print("true");
//   }
// }
