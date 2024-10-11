import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoService {
  Future<Map<String, dynamic>> getPackageInfo() async {
    final packageData = <String, dynamic>{};

    try {
      final packageInfo = await PackageInfo.fromPlatform();
      packageData['appName'] = packageInfo.appName;
      packageData['packageName'] = packageInfo.packageName;
      packageData['version'] = packageInfo.version;
      packageData['buildNumber'] = packageInfo.buildNumber;
    } catch (e) {
      print('Failed to get package info: $e');
    }

    return packageData;
  }
}
