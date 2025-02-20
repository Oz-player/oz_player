import 'dart:io';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:flutter/material.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

// 앱 패키지 이름 가져오는 함수
Future<String> getPackageName() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.packageName;
}

// 지금 들어와있는 앱 설정 열기(안드로이드, IOS 기기 자체 앱설정 페이지)
Future<void> openAppSettings() async {
  if (Platform.isAndroid) {
    final intent = AndroidIntent(
      action: 'android.settings.APPLICATION_DETAILS_SETTINGS',
      data: 'package:${await getPackageName()}',
      flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
    );
    await intent.launch();
  } else if (Platform.isIOS) {
    await launchUrl(Uri.parse('app-settings:'));
  }
}

class GoAppSettingsButton extends StatelessWidget {
  const GoAppSettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await openAppSettings();
      },
      child: Container(
        height: 64,
        width: double.infinity,
        color: Colors.transparent,
        child: Row(
          children: [
            Text(
              '알림 설정',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.gray600,
                fontWeight: FontWeight.w500,
                height: 17 / 14,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: AppColors.gray600,
            ),
          ],
        ),
      ),
    );
  }
}
