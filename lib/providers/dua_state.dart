import '../models/dua.dart';

class DuaState {
  final List<Dua> allDuas;
  final List<Dua> filteredDuas;
  final List<String> categories;
  final bool isLoading;
  final String searchQuery;
  final String? error;

  const DuaState({
    this.allDuas = const [],
    this.filteredDuas = const [],
    this.categories = const [],
    this.isLoading = true,
    this.searchQuery = '',
    this.error,
  });

  DuaState copyWith({
    List<Dua>? allDuas,
    List<Dua>? filteredDuas,
    List<String>? categories,
    bool? isLoading,
    String? searchQuery,
    String? error,
  }) {
    return DuaState(
      allDuas: allDuas ?? this.allDuas,
      filteredDuas: filteredDuas ?? this.filteredDuas,
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      searchQuery: searchQuery ?? this.searchQuery,
      error: error ?? this.error,
    );
  }
}
