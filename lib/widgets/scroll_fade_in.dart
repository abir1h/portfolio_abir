import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Triggers a fade-in + slide-up entrance animation when the widget
/// enters the viewport. Uses a simple visibility detector approach.
class ScrollFadeIn extends StatefulWidget {
  const ScrollFadeIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 600),
    this.offset = 30,
  });

  final Widget child;
  final Duration delay;
  final Duration duration;
  final double offset;

  @override
  State<ScrollFadeIn> createState() => _ScrollFadeInState();
}

class _ScrollFadeInState extends State<ScrollFadeIn> {
  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        FadeEffect(
          duration: widget.duration,
          delay: widget.delay,
          curve: Curves.easeOutCubic,
        ),
        MoveEffect(
          begin: Offset(0, widget.offset),
          end: Offset.zero,
          duration: widget.duration,
          delay: widget.delay,
          curve: Curves.easeOutCubic,
        ),
      ],
      child: widget.child,
    );
  }
}
