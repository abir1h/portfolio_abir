import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// A frosted-glass container with configurable blur, opacity, border and shadow.
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = AppTheme.radiusLg,
    this.blur = 12,
    this.opacity = 0.05,
    this.borderColor,
    this.hovered = false,
    this.accentColor,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double blur;
  final double opacity;
  final Color? borderColor;
  final bool hovered;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          padding: padding ?? const EdgeInsets.all(AppTheme.spacingLg),
          decoration: AppTheme.glassCard(
            borderRadius: borderRadius,
            hovered: hovered,
            accentColor: accentColor,
          ),
          child: child,
        ),
      ),
    );
  }
}
