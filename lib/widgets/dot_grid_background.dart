import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Subtle animated dot grid painted behind the main content.
/// Dots fade and shift slightly based on scroll offset for parallax feel.
class DotGridBackground extends StatelessWidget {
  const DotGridBackground({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, child) {
        final scrollOffset =
            scrollController.hasClients ? scrollController.offset : 0.0;
        final parallaxShift = scrollOffset * 0.04;
        final translationY = -(parallaxShift % 50.0);

        return Transform.translate(
          offset: Offset(0, translationY),
          child: RepaintBoundary(
            child: CustomPaint(
              painter: const _StaticDotGridPainter(),
              size: Size.infinite,
            ),
          ),
        );
      },
    );
  }
}

class _StaticDotGridPainter extends CustomPainter {
  const _StaticDotGridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    const spacing = 50.0;
    const dotRadius = 1.2;

    final paint = Paint()..style = PaintingStyle.fill;

    final cols = (size.width / spacing).ceil() + 1;
    final rows = (size.height / spacing).ceil() + 2;

    for (var row = -1; row < rows; row++) {
      for (var col = 0; col < cols; col++) {
        final x = col * spacing;
        final y = row * spacing;

        // Static subtle opacity variation based on position
        final wave = (math.sin((x + y) * 0.01) + 1) / 2;
        final alpha = 0.04 + wave * 0.06; // 4% to 10%

        paint.color = AppTheme.accent.withValues(alpha: alpha);

        canvas.drawCircle(Offset(x, y), dotRadius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_StaticDotGridPainter old) => false;
}
