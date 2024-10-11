import 'package:flutter/material.dart';
import '../package_info.dart';

class PackageInfoProvider with ChangeNotifier {
  Map<String, dynamic>? _packageInfo;
  bool _isLoading = true;
  String? _error;

  PackageInfoProvider() {
    _fetchPackageInfo();
  }

  Map<String, dynamic>? get packageInfo => _packageInfo;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> _fetchPackageInfo() async {
    try {
      final packageInfoService = PackageInfoService();
      _packageInfo = await packageInfoService.getPackageInfo();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
