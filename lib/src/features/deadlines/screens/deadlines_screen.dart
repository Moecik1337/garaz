import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/models/vehicle/vehicle_model_simple.dart';
import '../../../shared/providers/vehicle_provider.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/maintenance_item_widget.dart';

class DeadlinesScreen extends ConsumerWidget {
  const DeadlinesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicles = ref.watch(vehiclesProvider);
    final reminders = ref.watch(remindersProvider);

    final upcoming = reminders.where((r) => r.status == MaintenanceStatus.warning).toList();
    final urgent = reminders.where((r) => r.status == MaintenanceStatus.overdue).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Terminy'),
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
            if (urgent.isNotEmpty)
              SliverToBoxAdapter(
                child: _SectionHeader(
                  title: 'Wymagają uwagi',
                  color: AppColors.danger,
                ),
              ),
            if (urgent.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = urgent[index];
                      final vehicle = vehicles.firstWhere((v) => v.id == item.vehicleId);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: AppCard(
                          child: MaintenanceItemWidget(
                            item: item,
                            showVehicleName: true,
                            vehicleName: vehicle.fullName,
                          ),
                        ),
                      );
                    },
                    childCount: urgent.length,
                  ),
                ),
              ),
            if (upcoming.isNotEmpty)
              SliverToBoxAdapter(
                child: _SectionHeader(
                  title: 'Nadchodzące',
                  color: AppColors.warning,
                ),
              ),
            if (upcoming.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = upcoming[index];
                      final vehicle = vehicles.firstWhere((v) => v.id == item.vehicleId);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: AppCard(
                          child: MaintenanceItemWidget(
                            item: item,
                            showVehicleName: true,
                            vehicleName: vehicle.fullName,
                          ),
                        ),
                      );
                    },
                    childCount: upcoming.length,
                  ),
                ),
              ),
            if (urgent.isEmpty && upcoming.isEmpty)
              const SliverFillRemaining(
                child: _EmptyState(),
              ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final Color color;

  const _SectionHeader({
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.defaultPadding,
        16,
        AppConstants.defaultPadding,
        12,
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            PhosphorIcons.checkCircle(),
            size: 64,
            color: AppColors.success,
          ),
          const SizedBox(height: 16),
          const Text(
            'Wszystko w porządku',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Brak nadchodzących terminów',
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
