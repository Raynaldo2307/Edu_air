import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:edu_air/src/core/app_providers.dart';
import 'package:edu_air/src/models/app_user.dart';

class SelectRolePage extends ConsumerStatefulWidget {
  const SelectRolePage({super.key});

  @override
  ConsumerState<SelectRolePage> createState() => _SelectRolePageState();
}

class _SelectRolePageState extends ConsumerState<SelectRolePage> {
  String? _selectedRole; // 'student' or 'teacher'
  bool _isSaving = false;
  bool _isLoadingUser = true;
  AppUser? _currentUser;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    try {
      final cachedUser = ref.read(userProvider);
      final userService = ref.read(userServiceProvider);
      final profile = cachedUser ?? await userService.getCurrentUserProfile();

      if (!mounted) return;
      setState(() {
        _currentUser = profile;
        _selectedRole = profile?.role; // pre-select if already set
        _isLoadingUser = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoadingUser = false;
      });
    }
  }

  Future<void> _saveRoleAndContinue() async {
    if (_selectedRole == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a role')));
      return;
    }

    final messenger = ScaffoldMessenger.of(context);
    final currentUser = _currentUser ?? ref.read(userProvider);

    if (currentUser == null) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Unable to load your profile. Please log in again.'),
        ),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final userService = ref.read(userServiceProvider);

      // 1. Save to Firestore
      await userService.updateUserRole(currentUser.uid, _selectedRole!);

      // 2. Update in-memory state
      final updatedUser = currentUser.copyWith(role: _selectedRole!);
      ref.read(userProvider.notifier).state = updatedUser;

      if (!mounted) return;

      // 3. Route to the correct shell
      final nextRoute = _selectedRole == 'teacher'
          ? '/teacherHome'
          : '/studentHome';
      Navigator.pushReplacementNamed(context, nextRoute);
    } catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(SnackBar(content: Text('Error saving role: $e')));
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Widget _buildRoleCard({
    required String label,
    required String value,
    required IconData icon,
  }) {
    final isSelected = _selectedRole == value;

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          setState(() {
            _selectedRole = value;
          });
        },
        child: Container(
          height: 150,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? Colors.blue : Colors.grey.shade300,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: isSelected ? Colors.blue : Colors.grey.shade500,
              ),
              const SizedBox(height: 12),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.blue : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final name = _currentUser?.displayName ?? 'there';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text('Select Role'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: _isLoadingUser
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const SizedBox(height: 24),
                Text(
                  'Welcome, $name 👋',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Select how you will use the app.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      _buildRoleCard(
                        label: 'Student',
                        value: 'student',
                        icon: Icons.school,
                      ),
                      _buildRoleCard(
                        label: 'Teacher',
                        value: 'teacher',
                        icon: Icons.person,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isSaving ? null : _saveRoleAndContinue,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isSaving
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Continue'),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
