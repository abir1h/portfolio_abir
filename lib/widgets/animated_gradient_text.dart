import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Text with a shifting animated linear gradient.
class AnimatedGradientText extends StatefulWidget {
  const AnimatedGradientText({
    super.key,
    required this.text,
    required this.style,
    this.textAlign,
    this.colors,
    this.duration = const Duration(seconds: 4),
  });

  final String text;
  final TextStyle style;
  final TextAlign? textAlign;
  final List<Color>? colors;
  final Duration duration;

  @override
  State<AnimatedGradientText> createState() => _AnimatedGradientTextState();
}

class _AnimatedGradientTextState extends State<AnimatedGradientText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = widget.colors ??
        const [
          Color(0xFFFFFFFF),
          AppTheme.accent,
          AppTheme.primary,
          Color(0xFF8B5CF6),
        ];

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final shift = _controller.value * 2 - 1; // -1 to 1
        return ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: colors,
            stops: List.generate(
              colors.length,
              (i) => (i / (colors.length - 1) + shift * 0.3).clamp(0.0, 1.0),
            ),
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: child,
        );
      },
      child: Text(
        widget.text,
        textAlign: widget.textAlign,
        style: widget.style.copyWith(color: Colors.white),
      ),
    );
  }
}
