import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/dua_notifier.dart';
import 'muqaddimah_screen.dart';
import 'section_dua_list_screen.dart';

class TableOfContentsScreen extends ConsumerWidget {
  const TableOfContentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duaState = ref.watch(duaNotifierProvider);

    if (duaState.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final categories = duaState.categories;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Table of Contents',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.tertiary,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.menu_book_rounded,
                    size: 100,
                    color: Colors.white.withOpacity(0.2),
                  ).animate().scale(duration: 800.ms, curve: Curves.easeOutBack),
                ),
              ),
            ),
          ),
          if (categories.isEmpty)
            const SliverFillRemaining(
              child: Center(child: Text('No categories found.')),
            )
          else
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.5),
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    leading: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.menu_book,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    title: const Text(
                      'Introduction (المقدمة)',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MuqaddimahScreen(),
                        ),
                      );
                    },
                  ),
                ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1, end: 0),
              ),
            ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 100), // padding for floating bottom nav
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final category = categories[index];
                final duaCount = duaState.allDuas
                    .where((d) => d.category == category)
                    .length;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.5),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      leading: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.folder_open_rounded,
                          color: Theme.of(context).colorScheme.onSecondaryContainer,
                        ),
                      ),
                      title: Text(
                        category,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('$duaCount Du\'a(s)'),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SectionDuaListScreen(categoryName: category),
                          ),
                        );
                      },
                    ),
                  ).animate().fadeIn(delay: (200 + (index * 50)).ms).slideX(begin: 0.1, end: 0),
                );
              }, childCount: categories.length),
            ),
          ),
        ],
      ),
    );
  }
}
