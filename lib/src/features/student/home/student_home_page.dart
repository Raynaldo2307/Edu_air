import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:edu_air/src/core/app_providers.dart';
import 'package:edu_air/src/core/app_theme.dart';
import 'package:edu_air/src/features/student/home/widgets/greeting_header.dart';
import 'package:edu_air/src/features/student/home/widgets/info_cards_row.dart';
import 'package:edu_air/src/features/student/home/widgets/quick_links_grid.dart';
import 'package:edu_air/src/features/student/home/widgets/upcoming_events_section.dart';

class StudentHomePage extends ConsumerWidget {
  const StudentHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final name = (user?.displayName.trim().isNotEmpty ?? false)
        ? user!.displayName
        : 'Dev Cooper';
    final studentId = (user?.studentId?.isNotEmpty ?? false)
        ? user!.studentId!
        : 'S8745';

    final heroCards = [
      const InfoCardData(
        title: 'Check updated homework',
        subtitle: 'New work for you.',
        imageUrl:
            'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?auto=format&fit=crop&w=500&q=80',
        ctaLabel: 'Check Now',
        backgroundColor: Color(0xFFFDE1E9),
      ),
      const InfoCardData(
        title: 'Join live class at 2:30 PM',
        subtitle: 'Don\'t miss today\'s session.',
        imageUrl:
            'https://images.unsplash.com/photo-1522202195465-dc5d0f4affc0?auto=format&fit=crop&w=500&q=80',
        ctaLabel: 'Join Now',
        backgroundColor: Color(0xFFE1F5FE),
      ),
    ];

    final quickLinks = const [
      QuickLinkItem(
        icon: Icons.event_available_outlined,
        label: 'Attendance',
        backgroundColor: Color(0xFFE8F2FF),
        iconColor: Color(0xFF4A7CFF),
      ),
      QuickLinkItem(
        icon: Icons.description_outlined,
        label: 'Exam',
        backgroundColor: Color(0xFFF5EBFF),
        iconColor: Color(0xFF9B51E0),
      ),
      QuickLinkItem(
        icon: Icons.assignment_turned_in_outlined,
        label: 'Leave',
        backgroundColor: Color(0xFFE6F6F3),
        iconColor: Color(0xFF2D9CDB),
      ),
      QuickLinkItem(
        icon: Icons.account_balance_outlined,
        label: 'Fees',
        backgroundColor: Color(0xFFEFF4FF),
        iconColor: Color(0xFF4A5568),
      ),
      QuickLinkItem(
        icon: Icons.edit_note_outlined,
        label: 'Home Work',
        backgroundColor: Color(0xFFF8F2DC),
        iconColor: Color(0xFFB7791F),
      ),
      QuickLinkItem(
        icon: Icons.groups_outlined,
        label: 'Community',
        backgroundColor: Color(0xFFFDE9EC),
        iconColor: Color(0xFFE65D7B),
      ),
      QuickLinkItem(
        icon: Icons.chat_bubble_outline,
        label: 'Message',
        backgroundColor: Color(0xFFF6EAFE),
        iconColor: Color(0xFFAA7AE0),
      ),
      QuickLinkItem(
        icon: Icons.campaign_outlined,
        label: 'Notice',
        backgroundColor: Color(0xFFE7F7EC),
        iconColor: Color(0xFF2F9E44),
      ),
    ];

    final upcomingEvents = const [
      UpcomingEvent(
        title: 'Inter-school football match',
        dateLabel: 'Nov 22, 2024',
        imageUrl:
            'https://images.unsplash.com/photo-1508098682722-e99c43a406b2?auto=format&fit=crop&w=500&q=80',
      ),
      UpcomingEvent(
        title: 'Science project fair',
        dateLabel: 'Dec 1, 2024',
        imageUrl:
            'https://images.unsplash.com/photo-1582719477707-64c04a8b01ea?auto=format&fit=crop&w=500&q=80',
        fallbackColor: Color(0xFFFDE1E9),
      ),
      UpcomingEvent(
        title: 'Parent-teacher meeting',
        dateLabel: 'Dec 5, 2024',
        imageUrl:
            'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?auto=format&fit=crop&w=500&q=80',
        fallbackColor: Color(0xFFE1F5FE),
      ),
    ];

    return SafeArea(
      child: ColoredBox(
        color: AppTheme.accent.withValues(alpha: 0.08),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GreetingHeader(
                name: name,
                studentId: studentId,
                avatarUrl: user?.photoUrl,
              ),
              const SizedBox(height: 18),
              InfoCardsRow(cards: heroCards),
              const SizedBox(height: 22),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: const Text(
                  'Dashboard',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: quickLinks
                      .map((link) => QuickLinkItemWidget(item: link))
                      .toList(),
                ),
              ),
              const SizedBox(height: 16),
              UpcomingEventsSection(events: upcomingEvents, onViewAll: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
