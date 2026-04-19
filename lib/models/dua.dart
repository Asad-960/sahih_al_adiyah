class Dua {
  final int id;
  final String category;
  final String title;
  final String arabicText;
  final String? preface;
  final String reference;
  final Map<String, String> translations;
  final bool isFavorite;

  const Dua({
    required this.id,
    required this.category,
    required this.title,
    required this.arabicText,
    required this.preface,
    required this.reference,
    required this.translations,
    this.isFavorite = false,
  });

  /// Creates a copy of this Dua but with the given fields replaced with the new values.
  Dua copyWith({
    int? id,
    String? category,
    String? title,
    String? arabicText,
    String? preface,
    String? reference,
    Map<String, String>? translations,
    bool? isFavorite,
  }) {
    return Dua(
      id: id ?? this.id,
      category: category ?? this.category,
      title: title ?? this.title,
      arabicText: arabicText ?? this.arabicText,
      preface: preface ?? this.preface,
      reference: reference ?? this.reference,
      translations: translations ?? this.translations,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  /// Creates a Dua instance from a JSON map.
  factory Dua.fromJson(Map<String, dynamic> json) {
    return Dua(
      id: json['id'] as int,
      category: json['category'] as String,
      title: json['title'] as String,
      preface: json['preface'] as String?,
      arabicText: json['arabicText'] as String,
      reference: json['reference'] as String,
      translations: Map<String, String>.from(json['translations'] ?? {}),
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  /// Converts this Dua instance into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'title': title,
      'preface': preface,
      'arabicText': arabicText,
      'reference': reference,
      'translations': translations,
      'isFavorite': isFavorite,
    };
  }

  @override
  String toString() {
    return 'Dua(id: $id, title: $title, category: $category, preface: $preface, isFavorite: $isFavorite)';
  }
}
