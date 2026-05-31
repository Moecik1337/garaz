import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/models/vehicle/vehicle_model_simple.dart';
import '../../../shared/providers/vehicle_provider.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/maintenance_item_widget.dart';

class VehicleDetailsScreen extends ConsumerWidget {
  final String vehicleId;

  const VehicleDetailsScreen({
    required this.vehicleId,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicles = ref.watch(vehiclesProvider);
    final vehicle = vehicles.firstWhere(
      (v) => v.id == vehicleId,
      orElse: () => null as VehicleModel,
    );

    if (vehicle == null) {
      return const Scaffold(
        body: Center(child: Text('Pojazd nie znaleziony')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.background,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => context.pop(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_horiz),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: vehicle.imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: vehicle.imageUrl!,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: AppColors.surface,
                      child: const Icon(
                        Icons.car_rental,
                        size: 100,
                        color: AppColors.tertiaryText,
                      ),
                    ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vehicle.fullName,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    vehicle.registrationNumber,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.secondaryText,
                        ),
                  ),
                  const SizedBox(height: 24),
                  if (vehicle.mileage != null || vehicle.year != null || vehicle.engine != null)
                    _VehicleInfoGrid(
                      mileage: vehicle.mileage,
                      year: vehicle.year,
                      engine: vehicle.engine,
                    ),
                  const SizedBox(height: 32),
                  Text(
                    'Terminy',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 16),
                  ...vehicle.maintenanceItems.map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: AppCard(
                      child: MaintenanceItemWidget(item: item),
                    ),
                  )),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VehicleInfoGrid extends StatelessWidget {
  final int? mileage;
  final int? year;
  final String? engine;

  const _VehicleInfoGrid({
    this.mileage,
    this.year,
    this.engine,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (mileage != null)
          Expanded(
            child: _InfoCard(
              icon: PhosphorIcons.speedometer(),
              value: '${(mileage! / 1000).toStringAsFixed(0)} tys. km',
              label: 'Przebieg',
            ),
          ),
        if (year != null) ...[
          const SizedBox(width: 12),
          Expanded(
            child: _InfoCard(
              icon: PhosphorIcons.calendar(),
              value: '$year',
              label: 'Rok prod.',
            ),
          ),
        ],
        if (engine != null) ...[
          const SizedBox(width: 12),
          Expanded(
            child: _InfoCard(
              icon: PhosphorIcons.engine(),
              value: engine!,
              label: 'Silnik',
            ),
          ),
        ],
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _InfoCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24, color: AppColors.accent),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}
