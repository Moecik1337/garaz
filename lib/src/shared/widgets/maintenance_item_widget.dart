import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../core/constants/app_colors.dart';
import '../models/vehicle/vehicle_model_simple.dart';

class MaintenanceItemWidget extends StatelessWidget {
  final MaintenanceItem item;
  final bool showVehicleName;
  final String? vehicleName;

  const MaintenanceItemWidget({
    required this.item,
    this.showVehicleName = false,
    this.vehicleName,
    super.key,
  });

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
      case MaintenanceType.tires:
        return PhosphorIcons.circle();
      case MaintenanceType.brakes:
        return PhosphorIcons.handPalm();
      case MaintenanceType.filters:
        return PhosphorIcons.funnel();
      case MaintenanceType.other:
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
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            _icon,
            size: 20,
            color: AppColors.secondaryText,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showVehicleName && vehicleName != null)
                Text(
                  vehicleName!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.tertiaryText,
                  ),
                ),
              Text(
                item.typeDisplayName,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryText,
                ),
              ),
              const SizedBox(height: 2),
              if (item.nextDate != null)
                Text(
                  'do ${item.nextDate!.day.toString().padLeft(2, '0')}.${item.nextDate!.month.toString().padLeft(2, '0')}.${item.nextDate!.year}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.secondaryText,
                  ),
                ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              item.formattedRemaining,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: _statusColor,
              ),
            ),
            if (item.nextMileage != null && item.lastMileage != null)
              Text(
                '${((item.nextMileage! - item.lastMileage!) / 1000).toStringAsFixed(0)} tys. km',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.tertiaryText,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
