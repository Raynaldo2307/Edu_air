import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:edu_air/src/core/app_providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(userProvider);
    final greeting =
        currentUser?.displayName.isNotEmpty == true ? currentUser!.displayName : 'Guest';

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, $greeting'),
      ),
      body: Center(
        child: Text(
          'Logged in as: ${currentUser?.email ?? 'No user'}',
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
