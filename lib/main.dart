import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_piece/core/shared_preferences/shared_preferences.dart';
import 'features/splash/presentation/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //     options: FirebaseOptions(
  //       apiKey: 'AIzaSyDNY1Px8extCrMcFk2s9hGIDiCg29C0Auw',
  //       appId: 'medical_piece-guard-e1480',
  //       messagingSenderId: 'sendid',
  //       projectId: 'medical_piece-guard-e1480',
  //       storageBucket: 'medical_piece-guard-e1480.firebasestorage.app',
  //     )
  // );
  // await AppSettingsPreferences.init();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medical Piece',
      // theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(),
    );
  }
}
