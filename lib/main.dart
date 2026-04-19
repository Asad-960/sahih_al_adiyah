import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'providers/settings_provider.dart';
import 'screens/table_of_contents_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: SahihAlAdiyahApp()));
}

class SahihAlAdiyahApp extends ConsumerWidget {
  const SahihAlAdiyahApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return MaterialApp(
      title: 'Sahih al-Ad\'iyah',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F4C3A), // Premium Emerald Green
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.outfitTextTheme(ThemeData.light().textTheme),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F4C3A), // Premium Emerald Green
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme),
        useMaterial3: true,
      ),
      themeMode: settings.themeMode,
      home: const MainBaseScreen(),
    );
  }
}

// A base screen to hold our BottomNavigationBar
class MainBaseScreen extends StatefulWidget {
  const MainBaseScreen({super.key});

  @override
  State<MainBaseScreen> createState() => _MainBaseScreenState();
}

class _MainBaseScreenState extends State<MainBaseScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const TableOfContentsScreen(),
    const FavoritesScreen(),
    const SettingsScreen(), 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // required for floating glassmorphism nav bar
      body: _screens[_currentIndex],
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: NavigationBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                indicatorColor: Theme.of(context).colorScheme.primaryContainer,
                selectedIndex: _currentIndex,
                onDestinationSelected: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.menu_book_rounded),
                    label: 'Index',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.favorite_rounded),
                    label: 'Favorites',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.settings_rounded),
                    label: 'Settings',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
