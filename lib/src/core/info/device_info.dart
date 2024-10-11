import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoService {
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  Future<Map<String, dynamic>> getDeviceInfo() async {
    final deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        final androidInfo = await _deviceInfoPlugin.androidInfo;
        deviceData['version'] = androidInfo.version.release;
        deviceData['manufacturer'] = androidInfo.manufacturer;
        deviceData['model'] = androidInfo.model;
      } else if (Platform.isIOS) {
        final iosInfo = await _deviceInfoPlugin.iosInfo;
        deviceData['systemName'] = iosInfo.systemName;
        deviceData['version'] = iosInfo.systemVersion;
        deviceData['name'] = iosInfo.name;
        deviceData['model'] = iosInfo.model;
      }
    } catch (e) {
      print('Failed to get device info: $e');
    }

    return deviceData;
  }
}
