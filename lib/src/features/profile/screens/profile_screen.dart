import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/app_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            children: [
              _ProfileHeader()
                  .animate()
                  .fadeIn()
                  .moveY(begin: 20, end: 0),
              const SizedBox(height: 24),
              _SettingsSection()
                  .animate()
                  .fadeIn(delay: 100.ms)
                  .moveY(begin: 20, end: 0),
              const SizedBox(height: 24),
              _AppInfoSection()
                  .animate()
                  .fadeIn(delay: 200.ms)
                  .moveY(begin: 20, end: 0),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              size: 40,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Użytkownik',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'uzytkownik@email.com',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8, bottom: 12),
          child: Text(
            'USTAWIENIA',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.tertiaryText,
              letterSpacing: 0.5,
            ),
          ),
        ),
        AppCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _SettingTile(
                icon: PhosphorIcons.bell(),
                title: 'Powiadomienia',
                subtitle: 'Włączone',
                onTap: () {},
              ),
              const Divider(height: 1, color: AppColors.divider),
              _SettingTile(
                icon: PhosphorIcons.moon(),
                title: 'Tryb ciemny',
                subtitle: 'Włączony',
                onTap: () {},
                showToggle: true,
                toggleValue: true,
              ),
              const Divider(height: 1, color: AppColors.divider),
              _SettingTile(
                icon: PhosphorIcons.crown(),
                title: 'Garaż Premium',
                subtitle: 'Wersja darmowa',
                onTap: () {},
                isPremium: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool showToggle;
  final bool toggleValue;
  final bool isPremium;

  const _SettingTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.showToggle = false,
    this.toggleValue = false,
    this.isPremium = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isPremium
              ? AppColors.warning.withOpacity(0.15)
              : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 20,
          color: isPremium ? AppColors.warning : AppColors.accent,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryText,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 13,
          color: AppColors.secondaryText,
        ),
      ),
      trailing: showToggle
          ? Switch(
              value: toggleValue,
              onChanged: (_) {},
              activeColor: AppColors.accent,
            )
          : const Icon(
              Icons.chevron_right,
              color: AppColors.tertiaryText,
            ),
      onTap: onTap,
    );
  }
}

class _AppInfoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8, bottom: 12),
          child: Text(
            'APLIKACJA',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.tertiaryText,
              letterSpacing: 0.5,
            ),
          ),
        ),
        AppCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _AppInfoTile(
                label: 'Wersja',
                value: '1.0.0',
              ),
              const Divider(height: 1, color: AppColors.divider),
              _AppInfoTile(
                label: 'Dostępne wkrótce',
                value: '',
                showArrow: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Center(
          child: Text(
            'Garaż • Twój cyfrowy garaż',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.tertiaryText,
            ),
          ),
        ),
      ],
    );
  }
}

class _AppInfoTile extends StatelessWidget {
  final String label;
  final String value;
  final bool showArrow;

  const _AppInfoTile({
    required this.label,
    required this.value,
    this.showArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              color: AppColors.primaryText,
            ),
          ),
          Row(
            children: [
              if (value.isNotEmpty)
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.secondaryText,
                  ),
                ),
              if (showArrow)
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.tertiaryText,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
