import 'package:freezed_annotation/freezed_annotation.dart';
import '../maintenance/maintenance_model.dart';

part 'vehicle_model.freezed.dart';
part 'vehicle_model.g.dart';

enum VehicleType {
  car,
  motorcycle,
}

enum VehicleStatus {
  ok,
  warning,
  danger,
}

@freezed
class VehicleModel with _$VehicleModel {
  const factory VehicleModel({
    required String id,
    required String brand,
    required String model,
    required String registrationNumber,
    required VehicleType type,
    String? imageUrl,
    int? year,
    int? mileage,
    String? engine,
    String? vin,
    required List<MaintenanceItem> maintenanceItems,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _VehicleModel;

  factory VehicleModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleModelFromJson(json);
}

extension VehicleModelX on VehicleModel {
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
