import 'package:flutter/material.dart';

import '../data/profile.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/scroll_fade_in.dart';
import '../widgets/section_heading.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key, required this.data});

  final PortfolioData data;

  @override
  Widget build(BuildContext context) {
    final isMobile = AppTheme.isMobile(context);

    return ScrollFadeIn(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: isMobile ? 40 : 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeading(
              number: '01.',
              title: 'About Me',
              subtitle: 'Impact first, design-forward, measurable delivery.',
            ),
            // Summary card
            GlassCard(
              padding: EdgeInsets.all(isMobile ? 20 : 32),
              child: Text(
                data.summary,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: isMobile ? 15 : 17,
                      height: 1.8,
                      color: AppTheme.textSecondary,
                    ),
              ),
            ),
            SizedBox(height: isMobile ? 24 : 32),
            // DNA pillars
            _buildPillars(context, isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildPillars(BuildContext context, bool isMobile) {
    const pillars = [
      _Pillar(
        icon: Icons.speed_rounded,
        title: 'Fast & Reliable',
        description: 'Performance budgets baked into CI and monitoring.',
        color: AppTheme.accent,
      ),
      _Pillar(
        icon: Icons.auto_awesome_rounded,
        title: 'Design Systems',
        description: 'Pixel-perfect handoffs with accessible components.',
        color: AppTheme.violet,
      ),
      _Pillar(
        icon: Icons.shield_outlined,
        title: 'Quality Driven',
        description: 'Crash analytics and tooling keep releases stable.',
        color: AppTheme.emerald,
      ),
    ];

    if (isMobile) {
      return Column(
        children: pillars.asMap().entries.map((entry) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: entry.key < pillars.length - 1 ? 16 : 0,
            ),
            child: _PillarCard(pillar: entry.value),
          );
        }).toList(),
      );
    }

    return Row(
      children: pillars.asMap().entries.map((entry) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: entry.key < pillars.length - 1 ? 16 : 0,
            ),
            child: _PillarCard(pillar: entry.value),
          ),
        );
      }).toList(),
    );
  }
}

class _Pillar {
  const _Pillar({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color color;
}

class _PillarCard extends StatefulWidget {
  const _PillarCard({required this.pillar});

  final _Pillar pillar;

  @override
  State<_PillarCard> createState() => _PillarCardState();
}

class _PillarCardState extends State<_PillarCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GlassCard(
        hovered: _hovered,
        accentColor: widget.pillar.color,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: widget.pillar.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                widget.pillar.icon,
                color: widget.pillar.color,
                size: 24,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.pillar.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              widget.pillar.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
