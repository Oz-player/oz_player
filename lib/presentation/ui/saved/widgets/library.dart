import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oz_player/presentation/theme/app_colors.dart';
import 'package:oz_player/presentation/ui/saved/view_models/library_view_model.dart';

class Library extends ConsumerStatefulWidget {
  const Library({
    super.key,
  });

  @override
  ConsumerState<Library> createState() => _LibraryState();
}

class _LibraryState extends ConsumerState<Library> {
  @override
  Widget build(BuildContext context) {
    final libraryAsync = ref.watch(libraryViewModelProvider);

    return SizedBox(
      width: double.infinity,
      height: 586,
      child: libraryAsync.when(
        data: (data) {
          if (data.isEmpty) {
            return Container();
          }
          return Expanded(
              child: GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.7,
            children: data.map((e) {
              return GestureDetector(
                onTap: () {
                  context.go('/saved/library');
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        color: AppColors.gray400,
                      ),
                      Spacer(),
                      Text(
                          '${e.createdAt.year}/${e.createdAt.month}/${e.createdAt.day}')
                    ],
                  ),
                ),
              );
            }).toList(),
          ));
        },
        error: (error, stackTrace) => Container(),
        loading: () => Container(),
      ),
    );
  }
}
