import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/splash/screens/splash_screen.dart';
import '../features/onboarding/screens/onboarding_screen.dart';
import '../features/garage/screens/garage_screen.dart';
import '../features/vehicles/screens/vehicle_details_screen.dart';
import '../features/vehicles/screens/add_vehicle_screen.dart';
import '../features/deadlines/screens/deadlines_screen.dart';
import '../features/service/screens/service_history_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../shared/models/vehicle/vehicle_model_simple.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const GarageScreen(),
      ),
      GoRoute(
        path: '/vehicle/:id',
        builder: (context, state) {
          final vehicleId = state.params['id']!;
          return VehicleDetailsScreen(vehicleId: vehicleId);
        },
      ),
      GoRoute(
        path: '/add-vehicle',
        builder: (context, state) => const AddVehicleScreen(),
      ),
      GoRoute(
        path: '/deadlines',
        builder: (context, state) => const DeadlinesScreen(),
      ),
      GoRoute(
        path: '/service',
        builder: (context, state) => const ServiceHistoryScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );
});
