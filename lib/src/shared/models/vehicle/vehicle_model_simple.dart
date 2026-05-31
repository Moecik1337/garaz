enum VehicleType {
  car,
  motorcycle,
}

enum VehicleStatus {
  ok,
  warning,
  danger,
}

class VehicleModel {
  final String id;
  final String brand;
  final String model;
  final String registrationNumber;
  final VehicleType type;
  final String? imageUrl;
  final int? year;
  final int? mileage;
  final String? engine;
  final String? vin;
  final List<MaintenanceItem> maintenanceItems;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  VehicleModel({
    required this.id,
    required this.brand,
    required this.model,
    required this.registrationNumber,
    required this.type,
    this.imageUrl,
    this.year,
    this.mileage,
    this.engine,
    this.vin,
    required this.maintenanceItems,
    this.createdAt,
    this.updatedAt,
  });

  String get fullName => '$brand $model';

  VehicleStatus get overallStatus {
    if (maintenanceItems.isEmpty) return VehicleStatus.ok;

    final hasDanger = maintenanceItems.any((item) => item.status == MaintenanceStatus.overdue);
    if (hasDanger) return VehicleStatus.danger;

    final hasWarning = maintenanceItems.any((item) => item.status == MaintenanceStatus.warning);
    if (hasWarning) return VehicleStatus.warning;

    return VehicleStatus.ok;
  }

  String get statusText {
    switch (overallStatus) {
      case VehicleStatus.ok:
        return 'Wszystko OK';
      case VehicleStatus.warning:
        return 'Zbliża się termin';
      case VehicleStatus.danger:
        return 'Wymaga uwagi';
    }
  }
}

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

class MaintenanceItem {
  final String id;
  final String vehicleId;
  final MaintenanceType type;
  final String name;
  final DateTime? lastDate;
  final DateTime? nextDate;
  final int? lastMileage;
  final int? nextMileage;
  final int? intervalMonths;
  final int? intervalKm;
  final String? notes;

  MaintenanceItem({
    required this.id,
    required this.vehicleId,
    required this.type,
    required this.name,
    this.lastDate,
    this.nextDate,
    this.lastMileage,
    this.nextMileage,
    this.intervalMonths,
    this.intervalKm,
    this.notes,
  });

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

enum ServiceType {
  oil,
  filters,
  brakes,
  tires,
  inspection,
  timingBelt,
  battery,
  other,
}

class ServiceRecord {
  final String id;
  final String vehicleId;
  final ServiceType type;
  final String title;
  final DateTime date;
  final int? mileage;
  final double? cost;
  final String? description;
  final String? workshop;
  final List<String>? parts;

  ServiceRecord({
    required this.id,
    required this.vehicleId,
    required this.type,
    required this.title,
    required this.date,
    this.mileage,
    this.cost,
    this.description,
    this.workshop,
    this.parts,
  });

  String get formattedDate {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  String get formattedMileage {
    if (mileage == null) return '';
    return '${(mileage! / 1000).toStringAsFixed(0)} tys. km';
  }

  String get formattedCost {
    if (cost == null) return '';
    return '${cost!.toStringAsFixed(0)} zł';
  }

  String get typeDisplayName {
    switch (type) {
      case ServiceType.oil:
        return 'Wymiana oleju';
      case ServiceType.filters:
        return 'Wymiana filtrów';
      case ServiceType.brakes:
        return 'Wymiana klocków';
      case ServiceType.tires:
        return 'Wymiana opon';
      case ServiceType.inspection:
        return 'Przegląd techniczny';
      case ServiceType.timingBelt:
        return 'Wymiana rozrządu';
      case ServiceType.battery:
        return 'Wymiana akumulatora';
      case ServiceType.other:
        return 'Inne';
    }
  }
}
