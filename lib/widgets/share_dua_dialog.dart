import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../models/dua.dart';

class ShareDuaDialog extends StatefulWidget {
  final Dua dua;
  final double arabicFontSize;

  const ShareDuaDialog({
    super.key,
    required this.dua,
    required this.arabicFontSize,
  });

  @override
  State<ShareDuaDialog> createState() => _ShareDuaDialogState();
}

class _ShareDuaDialogState extends State<ShareDuaDialog> {
  final GlobalKey _globalKey = GlobalKey();
  bool _isSharing = false;

  Future<void> _captureAndShare() async {
    setState(() {
      _isSharing = true;
    });

    try {
      // 1. Capture the widget as an image using the GlobalKey
      RenderRepaintBoundary boundary =
          _globalKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;

      // Use a high pixel ratio for a crisp, HD image
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // 2. Save it to a temporary directory
      final directory = await getTemporaryDirectory();
      final imagePath = '${directory.path}/dua_share_${widget.dua.id}.png';
      File imgFile = File(imagePath);
      await imgFile.writeAsBytes(pngBytes);

      // 3. Share the image file via the native share sheet
      await Share.shareXFiles([
        XFile(imagePath),
      ], text: 'Read more authentic Du\'as in the Sahih al-Ad\'iyah App.');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error sharing image: $e')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSharing = false;
        });
        Navigator.pop(context); // Close the dialog after sharing
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // The actual card that will be converted to an image
            RepaintBoundary(
              key: _globalKey,
              child: Container(
                padding: const EdgeInsets.all(32.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Decorative Header
                    Icon(
                      Icons.mosque_rounded,
                      size: 40,
                      color: Colors.green.shade700,
                    ),
                    const SizedBox(height: 16),

                    // Preface (If it exists)
                    if (widget.dua.preface != null &&
                        widget.dua.preface!.isNotEmpty) ...[
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          widget.dua.preface!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.amiri(
                            fontSize: widget.arabicFontSize * 0.7,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Main Arabic Text
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        widget.dua.arabicText,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.amiri(
                          fontSize: widget.arabicFontSize,
                          height: 1.8,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Translation
                    Text(
                      widget.dua.translations['en'] ?? '',
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(height: 1.5),
                    ),
                    const SizedBox(height: 24),

                    // Reference & App Watermark
                    Divider(color: Colors.green.shade200),
                    const SizedBox(height: 16),
                    Text(
                      widget.dua.reference,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Shared via Sahih al-Ad\'iyah',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.5),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // The Share Button (This is outside the boundary, so it won't be in the final image)
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _isSharing ? null : _captureAndShare,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                icon: _isSharing
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.share_rounded),
                label: Text(
                  _isSharing ? 'Preparing Image...' : 'Share as Image',
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
