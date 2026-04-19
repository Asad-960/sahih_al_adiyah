import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MuqaddimahScreen extends StatelessWidget {
  const MuqaddimahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final baseArabicStyle = GoogleFonts.amiri(
      fontSize: 26,
      height: 2.2,
      color: Theme.of(context).colorScheme.onSurface,
    );

    final quranicStyle = baseArabicStyle.copyWith(
      color: Colors.green.shade700,
      fontWeight: FontWeight.w600,
    );

    final referenceStyle = baseArabicStyle.copyWith(
      fontSize: 20,
      color: Theme.of(context).colorScheme.secondary,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Introduction'),
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ',
                textAlign: TextAlign.center,
                style: GoogleFonts.amiri(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 24),

              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green.shade700, width: 2),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.green.shade50,
                  ),
                  child: Text(
                    'المُقَدِّمَة',
                    style: GoogleFonts.amiri(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade900,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              Text.rich(
                TextSpan(
                  style: baseArabicStyle,
                  children: [
                    // --- Page 1 Text ---
                    const TextSpan(text: 'الْحَمْدُ لِلَّهِ الَّذِي لَمْ يَجْعَلْ بَيْنَهُ وَبَيْنَ عِبَادِهِ وَاسِطَةً فِي الدُّعَاءِ، وَهُوَ الْقَائِلُ: '),
                    TextSpan(text: '﴿وَإِذَا سَأَلَكَ عِبَادِي عَنِّي فَإِنِّي قَرِيبٌ ۖ أُجِيبُ دَعْوَةَ الدَّاعِ إِذَا دَعَانِ﴾ ', style: quranicStyle),
                    TextSpan(text: '[البقرة: ١٨٦]', style: referenceStyle),
                    const TextSpan(text: '، وَالْقَائِلُ: '),
                    TextSpan(text: '﴿وَقَالَ رَبُّكُمُ ادْعُونِي أَسْتَجِبْ لَكُمْ﴾ ', style: quranicStyle),
                    TextSpan(text: '[غافر: ٦٠]', style: referenceStyle),
                    const TextSpan(text: '، وَالصَّلَاةُ وَالسَّلَامُ عَلَى رَسُولِهِ الْأَمِينِ، الْقَائِلِ: «الدُّعَاءُ هُوَ الْعِبَادَةُ». '),
                    TextSpan(text: '[أحمد وغيره]', style: referenceStyle),
                    const TextSpan(text: '، وَالْقَائِلِ: «مَنْ لَمْ يَسْأَلِ اللَّهَ؛ يَغْضَبْ عَلَيْهِ». '),
                    TextSpan(text: '[الترمذي]', style: referenceStyle),
                    const TextSpan(text: '.\n\n'),
                    
                    const TextSpan(text: 'وَبَعْدُ: فَإِنَّ دُعَاءَ اللَّهِ وَالْإِلْحَاحَ عَلَيْهِ؛ شَأْنُ نَبِيِّنَا مُحَمَّدٍ ﷺ، وَشَأْنُ الْأَنْبِيَاءِ مِنْ قَبْلِهِ، وَشَأْنُ الصَّالِحِينَ، وَلَيْسَ أَمْرٌ مِنْ أُمُورِ الدُّنْيَا وَالْآخِرَةِ إِلَّا وَقَدْ جَعَلَ اللَّهُ عَزَّ وَجَلَّ مِفْتَاحَ تَحْقِيقِهِ وَالْوُصُولِ إِلَيْهِ: الدُّعَاءُ.\n\n'),
                    
                    // --- Page 2 Text ---
                    const TextSpan(text: 'وَاللَّهُ يُحِبُّ الْمُلِحِّينَ، وَيُجِيبُ دَعْوَةَ الْمُضْطَرِّينَ:\n'),
                    TextSpan(text: '﴿أَمَّن يُجِيبُ الْمُضْطَرَّ إِذَا دَعَاهُ﴾ ', style: quranicStyle),
                    TextSpan(text: '[النمل: ٦٢]', style: referenceStyle),
                    const TextSpan(text: '\n\nوَأَفْضَلُ الدُّعَاءِ وَالذِّكْرِ: مَا كَانَ مَأْخُوذًا مِنْ كَلَامِ رَبِّنَا تَبَارَكَ وَتَعَالَى، وَمِنْ سُنَّةِ نَبِيِّنَا مُحَمَّدٍ ﷺ.\n\n'),
                    const TextSpan(text: 'وَتَعَاوُنًا عَلَى الْبِرِّ وَالتَّقْوَى، وَتَسْهِيلًا عَلَى إِخْوَانِي الْمُسْلِمِينَ، وَخَاصَّةً عَلَى مَنْ لَا يَحْفَظُ الْأَدْعِيَةَ؛ فَقَدْ يَسَّرَ اللَّهُ جَمْعَ هَذِهِ الْأَدْعِيَةِ مِنَ الْكِتَابِ وَالسَّلُنَّةِ الصَّحِيحَةِ، وَأَرْجُو مِنَ اللَّهِ عَزَّ وَجَلَّ الثَّوَابَ، وَأَنْ يَنْفَعَنِي بِهَذَا الْجَمْعِ وَإِخْوَانِي الْمُسْلِمِينَ.\n\n'),
                    const TextSpan(text: 'وَصَلَّى اللَّهُ وَسَلَّمَ عَلَى نَبِيِّنَا مُحَمَّدٍ، وَعَلَى آلِهِ وَصَحْبِهِ أَجْمَعِينَ.\n\n'),
                  ],
                ),
                textAlign: TextAlign.justify,
              ),
              
              // Sign-off (Green)
              Text(
                'الداعي لكم بالخير\nأبو محمد',
                textAlign: TextAlign.center,
                style: GoogleFonts.amiri(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}