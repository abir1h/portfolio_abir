import 'package:flutter/material.dart';

import '../data/profile.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/scroll_fade_in.dart';
import '../widgets/section_heading.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key, required this.data});

  final PortfolioData data;

  static const _categoryIcons = {
    'Core': Icons.hub_rounded,
    'Ecosystem': Icons.cloud_queue_rounded,
    'State Management': Icons.account_tree_rounded,
    'Practices': Icons.verified_rounded,
  };

  static const _categoryColors = {
    'Core': AppTheme.accent,
    'Ecosystem': AppTheme.emerald,
    'State Management': AppTheme.violet,
    'Practices': AppTheme.primary,
  };

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
              number: '04.',
              title: 'Skills & Tools',
              subtitle: 'Modern Flutter stack with battle-tested patterns.',
            ),
            if (isMobile)
              Column(
                children: data.skills.map((category) {
                  final icon = _categoryIcons[category.title] ?? Icons.code_rounded;
                  final color = _categoryColors[category.title] ?? AppTheme.accent;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _SkillCategoryCard(
                      category: category,
                      icon: icon,
                      color: color,
                    ),
                  );
                }).toList(),
              )
            else
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: data.skills
                          .asMap()
                          .entries
                          .where((entry) => entry.key % 2 == 0)
                          .map((entry) {
                        final category = entry.value;
                        final icon = _categoryIcons[category.title] ?? Icons.code_rounded;
                        final color = _categoryColors[category.title] ?? AppTheme.accent;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _SkillCategoryCard(
                            category: category,
                            icon: icon,
                            color: color,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      children: data.skills
                          .asMap()
                          .entries
                          .where((entry) => entry.key % 2 == 1)
                          .map((entry) {
                        final category = entry.value;
                        final icon = _categoryIcons[category.title] ?? Icons.code_rounded;
                        final color = _categoryColors[category.title] ?? AppTheme.accent;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _SkillCategoryCard(
                            category: category,
                            icon: icon,
                            color: color,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _SkillCategoryCard extends StatefulWidget {
  const _SkillCategoryCard({
    required this.category,
    required this.icon,
    required this.color,
  });

  final SkillCategory category;
  final IconData icon;
  final Color color;

  @override
  State<_SkillCategoryCard> createState() => _SkillCategoryCardState();
}

class _SkillCategoryCardState extends State<_SkillCategoryCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GlassCard(
        hovered: _hovered,
        accentColor: widget.color,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: widget.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    widget.icon,
                    color: widget.color,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  widget.category.title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Skill chips
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.category.skills.map((skill) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: widget.color.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: widget.color.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Text(
                    skill,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
