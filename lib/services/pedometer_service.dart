import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:pedometer_2/pedometer_2.dart';

/// Service for real-time step counting using device pedometer.
class PedometerService {
  final Pedometer _pedometer = Pedometer();
  StreamSubscription<int>? _stepCountSubscription;
  StreamSubscription<PedestrianStatus>? _pedestrianStatusSubscription;

  int _initialSteps = 0;
  int _sessionSteps = 0;
  bool _isInitialized = false;

  final _stepController = StreamController<int>.broadcast();
  final _statusController = StreamController<String>.broadcast();

  /// Stream of step counts for this session
  Stream<int> get stepStream => _stepController.stream;

  /// Stream of pedestrian status (walking/stopped)
  Stream<String> get statusStream => _statusController.stream;

  /// Current session steps
  int get sessionSteps => _sessionSteps;

  /// Whether the pedometer is active
  bool get isActive => _stepCountSubscription != null;

  /// Start listening to pedometer
  Future<void> start() async {
    if (_stepCountSubscription != null) return;

    try {
      _stepCountSubscription = _pedometer.stepCountStream().listen(
        _onStepCount,
        onError: _onStepCountError,
        cancelOnError: false,
      );

      _pedestrianStatusSubscription = _pedometer.pedestrianStatusStream().listen(
        _onPedestrianStatus,
        onError: _onPedestrianStatusError,
        cancelOnError: false,
      );

      debugPrint('Pedometer started');
    } catch (e) {
      debugPrint('Pedometer error: $e');
    }
  }

  void _onStepCount(int steps) {
    if (!_isInitialized) {
      _initialSteps = steps;
      _isInitialized = true;
      debugPrint('Pedometer initialized with $steps steps');
    }

    _sessionSteps = steps - _initialSteps;
    _stepController.add(_sessionSteps);
    debugPrint('Steps this session: $_sessionSteps');
  }

  void _onStepCountError(error) {
    debugPrint('Step count error: $error');
    _stepController.addError(error);
  }

  void _onPedestrianStatus(PedestrianStatus status) {
    final statusStr = status == PedestrianStatus.walking ? 'walking' : 'stopped';
    _statusController.add(statusStr);
    debugPrint('Pedestrian status: $statusStr');
  }

  void _onPedestrianStatusError(error) {
    debugPrint('Pedestrian status error: $error');
    _statusController.addError(error);
  }

  /// Reset session step count
  void resetSession() {
    _isInitialized = false;
    _sessionSteps = 0;
    _stepController.add(0);
  }

  /// Stop listening to pedometer
  void stop() {
    _stepCountSubscription?.cancel();
    _stepCountSubscription = null;
    _pedestrianStatusSubscription?.cancel();
    _pedestrianStatusSubscription = null;
    debugPrint('Pedometer stopped');
  }

  /// Dispose resources
  void dispose() {
    stop();
    _stepController.close();
    _statusController.close();
  }
}
