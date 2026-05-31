import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/models/vehicle/vehicle_model_simple.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/status_chip.dart';

class VehicleCard extends StatelessWidget {
  final VehicleModel vehicle;
  final VoidCallback? onTap;

  const VehicleCard({
    required this.vehicle,
    this.onTap,
    super.key,
  });

  StatusChipType get _statusType {
    switch (vehicle.overallStatus) {
      case VehicleStatus.ok:
        return StatusChipType.success;
      case VehicleStatus.warning:
        return StatusChipType.warning;
      case VehicleStatus.danger:
        return StatusChipType.danger;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vehicle.fullName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      vehicle.registrationNumber,
                      style: const TextStyle(
                        fontSize: 15,
                        color: AppColors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
              StatusChip(
                label: vehicle.statusText,
                type: _statusType,
              ),
            ],
          ),
          if (vehicle.imageUrl != null) ...[
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: vehicle.imageUrl!,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 160,
                  color: AppColors.surfaceLight,
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.accent,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 160,
                  color: AppColors.surfaceLight,
                  child: const Icon(
                    Icons.car_rental,
                    size: 60,
                    color: AppColors.tertiaryText,
                  ),
                ),
              ),
            ),
          ],
          const SizedBox(height: 16),
          _MaintenanceGrid(items: vehicle.maintenanceItems),
        ],
      ),
    );
  }
}

class _MaintenanceGrid extends StatelessWidget {
  final List<MaintenanceItem> items;

  const _MaintenanceGrid({required this.items});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: items.take(4).map((item) {
        return Expanded(
          child: _MaintenanceIndicator(item: item),
        );
      }).toList(),
    );
  }
}

class _MaintenanceIndicator extends StatelessWidget {
  final MaintenanceItem item;

  const _MaintenanceIndicator({required this.item});

  IconData get _icon {
    switch (item.type) {
      case MaintenanceType.insurance:
        return PhosphorIcons.shieldCheck();
      case MaintenanceType.inspection:
        return PhosphorIcons.clipboardText();
      case MaintenanceType.oil:
        return PhosphorIcons.drop();
      case MaintenanceType.timingBelt:
        return PhosphorIcons.gear();
      default:
        return PhosphorIcons.wrench();
    }
  }

  Color get _statusColor {
    switch (item.status) {
      case MaintenanceStatus.ok:
        return AppColors.success;
      case MaintenanceStatus.warning:
        return AppColors.warning;
      case MaintenanceStatus.overdue:
        return AppColors.danger;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          _icon,
          size: 20,
          color: item.status == MaintenanceStatus.ok
              ? AppColors.secondaryText
              : _statusColor,
        ),
        const SizedBox(height: 6),
        Text(
          item.typeDisplayName,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.tertiaryText,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          item.formattedRemaining,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: _statusColor,
          ),
        ),
      ],
    );
  }
}
