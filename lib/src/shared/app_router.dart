import 'package:flutter/material.dart';

import '../features/splash_page/splash_screen.dart';
import '../features/onboard_page/onboard_screen.dart';
import '../features/home_page/home_page.dart';
import '../features/auth/sign_in_form.dart';
import '../features/auth/sign_up_form.dart';
import '../features/shell/select_role.dart';
import '../features/shell/student_shell.dart';
import '../features/shell/teacher_shell.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashPage());

      case '/onboarding':
        return MaterialPageRoute(builder: (_) => const OnboardingPage());

      case '/signin':
        return MaterialPageRoute(builder: (_) => const SignInPage());

      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignUpPage());

      // after user signs in but before we know role
      case '/selectRole':
        return MaterialPageRoute(builder: (_) => const SelectRolePage());

      // main shells
      case '/studentHome':
        return MaterialPageRoute(builder: (_) => const StudentShell());

      case '/teacherHome':
        return MaterialPageRoute(builder: (_) => const TeacherShell());

      // legacy / generic home if you still want it
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
