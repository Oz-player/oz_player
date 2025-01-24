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
      color: Colors.grey[600]!.withValues(alpha: 0.6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            loadingState.loadingText[loadingState.index],
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 36),
          CircularProgressIndicator()
        ],
      ),
    );
  }
}
