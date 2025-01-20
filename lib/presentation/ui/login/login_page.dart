import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/ui/login/login_view_model.dart';
import 'package:oz_player/presentation/ui/login/user_view_model.dart';

class LoginPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer(builder: (context, ref, child) {
            final isLoading = ref.watch(loginViewModelProvider);

            return GestureDetector(
              onTap: isLoading == 'loading'
                  ? null
                  : () async {
                      try {
                        var route = await ref
                            .read(loginViewModelProvider.notifier)
                            .googleLogin();
                        ref
                            .read(userViewModelProvider.notifier)
                            .setUserId(route[1]);
                        if (route.isNotEmpty &&
                            isLoading != 'loading' &&
                            isLoading != 'error' &&
                            context.mounted) {
                          context.go(route[0]);
                        }
                      } catch (e) {
                        if (context.mounted) {
                          print('로그인 실패!: $e');
                          
                        }
                      }
                    },
              child: Container(
                width: 200,
                height: 60,
                child: Text('구글 로그인'),
              ),
            );
          }),
        ],
      ),
    );
  }
}
