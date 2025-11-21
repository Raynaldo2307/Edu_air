import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Theme + Router
import 'package:edu_air/src/core/app_theme.dart';
import 'package:edu_air/src/shared/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduAIR',
      debugShowCheckedModeBanner: false,

      // ✅ App Theme
      theme: ThemeData(
        scaffoldBackgroundColor: AppTheme.white,
        primaryColor: AppTheme.primaryColor,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: AppTheme.textPrimary),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: AppTheme.white,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: AppTheme.accent,
        ),
      ),

      // ✅ Routing Starts Here
      initialRoute: '/',
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}