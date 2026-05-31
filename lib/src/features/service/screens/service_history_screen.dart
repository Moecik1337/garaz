import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/models/vehicle/vehicle_model_simple.dart';
import '../../../shared/providers/vehicle_provider.dart';
import '../../../shared/widgets/app_card.dart';

class ServiceHistoryScreen extends ConsumerWidget {
  const ServiceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serviceHistory = ref.watch(serviceHistoryProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Serwis'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: _CostSummaryCard(),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final record = serviceHistory[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _ServiceRecordCard(record: record)
                          .animate()
                          .fadeIn(delay: (index * 50).ms)
                          .moveY(begin: 10, end: 0, delay: (index * 50).ms),
                    );
                  },
                  childCount: serviceHistory.length,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Dodaj wpis'),
      ),
    );
  }
}

class _CostSummaryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Koszty w 2025',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.secondaryText,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '2 840 zł',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _CostIndicator(
                color: AppColors.accent,
                label: 'Paliwo',
                amount: '1 350 zł',
                percentage: 47,
              ),
              const SizedBox(width: 16),
              _CostIndicator(
                color: AppColors.success,
                label: 'Serwis',
                amount: '980 zł',
                percentage: 35,
              ),
              const SizedBox(width: 16),
              _CostIndicator(
                color: AppColors.warning,
                label: 'Ubezpieczenie',
                amount: '350 zł',
                percentage: 12,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CostIndicator extends StatelessWidget {
  final Color color;
  final String label;
  final String amount;
  final int percentage;

  const _CostIndicator({
    required this.color,
    required this.label,
    required this.amount,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.secondaryText,
              ),
            ),
            Text(
              amount,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryText,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ServiceRecordCard extends StatelessWidget {
  final ServiceRecord record;

  const _ServiceRecordCard({required this.record});

  IconData get _icon {
    switch (record.type) {
      case ServiceType.oil:
        return PhosphorIcons.drop();
      case ServiceType.filters:
        return PhosphorIcons.funnel();
      case ServiceType.brakes:
        return PhosphorIcons.handPalm();
      case ServiceType.tires:
        return PhosphorIcons.circle();
      case ServiceType.inspection:
        return PhosphorIcons.clipboardText();
      case ServiceType.timingBelt:
        return PhosphorIcons.gear();
      case ServiceType.battery:
        return PhosphorIcons.batteryCharging();
      case ServiceType.other:
        return PhosphorIcons.wrench();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _icon,
              size: 24,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  record.typeDisplayName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryText,
                  ),
                ),
                if (record.description != null)
                  Text(
                    record.description!,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.secondaryText,
                    ),
                  ),
                const SizedBox(height: 4),
                Text(
                  '${record.formattedDate} • ${record.formattedMileage}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.tertiaryText,
                  ),
                ),
              ],
            ),
          ),
          if (record.cost != null)
            Text(
              record.formattedCost,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryText,
              ),
            ),
        ],
      ),
    );
  }
}
