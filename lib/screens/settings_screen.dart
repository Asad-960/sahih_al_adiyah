import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the current settings state
    final settings = ref.watch(settingsProvider);
    // Access the notifier to update settings
    final settingsNotifier = ref.read(settingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          // Theme Toggle
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Dark Mode',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            subtitle: const Text('Toggle between light and dark theme'),
            value: settings.themeMode == ThemeMode.dark,
            activeColor: Theme.of(context).colorScheme.primary,
            onChanged: (isDark) {
              settingsNotifier.toggleTheme(
                isDark ? ThemeMode.dark : ThemeMode.light,
              );
            },
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),

          // Font Size Slider
          const Text(
            'Arabic Font Size',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('A', style: TextStyle(fontSize: 16)),
              Expanded(
                child: Slider(
                  value: settings.arabicFontSize,
                  min: 20.0,
                  max: 60.0,
                  divisions: 20,
                  label: settings.arabicFontSize.round().toString(),
                  activeColor: Theme.of(context).colorScheme.primary,
                  onChanged: (newSize) {
                    settingsNotifier.updateFontSize(newSize);
                  },
                ),
              ),
              const Text(
                'A',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Live Preview Box
          const Text(
            'Preview',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.surfaceVariant.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            ),
            child: Text(
              'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ',
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: GoogleFonts.amiri(
                fontSize: settings.arabicFontSize,
                height: 1.8,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
