import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/dua_notifier.dart';
import 'dua_detail_screen.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duaState = ref.watch(duaNotifierProvider);
    final favoriteDuas = duaState.allDuas
        .where((dua) => dua.isFavorite)
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Du\'as')),
      body: favoriteDuas.isEmpty
          ? const Center(child: Text('No favorites yet. Add some!'))
          : ListView.builder(
              itemCount: favoriteDuas.length,
              itemBuilder: (context, index) {
                final dua = favoriteDuas[index];
                return ListTile(
                  title: Text(
                    dua.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(dua.category),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () => ref
                        .read(duaNotifierProvider.notifier)
                        .toggleFavorite(dua.id),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DuaDetailScreen(
                          duas: favoriteDuas,
                          initialIndex: index,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
