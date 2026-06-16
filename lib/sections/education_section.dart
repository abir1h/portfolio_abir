import 'package:flutter/material.dart';

import '../data/profile.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/scroll_fade_in.dart';
import '../widgets/section_heading.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key, required this.data});

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
              number: '05.',
              title: 'Education',
              subtitle: 'Grounded in computer science fundamentals.',
            ),
            ...data.education.asMap().entries.map((entry) {
              final index = entry.key;
              final edu = entry.value;
              final isLast = index == data.education.length - 1;

              return _EducationNode(
                education: edu,
                isLast: isLast,
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _EducationNode extends StatefulWidget {
  const _EducationNode({
    required this.education,
    required this.isLast,
  });

  final Education education;
  final bool isLast;

  @override
  State<_EducationNode> createState() => _EducationNodeState();
}

class _EducationNodeState extends State<_EducationNode> {
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
              top: 32,
              bottom: 0,
              width: 2,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppTheme.violet.withValues(alpha: 0.3),
                      AppTheme.primary.withValues(alpha: 0.08),
                    ],
                  ),
                ),
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline
              SizedBox(
                width: isMobile ? 40 : 56,
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: _hovered
                          ? AppTheme.accentGradient
                          : AppTheme.primaryGradient,
                      boxShadow: _hovered
                          ? [
                              BoxShadow(
                                color: AppTheme.violet.withValues(alpha: 0.4),
                                blurRadius: 12,
                              ),
                            ]
                          : null,
                    ),
                    child: Icon(
                      Icons.school_rounded,
                      color: AppTheme.textPrimary,
                      size: isMobile ? 14 : 16,
                    ),
                  ),
                ),
              ),
              // Card
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: widget.isLast ? 0 : 20),
                child: GlassCard(
                  hovered: _hovered,
                  accentColor: AppTheme.violet,
                  padding: EdgeInsets.all(isMobile ? 16 : 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.education.degree,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.education.institution,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: AppTheme.textMuted,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.violet.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color:
                                    AppTheme.violet.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Text(
                              widget.education.period,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppTheme.violet,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.education.location,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: AppTheme.textMuted,
                                  fontSize: 11,
                                ),
                          ),
                        ],
                      ),
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
