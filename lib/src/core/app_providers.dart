import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:edu_air/src/models/app_user.dart';
import 'package:edu_air/src/services/auth_services.dart';
import 'package:edu_air/src/services/user_services.dart';

/// Global provider holding the currently authenticated [AppUser].
final userProvider = StateProvider<AppUser?>((ref) => null);

/// Exposes a singleton [AuthService] instance through Riverpod.
final authServiceProvider = Provider<AuthService>((ref) => AuthService());

/// Helper provider to access [UserService] wherever needed.
final userServiceProvider = Provider<UserService>((ref) => UserService());
