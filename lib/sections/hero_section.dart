import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../data/profile.dart';
import '../theme/app_theme.dart';
import '../widgets/animated_gradient_text.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({
    super.key,
    required this.data,
    required this.onMailTap,
    required this.onPhoneTap,
    required this.onLinkTap,
    required this.onScrollDown,
  });

  final PortfolioData data;
  final VoidCallback onMailTap;
  final VoidCallback onPhoneTap;
  final ValueChanged<String> onLinkTap;
  final VoidCallback onScrollDown;

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {

  @override
  Widget build(BuildContext context) {
    final isMobile = AppTheme.isMobile(context);
    final data = widget.data;

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: isMobile ? 40 : 80,
        ),
        child: Column(
          crossAxisAlignment:
              isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            // Greeting
            _buildGreeting(isMobile),
            SizedBox(height: isMobile ? 16 : 20),

            // Name
            _buildName(isMobile, data),
            SizedBox(height: isMobile ? 16 : 24),

            // Typewriter designation
            _buildDesignation(isMobile),
            SizedBox(height: isMobile ? 24 : 32),

            // Summary
            _buildSummary(isMobile, data),
            SizedBox(height: isMobile ? 32 : 40),

            // Stats row
            _buildStats(isMobile, data),
            SizedBox(height: isMobile ? 32 : 48),

            // CTA buttons
            _buildCTAs(isMobile, data),
            SizedBox(height: isMobile ? 28 : 40),

            // Social icons
            _buildSocialRow(isMobile, data),
            SizedBox(height: isMobile ? 32 : 56),

            // Scroll indicator
            _buildScrollIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildGreeting(bool isMobile) {
    return Animate(
      effects: [
        FadeEffect(duration: 500.ms, delay: 200.ms),
        MoveEffect(
          begin: const Offset(-20, 0),
          end: Offset.zero,
          duration: 600.ms,
          delay: 200.ms,
        ),
      ],
      child: Row(
        mainAxisSize: isMobile ? MainAxisSize.min : MainAxisSize.max,
        children: [
          Container(
            width: isMobile ? 30 : 40,
            height: 2,
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Hello, I\'m',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.accent,
                  fontWeight: FontWeight.w500,
                  fontSize: isMobile ? 15 : 18,
                  letterSpacing: 1.5,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildName(bool isMobile, PortfolioData data) {
    return Animate(
      effects: [
        FadeEffect(duration: 700.ms, delay: 400.ms),
        ScaleEffect(
          begin: const Offset(0.9, 0.9),
          end: const Offset(1, 1),
          duration: 800.ms,
          delay: 400.ms,
          curve: Curves.easeOutBack,
        ),
      ],
      child: AnimatedGradientText(
        text: data.name,
        textAlign: isMobile ? TextAlign.center : TextAlign.left,
        style: Theme.of(context).textTheme.displayLarge!.copyWith(
              fontSize: isMobile ? 42 : 72,
            ),
      ),
    );
  }

  Widget _buildDesignation(bool isMobile) {
    return Animate(
      effects: [
        FadeEffect(duration: 500.ms, delay: 800.ms),
      ],
      child: Row(
        mainAxisSize: isMobile ? MainAxisSize.min : MainAxisSize.max,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primary.withValues(alpha: 0.2),
                  AppTheme.accent.withValues(alpha: 0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
              border: Border.all(
                color: AppTheme.accent.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.code_rounded,
                  color: AppTheme.accent,
                  size: isMobile ? 16 : 20,
                ),
                const SizedBox(width: 10),
                _TypewriterText(
                  text: widget.data.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppTheme.textPrimary,
                        fontSize: isMobile ? 14 : 18,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummary(bool isMobile, PortfolioData data) {
    return Animate(
      effects: [
        FadeEffect(duration: 600.ms, delay: 1000.ms),
        MoveEffect(
          begin: const Offset(0, 20),
          end: Offset.zero,
          duration: 600.ms,
          delay: 1000.ms,
        ),
      ],
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 680),
        child: Text(
          data.summary,
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: isMobile ? 14 : 17,
                height: 1.8,
              ),
        ),
      ),
    );
  }

  Widget _buildStats(bool isMobile, PortfolioData data) {
    final stats = [
      _StatItem(value: data.experienceLabel, label: 'Experience'),
      _StatItem(value: '12+', label: 'Projects'),
      _StatItem(value: '99.3%', label: 'Crash-free'),
    ];

    return Animate(
      effects: [
        FadeEffect(duration: 600.ms, delay: 1200.ms),
        MoveEffect(
          begin: const Offset(0, 20),
          end: Offset.zero,
          duration: 600.ms,
          delay: 1200.ms,
        ),
      ],
      child: Wrap(
        spacing: isMobile ? 24 : 48,
        runSpacing: 16,
        alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
        children: stats.map((stat) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                stat.value,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontSize: isMobile ? 28 : 36,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.accent,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                stat.label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textMuted,
                      letterSpacing: 1,
                      fontSize: 12,
                    ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCTAs(bool isMobile, PortfolioData data) {
    return Animate(
      effects: [
        FadeEffect(duration: 600.ms, delay: 1400.ms),
        MoveEffect(
          begin: const Offset(0, 20),
          end: Offset.zero,
          duration: 600.ms,
          delay: 1400.ms,
        ),
      ],
      child: Wrap(
        spacing: 16,
        runSpacing: 12,
        alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
        children: [
          // Primary CTA
          _HeroCTAButton(
            label: 'Get In Touch',
            icon: Icons.mail_outline_rounded,
            isPrimary: true,
            onTap: widget.onMailTap,
          ),
          // Secondary CTA
          _HeroCTAButton(
            label: 'View Resume',
            icon: Icons.download,
            isPrimary: false,
            onTap: () => widget.onLinkTap('cv.html'),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialRow(bool isMobile, PortfolioData data) {
    return Animate(
      effects: [
        FadeEffect(duration: 500.ms, delay: 1600.ms),
      ],
      child: Row(
        mainAxisSize: isMobile ? MainAxisSize.min : MainAxisSize.max,
        children: [
          if (data.githubUrl.isNotEmpty)
            _SocialIcon(
              icon: Icons.code,
              tooltip: 'GitHub',
              onTap: () => widget.onLinkTap(data.githubUrl),
            ),
          if (data.linkedinUrl.isNotEmpty) ...[
            const SizedBox(width: 12),
            _SocialIcon(
              icon: Icons.business_center_outlined,
              tooltip: 'LinkedIn',
              onTap: () => widget.onLinkTap(data.linkedinUrl),
            ),
          ],
          const SizedBox(width: 12),
          _SocialIcon(
            icon: Icons.mail_outline_rounded,
            tooltip: 'Email',
            onTap: widget.onMailTap,
          ),
          const SizedBox(width: 12),
          _SocialIcon(
            icon: Icons.phone_outlined,
            tooltip: 'Phone',
            onTap: widget.onPhoneTap,
          ),
        ],
      ),
    );
  }

  Widget _buildScrollIndicator() {
    return Center(
      child: Animate(
        effects: [
          FadeEffect(duration: 600.ms, delay: 2000.ms),
        ],
        child: GestureDetector(
          onTap: widget.onScrollDown,
          child: Column(
            children: [
              Text(
                'Scroll Down',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textMuted,
                      letterSpacing: 1.5,
                      fontSize: 11,
                    ),
              ),
              const SizedBox(height: 8),
              Animate(
                onPlay: (c) => c.repeat(reverse: true),
                effects: [
                  MoveEffect(
                    begin: const Offset(0, -4),
                    end: const Offset(0, 4),
                    duration: 1200.ms,
                    curve: Curves.easeInOut,
                  ),
                ],
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppTheme.accent.withValues(alpha: 0.6),
                  size: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Helper Models & Widgets ──────────────────────────────────────────────────

class _StatItem {
  const _StatItem({required this.value, required this.label});
  final String value;
  final String label;
}

class _HeroCTAButton extends StatefulWidget {
  const _HeroCTAButton({
    required this.label,
    required this.icon,
    required this.isPrimary,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback onTap;

  @override
  State<_HeroCTAButton> createState() => _HeroCTAButtonState();
}

class _HeroCTAButtonState extends State<_HeroCTAButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            gradient: widget.isPrimary ? AppTheme.primaryGradient : null,
            borderRadius: BorderRadius.circular(AppTheme.radiusSm),
            border: widget.isPrimary
                ? null
                : Border.all(
                    color: _hovered
                        ? AppTheme.accent.withValues(alpha: 0.5)
                        : AppTheme.borderSubtle,
                    width: 1.5,
                  ),
            boxShadow: _hovered
                ? AppTheme.hoverGlow(
                    widget.isPrimary ? AppTheme.primary : AppTheme.accent,
                  )
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, color: AppTheme.textPrimary, size: 18),
              const SizedBox(width: 10),
              Text(
                widget.label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  const _SocialIcon({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _hovered
                  ? AppTheme.accent.withValues(alpha: 0.15)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _hovered
                    ? AppTheme.accent.withValues(alpha: 0.4)
                    : AppTheme.borderSubtle,
              ),
            ),
            child: Icon(
              widget.icon,
              color: _hovered ? AppTheme.accent : AppTheme.textMuted,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class _TypewriterText extends StatefulWidget {
  const _TypewriterText({
    required this.text,
    required this.style,
  });

  final String text;
  final TextStyle? style;

  @override
  State<_TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<_TypewriterText> {
  String _currentText = '';
  int _charIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 70), (timer) {
      if (_charIndex < widget.text.length) {
        setState(() {
          _charIndex++;
          _currentText = widget.text.substring(0, _charIndex);
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _currentText,
          style: widget.style,
        ),
        // Blinking cursor
        AnimatedOpacity(
          opacity: _charIndex < widget.text.length ? 1 : 0,
          duration: const Duration(milliseconds: 500),
          child: Text(
            '|',
            style: widget.style?.copyWith(
              color: AppTheme.accent,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }
}
