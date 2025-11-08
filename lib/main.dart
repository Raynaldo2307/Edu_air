import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Import your custom theme and screens
import 'package:edu_air/src/core/app_theme.dart';
import 'package:edu_air/src/features/splash_page/splash_screen.dart';
import 'package:edu_air/src/features/onboard_page/onboard_screen.dart';
import 'package:edu_air/src/features/home_page/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduAIR',
      debugShowCheckedModeBanner: false,
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
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/onboarding': (context) => const OnboardingPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
