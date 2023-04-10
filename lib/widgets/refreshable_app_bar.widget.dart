import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefreshableAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const RefreshableAppBar(
      {Key? key, required this.title, required this.refreshables})
      : super(key: key);

  final String title;
  final List<ProviderOrFamily?> refreshables;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Text(title),
      actions: refreshables.isNotEmpty
          ? [
              IconButton(
                  onPressed: () {
                    for (final provider in refreshables) {
                      ref.invalidate(provider!);
                    }
                  },
                  icon: const Icon(Icons.refresh))
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
