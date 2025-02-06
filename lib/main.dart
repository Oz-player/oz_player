import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_template.dart';
import 'package:oz_player/firebase_options.dart';
import 'package:oz_player/presentation/app/router.dart';
import 'package:oz_player/presentation/theme/theme.dart';
import 'package:oz_player/presentation/widgets/audio_player/audio_player_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");

  // kakao SDK 초기화
  KakaoSdk.init(nativeAppKey: 'dea017541ec3464d927cfbc9ec26c9c4');

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(audioPlayerViewModelProvider);
    
    return MaterialApp.router(
      title: 'Oz Player',
      themeMode: ThemeMode.light,
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}