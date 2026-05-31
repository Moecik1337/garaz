import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/vehicle/vehicle_model_simple.dart';
import '../repositories/mock_data_repository.dart';

final vehiclesProvider = StateNotifierProvider<VehicleNotifier, List<VehicleModel>>((ref) {
  return VehicleNotifier();
});

final selectedVehicleProvider = StateProvider<VehicleModel?>((ref) => null);

class VehicleNotifier extends StateNotifier<List<VehicleModel>> {
  VehicleNotifier() : super([]) {
    loadVehicles();
  }

  void loadVehicles() {
    state = MockDataRepository.getMockVehicles();
  }

  void addVehicle(VehicleModel vehicle) {
    state = [...state, vehicle];
  }

  void updateVehicle(VehicleModel updatedVehicle) {
    state = state.map((v) => v.id == updatedVehicle.id ? updatedVehicle : v).toList();
  }

  void removeVehicle(String id) {
    state = state.where((v) => v.id != id).toList();
  }

  VehicleModel? getVehicleById(String id) {
    return state.firstWhere((v) => v.id == id, orElse: () => null as VehicleModel);
  }
}

final serviceHistoryProvider = Provider<List<ServiceRecord>>((ref) {
  return MockDataRepository.getMockServiceHistory();
});

final remindersProvider = Provider<List<MaintenanceItem>>((ref) {
  final vehicles = ref.watch(vehiclesProvider);
  final reminders = <MaintenanceItem>[];

  for (final vehicle in vehicles) {
    for (final item in vehicle.maintenanceItems) {
      if (item.status == MaintenanceStatus.warning || item.status == MaintenanceStatus.overdue) {
        reminders.add(item);
      }
    }
  }

  reminders.sort((a, b) {
    if (a.status == MaintenanceStatus.overdue && b.status != MaintenanceStatus.overdue) return -1;
    if (b.status == MaintenanceStatus.overdue && a.status != MaintenanceStatus.overdue) return 1;
    return 0;
  });

  return reminders;
});
