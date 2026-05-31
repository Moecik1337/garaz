import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../features/garage/screens/garage_screen.dart';
import '../features/deadlines/screens/deadlines_screen.dart';
import '../features/service/screens/service_history_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../core/constants/app_colors.dart';

final shellRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/garage',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return ScaffoldWithNavBar(child: child);
        },
        routes: [
          GoRoute(
            path: '/garage',
            builder: (context, state) => const GarageScreen(),
          ),
          GoRoute(
            path: '/deadlines',
            builder: (context, state) => const DeadlinesScreen(),
          ),
          GoRoute(
            path: '/service',
            builder: (context, state) => const ServiceHistoryScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
    ],
  );
});

class ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;

  const ScaffoldWithNavBar({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    int getCurrentIndex() {
      if (location.startsWith('/garage')) return 0;
      if (location.startsWith('/deadlines')) return 1;
      if (location.startsWith('/service')) return 2;
      if (location.startsWith('/profile')) return 3;
      return 0;
    }

    void onItemTapped(int index) {
      switch (index) {
        case 0:
          context.go('/garage');
          break;
        case 1:
          context.go('/deadlines');
          break;
        case 2:
          context.go('/service');
          break;
        case 3:
          context.go('/profile');
          break;
      }
    }

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          border: Border(
            top: BorderSide(color: AppColors.divider),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavBarItem(
                  icon: PhosphorIcons.car(),
                  label: 'Garaż',
                  isSelected: getCurrentIndex() == 0,
                  onTap: () => onItemTapped(0),
                ),
                _NavBarItem(
                  icon: PhosphorIcons.calendarBlank(),
                  label: 'Terminy',
                  isSelected: getCurrentIndex() == 1,
                  onTap: () => onItemTapped(1),
                ),
                _NavBarItem(
                  icon: PhosphorIcons.wrench(),
                  label: 'Serwis',
                  isSelected: getCurrentIndex() == 2,
                  onTap: () => onItemTapped(2),
                ),
                _NavBarItem(
                  icon: PhosphorIcons.user(),
                  label: 'Profil',
                  isSelected: getCurrentIndex() == 3,
                  onTap: () => onItemTapped(3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected ? AppColors.accent : AppColors.secondaryText,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: isSelected ? AppColors.accent : AppColors.secondaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
