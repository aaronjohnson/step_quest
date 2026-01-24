import 'package:health/health.dart';
import 'package:flutter/foundation.dart';

/// Service for interacting with Health Connect to retrieve step data.
class HealthService {
  static final HealthService _instance = HealthService._internal();
  factory HealthService() => _instance;
  HealthService._internal();

  final Health _health = Health();
  bool _isAuthorized = false;

  /// Health data types we need access to
  static const List<HealthDataType> _types = [
    HealthDataType.STEPS,
  ];

  /// Permissions for each type (read-only for steps)
  static final List<HealthDataAccess> _permissions = _types
      .map((type) => HealthDataAccess.READ)
      .toList();

  /// Check if Health Connect is available on this device
  Future<bool> isHealthConnectAvailable() async {
    try {
      final status = await _health.getHealthConnectSdkStatus();
      return status == HealthConnectSdkStatus.sdkAvailable;
    } catch (e) {
      debugPrint('Error checking Health Connect availability: $e');
      return false;
    }
  }

  /// Request authorization to read step data
  Future<bool> requestAuthorization() async {
    try {
      // Configure the health plugin for Health Connect
      await _health.configure();

      // Check if Health Connect is available
      final available = await isHealthConnectAvailable();
      if (!available) {
        debugPrint('Health Connect is not available on this device');
        return false;
      }

      // Request permissions
      _isAuthorized = await _health.requestAuthorization(
        _types,
        permissions: _permissions,
      );

      debugPrint('Health Connect authorization: $_isAuthorized');
      return _isAuthorized;
    } catch (e) {
      debugPrint('Error requesting Health Connect authorization: $e');
      return false;
    }
  }

  /// Check if we have authorization
  Future<bool> hasAuthorization() async {
    try {
      final hasPerms = await _health.hasPermissions(_types, permissions: _permissions);
      _isAuthorized = hasPerms ?? false;
      return _isAuthorized;
    } catch (e) {
      debugPrint('Error checking Health Connect permissions: $e');
      return false;
    }
  }

  /// Get today's total step count from Health Connect
  Future<int> getTodaySteps() async {
    if (!_isAuthorized) {
      final authorized = await hasAuthorization();
      if (!authorized) {
        debugPrint('Not authorized to read steps');
        return 0;
      }
    }

    try {
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);

      final steps = await _health.getTotalStepsInInterval(startOfDay, now);
      return steps ?? 0;
    } catch (e) {
      debugPrint('Error fetching today\'s steps: $e');
      return 0;
    }
  }

  /// Get step count for a specific date
  Future<int> getStepsForDate(DateTime date) async {
    if (!_isAuthorized) {
      final authorized = await hasAuthorization();
      if (!authorized) {
        return 0;
      }
    }

    try {
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      final steps = await _health.getTotalStepsInInterval(startOfDay, endOfDay);
      return steps ?? 0;
    } catch (e) {
      debugPrint('Error fetching steps for $date: $e');
      return 0;
    }
  }

  /// Get step history for the past N days
  Future<Map<DateTime, int>> getStepHistory({int days = 7}) async {
    if (!_isAuthorized) {
      final authorized = await hasAuthorization();
      if (!authorized) {
        return {};
      }
    }

    final history = <DateTime, int>{};
    final now = DateTime.now();

    for (int i = 0; i < days; i++) {
      final date = DateTime(now.year, now.month, now.day - i);
      final steps = await getStepsForDate(date);
      history[date] = steps;
    }

    return history;
  }

  /// Install Health Connect app (opens Play Store)
  Future<void> installHealthConnect() async {
    try {
      await _health.installHealthConnect();
    } catch (e) {
      debugPrint('Error opening Health Connect install: $e');
    }
  }
}
