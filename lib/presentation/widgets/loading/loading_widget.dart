import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oz_player/presentation/widgets/loading/loading_view_model/loading_view_model.dart';

class LoadingWidget extends ConsumerWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loadingState = ref.watch(loadingViewModelProvider);

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey[900]!.withValues(alpha: 0.6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Text(
            loadingState.loadingText[loadingState.index],
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 44),
          Container(width: 180, height: 180, color: Colors.red,),
          SizedBox(height: 80,),
          Spacer()
        ],
      ),
    );
  }
}
