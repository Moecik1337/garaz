import 'package:freezed_annotation/freezed_annotation.dart';

part 'maintenance_model.freezed.dart';
part 'maintenance_model.g.dart';

enum MaintenanceType {
  insurance,
  inspection,
  oil,
  timingBelt,
  tires,
  brakes,
  filters,
  other,
}

enum MaintenanceStatus {
  ok,
  warning,
  overdue,
}

enum ReminderType {
  date,
  mileage,
}

@freezed
class MaintenanceItem with _$MaintenanceItem {
  const factory MaintenanceItem({
    required String id,
    required String vehicleId,
    required MaintenanceType type,
    required String name,
    DateTime? lastDate,
    DateTime? nextDate,
    int? lastMileage,
    int? nextMileage,
    int? intervalMonths,
    int? intervalKm,
    String? notes,
  }) = _MaintenanceItem;

  factory MaintenanceItem.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceItemFromJson(json);
}

@freezed
class MaintenanceReminder with _$MaintenanceReminder {
  const factory MaintenanceReminder({
    required String id,
    required String vehicleId,
    required String vehicleName,
    required MaintenanceType type,
    required String title,
    required ReminderType reminderType,
    int? daysRemaining,
    int? kmRemaining,
    required MaintenanceStatus status,
    DateTime? dueDate,
    int? dueMileage,
  }) = _MaintenanceReminder;

  factory MaintenanceReminder.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceReminderFromJson(json);
}

extension MaintenanceItemX on MaintenanceItem {
  MaintenanceStatus get status {
    if (nextDate != null) {
      final daysRemaining = nextDate!.difference(DateTime.now()).inDays;
      if (daysRemaining < 0) return MaintenanceStatus.overdue;
      if (daysRemaining <= 30) return MaintenanceStatus.warning;
    }
    
    if (nextMileage != null && lastMileage != null) {
      final kmRemaining = nextMileage! - lastMileage!;
      if (kmRemaining < 0) return MaintenanceStatus.overdue;
      if (kmRemaining <= 5000) return MaintenanceStatus.warning;
    }
    
    return MaintenanceStatus.ok;
  }
  
  String get formattedRemaining {
    final s = status;
    
    if (nextDate != null) {
      final days = nextDate!.difference(DateTime.now()).inDays;
      if (days < 0) return 'Przeterminowane';
      if (days == 0) return 'Dziś';
      if (days == 1) return '1 dzień';
      return '$days dni';
    }
    
    if (nextMileage != null && lastMileage != null) {
      final km = nextMileage! - lastMileage!;
      if (km < 0) return 'Przekroczone';
      return '${(km / 1000).toStringAsFixed(0)} tys. km';
    }
    
    return 'OK';
  }
  
  String get typeDisplayName {
    switch (type) {
      case MaintenanceType.insurance:
        return 'OC';
      case MaintenanceType.inspection:
        return 'Przegląd';
      case MaintenanceType.oil:
        return 'Olej';
      case MaintenanceType.timingBelt:
        return 'Rozrząd';
      case MaintenanceType.tires:
        return 'Opony';
      case MaintenanceType.brakes:
        return 'Hamulce';
      case MaintenanceType.filters:
        return 'Filtry';
      case MaintenanceType.other:
        return 'Inne';
    }
  }
}
