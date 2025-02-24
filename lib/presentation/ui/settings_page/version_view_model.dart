import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VersionViewModel extends StateNotifier<String> {
  VersionViewModel() : super('') {
    _loadSavedVersion();
    _updateVersion();
  }

  // 이전에 저장된 버전 가져와서 ui에 표시(이러면 따로 정보 불러오는 동안 로딩 표시는 안해줘도 됨)
  Future<void> _loadSavedVersion() async {
    final pre = await SharedPreferences.getInstance();
    String? savedVersion = pre.getString('app_version');
    if (savedVersion != null) {
      state = savedVersion;
    }
  }

  // 최신 버전 가져와서 업데이트
  Future<void> _updateVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String newVersion = '${packageInfo.version}+${packageInfo.buildNumber}';

      final pre = await SharedPreferences.getInstance();
      await pre.setString('app_version', newVersion);

      state = newVersion;
    } catch (e) {
      //
      log('$e');
    }
  }
}

final versionViewModelProvider = StateNotifierProvider<VersionViewModel, String>(
  (ref) => VersionViewModel(),
);