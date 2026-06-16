import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Numbered section heading with accent line, title, and subtitle.
class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.number,
    required this.title,
    required this.subtitle,
    this.center = false,
  });

  final String number;
  final String title;
  final String subtitle;
  final bool center;

  @override
  Widget build(BuildContext context) {
    final isMobile = AppTheme.isMobile(context);

    return Column(
      crossAxisAlignment:
          center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Number + accent line
        Row(
          mainAxisSize: center ? MainAxisSize.min : MainAxisSize.max,
          children: [
            Text(
              number,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppTheme.accent,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    letterSpacing: 1.0,
                  ),
            ),
            const SizedBox(width: 12),
            Container(
              width: isMobile ? 40 : 60,
              height: 2,
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Title
        Text(
          title,
          textAlign: center ? TextAlign.center : TextAlign.left,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: isMobile ? 28 : 40,
              ),
        ),
        const SizedBox(height: 8),
        // Subtitle
        Text(
          subtitle,
          textAlign: center ? TextAlign.center : TextAlign.left,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.textMuted,
                fontSize: isMobile ? 14 : 16,
              ),
        ),
        SizedBox(height: isMobile ? 28 : 40),
      ],
    );
  }
}
