import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SensorProvider extends ChangeNotifier {
  static const Duration _ignoreDuration = Duration(milliseconds: 20);
  UserAccelerometerEvent? _userAccelerometerEvent;
  AccelerometerEvent? _accelerometerEvent;
  GyroscopeEvent? _gyroscopeEvent;
  UserAccelerometerEvent? get userAccelerometerEvent => _userAccelerometerEvent;
  AccelerometerEvent? get accelerometerEvent => _accelerometerEvent;
  GyroscopeEvent? get gyroscopeEvent => _gyroscopeEvent;

  final userAccelDataX = <FlSpot>[];
  final userAccelDataY = <FlSpot>[];
  final userAccelDataZ = <FlSpot>[];

  List<FlSpot> gyroDataX = [];
  List<FlSpot> gyroDataY = [];
  List<FlSpot> gyroDataZ = [];

  List<FlSpot> accelDataX = [];
  List<FlSpot> accelDataY = [];
  List<FlSpot> accelDataZ = [];

  DateTime? _userAccelerometerUpdateTime;
  DateTime? _accelerometerUpdateTime;
  DateTime? _gyroscopeUpdateTime;
  int? _userAccelerometerLastInterval;
  int? _accelerometerLastInterval;
  int? _gyroscopeLastInterval;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  Duration sensorInterval = SensorInterval.normalInterval;
  bool alert = false;
  double highMovementThreshold = 15.0;
  void addToGraph(List<FlSpot> data, double value) {
    data.add(FlSpot(data.length.toDouble(), value));
    notifyListeners();
  }

  void disposeStream() {
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  void sensorIntialFunc({required Function(String) onError}) {
    _streamSubscriptions.add(
      userAccelerometerEventStream(samplingPeriod: sensorInterval).listen(
        (UserAccelerometerEvent event) {
          final now = event.timestamp;
          _userAccelerometerEvent = event;
          if (_userAccelerometerUpdateTime != null) {
            final interval = now.difference(_userAccelerometerUpdateTime!);
            if (interval > _ignoreDuration) {
              _userAccelerometerLastInterval = interval.inMilliseconds;
            }
          }
          addToGraph(userAccelDataX, event.x);
          addToGraph(userAccelDataY, event.y);
          addToGraph(userAccelDataZ, event.z);
          if ((event.x.abs() > highMovementThreshold && event.y.abs() > highMovementThreshold) ||
              (event.x.abs() > highMovementThreshold && event.z.abs() > highMovementThreshold) ||
              (event.y.abs() > highMovementThreshold && event.z.abs() > highMovementThreshold)) {
            alert = true;
          } else {
            alert = false;
          }
          notifyListeners();
          _userAccelerometerUpdateTime = now;
          notifyListeners();
        },
        onError: (e) {
          onError(
              "It seems that your device doesn't support User Accelerometer Sensor");
        },
        cancelOnError: true,
      ),
    );
    _streamSubscriptions.add(
      accelerometerEventStream(samplingPeriod: sensorInterval).listen(
        (AccelerometerEvent event) {
          final now = event.timestamp;
          _accelerometerEvent = event;
          if (_accelerometerUpdateTime != null) {
            final interval = now.difference(_accelerometerUpdateTime!);
            if (interval > _ignoreDuration) {
              _accelerometerLastInterval = interval.inMilliseconds;
            }
          }
          addToGraph(accelDataX, event.x);
          addToGraph(accelDataY, event.y);
          addToGraph(accelDataZ, event.z);
          if ((event.x.abs() > highMovementThreshold && event.y.abs() > highMovementThreshold) ||
              (event.x.abs() > highMovementThreshold && event.z.abs() > highMovementThreshold) ||
              (event.y.abs() > highMovementThreshold && event.z.abs() > highMovementThreshold)) {
            alert = true; // Trigger the alert
          } else {
            alert = false; // Reset the alert if conditions are no longer met
          }
          notifyListeners();
          _accelerometerUpdateTime = now;
          notifyListeners();
        },
        onError: (e) {
          onError("User Accelerometer sensor not supported");
        },
        cancelOnError: true,
      ),
    );
    _streamSubscriptions.add(
      gyroscopeEventStream(samplingPeriod: sensorInterval).listen(
        (GyroscopeEvent event) {
          final now = event.timestamp;
          _gyroscopeEvent = event;
          if (_gyroscopeUpdateTime != null) {
            final interval = now.difference(_gyroscopeUpdateTime!);
            if (interval > _ignoreDuration) {
              _gyroscopeLastInterval = interval.inMilliseconds;
            }
          }
          addToGraph(gyroDataX, event.x);
          addToGraph(gyroDataY, event.y);
          addToGraph(gyroDataZ, event.z);
          if ((event.x.abs() > highMovementThreshold && event.y.abs() > highMovementThreshold) ||
              (event.x.abs() > highMovementThreshold && event.z.abs() > highMovementThreshold) ||
              (event.y.abs() > highMovementThreshold && event.z.abs() > highMovementThreshold)) {
            alert = true; // Trigger the alert
          } else {
            alert = false; // Reset the alert if conditions are no longer met
          }
          notifyListeners();
          _gyroscopeUpdateTime = now;
          notifyListeners();
        },
        onError: (e) {
          onError("Gyroscope sensor not supported");
        },
        cancelOnError: true,
      ),
    );
  }
}
