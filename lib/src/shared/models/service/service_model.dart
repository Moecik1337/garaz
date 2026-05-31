import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_model.freezed.dart';
part 'service_model.g.dart';

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

@freezed
class ServiceRecord with _$ServiceRecord {
  const factory ServiceRecord({
    required String id,
    required String vehicleId,
    required ServiceType type,
    required String title,
    required DateTime date,
    int? mileage,
    double? cost,
    String? description,
    String? workshop,
    List<String>? parts,
  }) = _ServiceRecord;

  factory ServiceRecord.fromJson(Map<String, dynamic> json) =>
      _$ServiceRecordFromJson(json);
}

extension ServiceRecordX on ServiceRecord {
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
