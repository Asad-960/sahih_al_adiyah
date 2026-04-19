import '../models/dua.dart';

final List<Dua> sampleDuas = [
  const Dua(
    id: 1,
    category: 'Morning & Evening',
    title: 'Al-Mukhtar min Sahih al-Ad\'iyah',
    // Using a famous authentic dua from Sahih Muslim as a placeholder
    arabicText:
        'اللَّهُمَّ إِنِّي أَسْأَلُكَ الْهُدَى وَالتُّقَى وَالْعَفَافَ وَالْغِنَى',
    reference: 'Sahih Muslim 2721',
    translations: {
      'en': 'O Allah, I ask You for guidance, piety, chastity, and wealth.',
      'ur':
          'اے اللہ، میں تجھ سے ہدایت، تقویٰ، پاکدامنی اور غنا (بے نیازی) کا سوال کرتا ہوں۔',
    },
    isFavorite: false,
  ),
];
