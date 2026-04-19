import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/dua_notifier.dart';
import 'dua_detail_screen.dart';

class SectionDuaListScreen extends ConsumerStatefulWidget {
  final String categoryName;

  const SectionDuaListScreen({super.key, required this.categoryName});

  @override
  ConsumerState<SectionDuaListScreen> createState() =>
      _SectionDuaListScreenState();
}

class _SectionDuaListScreenState extends ConsumerState<SectionDuaListScreen> {
  final ScrollController _scrollController = ScrollController();
  final double _itemHeight = 96.0;

  void _scrollToLetter(String letter, List<dynamic> sortedDuas) {
    final index = sortedDuas.indexWhere(
      (dua) => dua.title.toUpperCase().startsWith(letter),
    );

    if (index != -1) {
      _scrollController.animateTo(
        index * _itemHeight,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final duaState = ref.watch(duaNotifierProvider);

    final sectionDuas =
        duaState.allDuas
            .where((dua) => dua.category == widget.categoryName)
            .toList()
          ..sort((a, b) => a.title.compareTo(b.title));

    final bool showQuickJump = sectionDuas.length > 20;

    final List<String> letters =
        sectionDuas
            .map(
              (dua) => dua.title.isNotEmpty ? dua.title[0].toUpperCase() : '',
            )
            .toSet()
            .where((l) => l.isNotEmpty && RegExp(r'[A-Z]').hasMatch(l))
            .toList()
          ..sort();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButton: sectionDuas.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DuaDetailScreen(duas: sectionDuas, initialIndex: 0),
                  ),
                );
              },
              icon: const Icon(Icons.chrome_reader_mode_rounded),
              label: const Text(
                'Read Section',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
              elevation: 4,
            ).animate().scale(delay: 400.ms, curve: Curves.easeOutBack)
          : null,
      body: sectionDuas.isEmpty
          ? const Center(child: Text('No Du\'as found in this section.'))
          : Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.only(
                      bottom: 100,
                    ), // space for FAB and formatting
                    itemExtent: _itemHeight,
                    itemCount: sectionDuas.length,
                    itemBuilder: (context, index) {
                      final dua = sectionDuas[index];

                      return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 6.0,
                            ),
                            child: Card(
                              margin: EdgeInsets.zero,
                              elevation: 0,
                              color: Theme.of(
                                context,
                              ).colorScheme.surfaceVariant.withOpacity(0.4),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.outlineVariant.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DuaDetailScreen(
                                        duas: sectionDuas,
                                        initialIndex: index,
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 12.0,
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Theme.of(
                                          context,
                                        ).colorScheme.primary.withOpacity(0.1),
                                        foregroundColor: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        radius: 20,
                                        child: Text(
                                          '${index + 1}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              dua.title,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              dua.arabicText,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Amiri',
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textDirection: TextDirection.rtl,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                          .animate()
                          .fadeIn(delay: (50 * (index % 10)).ms)
                          .slideX(begin: 0.05, end: 0);
                    },
                  ),
                ),
                if (showQuickJump)
                  Container(
                    width: 30,
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceVariant.withOpacity(0.2),
                      border: Border(
                        left: BorderSide(
                          color: Theme.of(
                            context,
                          ).colorScheme.outlineVariant.withOpacity(0.2),
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: letters.map((letter) {
                        return Expanded(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => _scrollToLetter(letter, sectionDuas),
                            child: Center(
                              child: Text(
                                letter,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ).animate().fadeIn(delay: 300.ms),
              ],
            ),
    );
  }
}
