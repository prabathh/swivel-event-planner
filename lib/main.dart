import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_screen.dart';
import 'package:event_planner_app/config/app_config.dart';
import 'package:event_planner_app/config/colors.dart';

void main() async {
  // Firebase initialization
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: Config.apiKey,
      appId: Config.appId,
      messagingSenderId: Config.messagingSenderId,
      projectId: Config.projectId,
    ),
  );

  // Run the app with Riverpod state management
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp setup with the home screen as LoginScreen
    return MaterialApp(
      title: 'Practical Assignment',
      theme: ThemeData(
        //primarySwatch: Colors.blue,
        fontFamily: 'Noto Sans',
        scaffoldBackgroundColor: AppColors.backgroundColor,
      ),
      // Initial screen is LoginScreen
      home: const LoginScreen(),
    );
  }
}
