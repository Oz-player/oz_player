import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:oz_player/presentation/widgets/loading/loading_view_model/loading_view_model.dart';

class LoadingWidget extends ConsumerWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loadingState = ref.watch(loadingViewModelProvider);

    return Stack(
      children: [
        if (loadingState.index == 1)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
          ),
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.grey[900]!.withValues(alpha: 0.9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
              ),
              Text(
                loadingState.loadingText[loadingState.index],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
                textAlign: TextAlign.center,
              ),
              loadingState.loadingImage[loadingState.index].isEmpty
                  ? SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: loadingState.index == 1
                          ? Lottie.asset('assets/animation/loading.json',
                              fit: BoxFit.cover)
                          : Image.asset(
                              loadingState.loadingImage[loadingState.index]),
                    ),
              Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}
