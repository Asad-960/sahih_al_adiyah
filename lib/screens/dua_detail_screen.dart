import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/settings_provider.dart';
import '../models/dua.dart';
import '../widgets/share_dua_dialog.dart';

class DuaDetailScreen extends ConsumerStatefulWidget {
  final List<Dua> duas;
  final int initialIndex;

  const DuaDetailScreen({
    super.key,
    required this.duas,
    required this.initialIndex,
  });

  @override
  ConsumerState<DuaDetailScreen> createState() => _DuaDetailScreenState();
}

class _DuaDetailScreenState extends ConsumerState<DuaDetailScreen> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
  }

  void _copyToClipboard(Dua dua) {
    final prefaceText = dua.preface != null && dua.preface!.isNotEmpty
        ? '${dua.preface}\n'
        : '';
    final textToCopy =
        '${dua.title}\n\n$prefaceText${dua.arabicText}\n\nTranslation: ${dua.translations['en'] ?? ''}\n\nReference: ${dua.reference}';

    Clipboard.setData(ClipboardData(text: textToCopy)).then((_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Du\'a copied to clipboard')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Read Du\'a', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 2,
      ),
      body: ScrollablePositionedList.builder(
        itemCount: widget.duas.length,
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        initialScrollIndex: widget.initialIndex,
        padding: const EdgeInsets.only(bottom: 60),
        itemBuilder: (context, index) {
          final dua = widget.duas[index];

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
              border: Border.all(
                color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.3),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primaryContainer,
                          Theme.of(context).colorScheme.secondaryContainer,
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${index + 1} of ${widget.duas.length}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.copy_rounded, size: 20),
                              tooltip: 'Copy Text',
                              onPressed: () => _copyToClipboard(dua),
                            ),
                            IconButton(
                              icon: const Icon(Icons.share_rounded, size: 20),
                              tooltip: 'Share',
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => ShareDuaDialog(
                                    dua: dua,
                                    arabicFontSize: settings.arabicFontSize,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Body Content
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (dua.title.isNotEmpty)
                          Text(
                            dua.title,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        const SizedBox(height: 24),

                        // Arabic Content Box
                        Container(
                          padding: const EdgeInsets.all(24.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.35),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.1),
                            ),
                          ),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (dua.preface != null && dua.preface!.isNotEmpty) ...[
                                  Text(
                                    dua.preface!,
                                    style: GoogleFonts.amiri(
                                      fontSize: settings.arabicFontSize * 0.85,
                                      height: 1.8,
                                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                                Text(
                                  dua.arabicText,
                                  style: GoogleFonts.amiri(
                                    fontSize: settings.arabicFontSize,
                                    height: 2.2, // Improved height for Indo-Pak readability
                                    fontWeight: FontWeight.w600, // Slightly bolder for better legibility
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Translation
                        Text(
                          dua.translations['en'] ?? 'Translation not available.',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 17, height: 1.6),
                        ),
                        const SizedBox(height: 32),

                        // Reference
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.menu_book_rounded, size: 18, color: Theme.of(context).colorScheme.secondary),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                dua.reference,
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic,
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 150.ms).slideY(begin: 0.05, end: 0);
        },
      ),
    );
  }
}
