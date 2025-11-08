import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:edu_air/src/core/app_theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    debugPrint("SplashPage: Splash screen loaded");

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      debugPrint("SplashPage: Navigating to /onboarding");
      Navigator.pushReplacementNamed(context, '/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
        child: Center(
          child:
              Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.4), // soft glow
                          blurRadius: 30,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/eduair_logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 1200.ms)
                  .scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1, 1),
                    duration: 1200.ms,
                    curve: Curves.easeOut,
                  ),
        ),
      ),
    );
  }
}
