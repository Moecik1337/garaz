import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class StatusChip extends StatelessWidget {
  final String label;
  final StatusChipType type;

  const StatusChip({
    required this.label,
    required this.type,
    super.key,
  });

  Color get _backgroundColor {
    switch (type) {
      case StatusChipType.success:
        return AppColors.success.withOpacity(0.15);
      case StatusChipType.warning:
        return AppColors.warning.withOpacity(0.15);
      case StatusChipType.danger:
        return AppColors.danger.withOpacity(0.15);
      case StatusChipType.neutral:
        return AppColors.surfaceLight;
    }
  }

  Color get _textColor {
    switch (type) {
      case StatusChipType.success:
        return AppColors.success;
      case StatusChipType.warning:
        return AppColors.warning;
      case StatusChipType.danger:
        return AppColors.danger;
      case StatusChipType.neutral:
        return AppColors.secondaryText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: _textColor,
        ),
      ),
    );
  }
}

enum StatusChipType {
  success,
  warning,
  danger,
  neutral,
}
