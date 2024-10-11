import 'package:flutter/material.dart';
import '../device_info.dart';
import '../package_info.dart';

class DeviceInfoProvider with ChangeNotifier {
  Map<String, dynamic>? _deviceInfo;
  bool _isLoading = true;
  String? _error;

  DeviceInfoProvider() {
    _fetchDeviceInfo();
  }

  Map<String, dynamic>? get deviceInfo => _deviceInfo;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> _fetchDeviceInfo() async {
    try {
      final deviceInfoService = DeviceInfoService();
      _deviceInfo = await deviceInfoService.getDeviceInfo();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
