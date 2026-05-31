import '../models/vehicle/vehicle_model.dart';
import '../models/maintenance/maintenance_model.dart';
import '../models/service/service_model.dart';

class MockVehicleRepository {
  static List<VehicleModel> getMockVehicles() {
    final now = DateTime.now();
    
    return [
      VehicleModel(
        id: '1',
        brand: 'BMW',
        model: '320d',
        registrationNumber: 'WW 1234A',
        type: VehicleType.car,
        imageUrl: 'https://images.unsplash.com/photo-1555215695-3004980adade?w=800',
        year: 2019,
        mileage: 68450,
        engine: '2.0 diesel\n190 KM',
        maintenanceItems: [
          MaintenanceItem(
            id: 'm1',
            vehicleId: '1',
            type: MaintenanceType.insurance,
            name: 'OC',
            lastDate: now.subtract(const Duration(days: 100)),
            nextDate: now.add(const Duration(days: 32)),
            intervalMonths: 12,
          ),
          MaintenanceItem(
            id: 'm2',
            vehicleId: '1',
            type: MaintenanceType.inspection,
            name: 'Przegląd',
            lastDate: now.subtract(const Duration(days: 200)),
            nextDate: now.add(const Duration(days: 96)),
            intervalMonths: 12,
          ),
          MaintenanceItem(
            id: 'm3',
            vehicleId: '1',
            type: MaintenanceType.oil,
            name: 'Olej',
            lastDate: now.subtract(const Duration(days: 180)),
            lastMileage: 61500,
            nextMileage: 68550,
            nextDate: now.add(const Duration(days: 27)),
            intervalKm: 10000,
          ),
          MaintenanceItem(
            id: 'm4',
            vehicleId: '1',
            type: MaintenanceType.timingBelt,
            name: 'Rozrząd',
            lastMileage: 25000,
            nextMileage: 125000,
            intervalKm: 100000,
          ),
        ],
        createdAt: now.subtract(const Duration(days: 365)),
        updatedAt: now,
      ),
      VehicleModel(
        id: '2',
        brand: 'Yamaha',
        model: 'MT-07',
        registrationNumber: 'WW 5678B',
        type: VehicleType.motorcycle,
        imageUrl: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800',
        year: 2020,
        mileage: 25000,
        engine: '689 cc\n74 KM',
        maintenanceItems: [
          MaintenanceItem(
            id: 'm5',
            vehicleId: '2',
            type: MaintenanceType.insurance,
            name: 'OC',
            lastDate: now.subtract(const Duration(days: 150)),
            nextDate: now.subtract(const Duration(days: 5)),
            intervalMonths: 12,
          ),
          MaintenanceItem(
            id: 'm6',
            vehicleId: '2',
            type: MaintenanceType.inspection,
            name: 'Przegląd',
            lastDate: now.subtract(const Duration(days: 45)),
            nextDate: now.add(const Duration(days: 30)),
            intervalMonths: 12,
          ),
          MaintenanceItem(
            id: 'm7',
            vehicleId: '2',
            type: MaintenanceType.oil,
            name: 'Olej',
            lastDate: now.subtract(const Duration(days: 120)),
            lastMileage: 19000,
            nextMileage: 25000,
            intervalKm: 6000,
          ),
          MaintenanceItem(
            id: 'm8',
            vehicleId: '2',
            type: MaintenanceType.brakes,
            name: 'Hamulce',
            lastMileage: 15000,
            nextMileage: 35000,
            intervalKm: 20000,
          ),
        ],
        createdAt: now.subtract(const Duration(days: 200)),
        updatedAt: now,
      ),
    ];
  }
  
  static List<ServiceRecord> getMockServiceHistory() {
    final now = DateTime.now();
    
    return [
      ServiceRecord(
        id: 's1',
        vehicleId: '1',
        type: ServiceType.oil,
        title: 'Wymiana oleju',
        date: now.subtract(const Duration(days: 180)),
        mileage: 61500,
        cost: 420,
        description: 'Castrol Edge 5W30',
        workshop: 'Auto Serwis',
      ),
      ServiceRecord(
        id: 's2',
        vehicleId: '1',
        type: ServiceType.filters,
        title: 'Wymiana filtrów',
        date: now.subtract(const Duration(days: 175)),
        mileage: 61550,
        cost: 150,
        description: 'Filtr oleju, powietrza, kabinowy',
      ),
      ServiceRecord(
        id: 's3',
        vehicleId: '1',
        type: ServiceType.brakes,
        title: 'Klocki hamulcowe przód',
        date: now.subtract(const Duration(days: 365)),
        mileage: 52300,
        cost: 580,
        description: 'Brembo',
      ),
      ServiceRecord(
        id: 's4',
        vehicleId: '1',
        type: ServiceType.inspection,
        title: 'Przegląd techniczny',
        date: now.subtract(const Duration(days: 200)),
        mileage: 60000,
        cost: 98,
        description: 'Stacja Kontroli Pojazdów',
      ),
      ServiceRecord(
        id: 's5',
        vehicleId: '1',
        type: ServiceType.tires,
        title: 'Wymiana opon',
        date: now.subtract(const Duration(days: 90)),
        mileage: 63000,
        cost: 1600,
        description: 'Michelin Pilot Sport 4',
      ),
    ];
  }
}
