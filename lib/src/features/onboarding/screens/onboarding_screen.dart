import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                'Garaż',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ).animate().fadeIn().moveY(begin: -20, end: 0),
              const SizedBox(height: 8),
              Text(
                'Twój cyfrowy garaż',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.secondaryText,
                    ),
              ).animate().fadeIn(delay: 200.ms),
              const SizedBox(height: 48),
              _FeatureItem(
                icon: PhosphorIcons.car(),
                title: 'Wszystkie informacje o Twoich pojazdach w jednym miejscu',
              ).animate().fadeIn(delay: 300.ms).moveX(begin: -20, end: 0),
              const SizedBox(height: 24),
              _FeatureItem(
                icon: PhosphorIcons.bell(),
                title: 'Przypomnienia o ważnych terminach',
              ).animate().fadeIn(delay: 400.ms).moveX(begin: -20, end: 0),
              const SizedBox(height: 24),
              _FeatureItem(
                icon: PhosphorIcons.clockCounterClockwise(),
                title: 'Historia serwisowa i koszty',
              ).animate().fadeIn(delay: 500.ms).moveX(begin: -20, end: 0),
              const SizedBox(height: 24),
              _FeatureItem(
                icon: PhosphorIcons.shieldCheck(),
                title: 'Bezpieczne przechowywanie dokumentów',
              ).animate().fadeIn(delay: 600.ms).moveX(begin: -20, end: 0),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.go('/garage'),
                  child: const Text('Rozpocznij'),
                ),
              ).animate().fadeIn(delay: 700.ms).moveY(begin: 20, end: 0),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const _FeatureItem({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            size: 24,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              color: AppColors.primaryText,
            ),
          ),
        ),
      ],
    );
  }
}
