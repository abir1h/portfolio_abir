import 'package:flutter/material.dart';

import '../data/profile.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/scroll_fade_in.dart';
import '../widgets/section_heading.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key, required this.data});

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
              number: '02.',
              title: 'Experience',
              subtitle:
                  'Crafting apps for education, fleet, and talent platforms.',
            ),
            // Timeline
            ...data.experiences.asMap().entries.map((entry) {
              final index = entry.key;
              final exp = entry.value;
              final isLast = index == data.experiences.length - 1;

              return _TimelineNode(
                experience: exp,
                isLast: isLast,
                index: index,
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _TimelineNode extends StatefulWidget {
  const _TimelineNode({
    required this.experience,
    required this.isLast,
    required this.index,
  });

  final Experience experience;
  final bool isLast;
  final int index;

  @override
  State<_TimelineNode> createState() => _TimelineNodeState();
}

class _TimelineNodeState extends State<_TimelineNode> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = AppTheme.isMobile(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Stack(
        children: [
          if (!widget.isLast)
            Positioned(
              left: isMobile ? 19 : 27,
              top: 24,
              bottom: 0,
              width: 2,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppTheme.accent.withValues(alpha: 0.4),
                      AppTheme.primary.withValues(alpha: 0.1),
                    ],
                  ),
                ),
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline dot
              SizedBox(
                width: isMobile ? 40 : 56,
                child: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: _hovered ? 18 : 14,
                      height: _hovered ? 18 : 14,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: AppTheme.primaryGradient,
                        boxShadow: _hovered
                            ? [
                                BoxShadow(
                                  color: AppTheme.accent.withValues(alpha: 0.6),
                                  blurRadius: 16,
                                  spreadRadius: 2,
                                ),
                              ]
                            : [
                                BoxShadow(
                                  color: AppTheme.accent.withValues(alpha: 0.3),
                                  blurRadius: 8,
                                ),
                              ],
                      ),
                    ),
                  ),
                ),
              ),
              // Card
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: widget.isLast ? 0 : 24),
                child: GlassCard(
                  hovered: _hovered,
                  accentColor: AppTheme.accent,
                  padding: EdgeInsets.all(isMobile ? 18 : 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Wrap(
                        spacing: 12,
                        runSpacing: 8,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            widget.experience.role,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: isMobile ? 16 : 18,
                                ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  AppTheme.accent.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppTheme.accent
                                    .withValues(alpha: 0.2),
                              ),
                            ),
                            child: Text(
                              widget.experience.period,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppTheme.accent,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Company + location
                      Text(
                        '${widget.experience.company} • ${widget.experience.location}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.textMuted,
                            ),
                      ),
                      const SizedBox(height: 16),
                      // Points
                      ...widget.experience.points.map((point) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 7),
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: AppTheme.accent
                                      .withValues(alpha: 0.6),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  point,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: AppTheme.textSecondary,
                                        height: 1.6,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
  }
}
