import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/dua.dart';
import '../services/dua_service.dart';
import 'dua_state.dart';

// The main provider you will watch in your UI
final duaNotifierProvider = StateNotifierProvider<DuaNotifier, DuaState>((ref) {
  final duaService = ref.watch(duaServiceProvider);
  return DuaNotifier(duaService);
});

class DuaNotifier extends StateNotifier<DuaState> {
  final DuaService _duaService;

  DuaNotifier(this._duaService) : super(const DuaState()) {
    // Automatically load duas when the notifier is initialized
    loadDuas();
  }

  /// Loads the initial list of Du'as
  Future<void> loadDuas() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final duas = await _duaService.fetchDuas();
      final categories = duas.map((d) => d.category).toSet().toList();
      state = state.copyWith(
        allDuas: duas,
        filteredDuas: duas, // Initially, filtered list is the same as all
        categories: categories,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load Du\'as: $e',
      );
    }
  }

  /// Filters the list based on the search query for the Index Table
  void searchDuas(String query) {
    if (query.isEmpty) {
      state = state.copyWith(searchQuery: query, filteredDuas: state.allDuas);
      return;
    }

    final lowerCaseQuery = query.toLowerCase();

    final filteredList = state.allDuas.where((dua) {
      // Search by title, category, or english translation
      final matchesTitle = dua.title.toLowerCase().contains(lowerCaseQuery);
      final matchesCategory = dua.category.toLowerCase().contains(
        lowerCaseQuery,
      );
      final matchesTranslation = dua.translations.values.any(
        (translation) => translation.toLowerCase().contains(lowerCaseQuery),
      );

      return matchesTitle || matchesCategory || matchesTranslation;
    }).toList();

    state = state.copyWith(searchQuery: query, filteredDuas: filteredList);
  }

  /// Toggles the favorite status of a specific Dua
  void toggleFavorite(int duaId) {
    final updatedAll = state.allDuas.map((dua) {
      if (dua.id == duaId) {
        return dua.copyWith(isFavorite: !dua.isFavorite);
      }
      return dua;
    }).toList();

    final updatedFiltered = state.filteredDuas.map((dua) {
      if (dua.id == duaId) {
        return dua.copyWith(isFavorite: !dua.isFavorite);
      }
      return dua;
    }).toList();

    state = state.copyWith(allDuas: updatedAll, filteredDuas: updatedFiltered);
  }
}
