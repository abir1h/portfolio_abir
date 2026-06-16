import 'dart:async';
import 'package:flutter/material.dart';

import '../data/profile.dart';
import '../theme/app_theme.dart';
import '../widgets/scroll_fade_in.dart';
import '../widgets/section_heading.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({
    super.key,
    required this.data,
    required this.onOpenLink,
    this.onAchievementUnlocked,
  });

  final PortfolioData data;
  final ValueChanged<String> onOpenLink;
  final ValueChanged<String>? onAchievementUnlocked;

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  final Set<String> _exploredProjects = {};

  void _markExplored(String projectName) {
    if (!_exploredProjects.contains(projectName)) {
      setState(() {
        _exploredProjects.add(projectName);
      });
      if (_exploredProjects.length == 3) {
        widget.onAchievementUnlocked?.call('project_explorer_3');
      } else if (_exploredProjects.length == 9) {
        widget.onAchievementUnlocked?.call('project_explorer_9');
      }
    }
  }

  String _getRank(int count) {
    if (count == 0) return 'Silent Observer';
    if (count < 3) return 'Curious Recruiter';
    if (count < 6) return 'Technical Reviewer';
    if (count < widget.data.projects.length) return 'Master Investigator';
    return 'Ultimate Talent Partner 🏆';
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = AppTheme.isMobile(context);
    final isTablet = AppTheme.isTablet(context);

    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);
    final themeColor = AppTheme.accent;

    final exploredCount = _exploredProjects.length;
    final totalCount = widget.data.projects.length;
    final progress = totalCount > 0 ? exploredCount / totalCount : 0.0;
    final rank = _getRank(exploredCount);

    return ScrollFadeIn(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: isMobile ? 40 : 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeading(
              number: '03.',
              title: 'Projects',
              subtitle: 'Product experiments and production launches.',
            ),
            
            // Gamified Exploration Status Banner
            Container(
              margin: const EdgeInsets.only(bottom: 28),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.cardBg,
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                border: Border.all(color: themeColor.withValues(alpha: 0.15)),
                boxShadow: [
                  BoxShadow(
                    color: themeColor.withValues(alpha: 0.04),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.stars_rounded,
                                color: themeColor,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'PORTFOLIO QUEST: DISCOVER PROJECTS',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.2,
                                  color: themeColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Rank: $rank',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: themeColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '$exploredCount / $totalCount XP',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: themeColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Smooth progress bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Stack(
                      children: [
                        Container(
                          height: 8,
                          width: double.infinity,
                          color: AppTheme.borderSubtle,
                        ),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.easeOutCubic,
                              height: 8,
                              width: constraints.maxWidth * progress,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [themeColor, themeColor.withValues(alpha: 0.6)],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: themeColor.withValues(alpha: 0.3),
                                    blurRadius: 4,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: isMobile ? 1.3 : (isTablet ? 1.1 : 1.0),
              ),
              itemCount: widget.data.projects.length,
              itemBuilder: (context, index) {
                final project = widget.data.projects[index];
                return _ProjectCard(
                  project: project,
                  onOpen: widget.onOpenLink,
                  index: index,
                  isExplored: _exploredProjects.contains(project.name),
                  onExplored: () => _markExplored(project.name),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({
    required this.project,
    required this.onOpen,
    required this.index,
    required this.isExplored,
    required this.onExplored,
  });

  final Project project;
  final ValueChanged<String> onOpen;
  final int index;
  final bool isExplored;
  final VoidCallback onExplored;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;
  Timer? _exploreTimer;

  @override
  void dispose() {
    _exploreTimer?.cancel();
    super.dispose();
  }

  void _onEnter() {
    setState(() => _hovered = true);
    if (!widget.isExplored) {
      _exploreTimer = Timer(const Duration(milliseconds: 1000), () {
        widget.onExplored();
      });
    }
  }

  void _onExit() {
    setState(() => _hovered = false);
    _exploreTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final playStoreLink = widget.project.playStoreLink;
    final appStoreLink = widget.project.appStoreLink;
    final generalLink = widget.project.link;

    final hasPlayStore = playStoreLink != null && playStoreLink.isNotEmpty;
    final hasAppStore = appStoreLink != null && appStoreLink.isNotEmpty;
    final primaryLink = hasPlayStore ? playStoreLink : (hasAppStore ? appStoreLink : generalLink);
    final isCardClickable = primaryLink.isNotEmpty;

    final colors = [AppTheme.accent, AppTheme.violet, AppTheme.emerald];
    final accentColor = colors[widget.index % colors.length];

    return MouseRegion(
      onEnter: (_) => _onEnter(),
      onExit: (_) => _onExit(),
      cursor:
          isCardClickable ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: isCardClickable ? () {
          widget.onExplored();
          widget.onOpen(primaryLink);
        } : null,
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          tween: Tween(begin: 0, end: _hovered ? -6 : 0),
          builder: (context, value, child) =>
              Transform.translate(offset: Offset(0, value), child: child),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(1.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppTheme.radiusLg + 2),
              gradient: _hovered
                  ? LinearGradient(
                      colors: [accentColor, AppTheme.primary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: _hovered ? AppTheme.cardBgHover : AppTheme.cardBg,
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                border: _hovered
                    ? null
                    : Border.all(color: AppTheme.borderSubtle),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row
                  Row(
                    children: [
                      // Folder icon + Explored checkmark badge
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: accentColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.folder_open_rounded,
                              color: accentColor,
                              size: 22,
                            ),
                          ),
                          if (widget.isExplored)
                            Positioned(
                              top: -4,
                              right: -4,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.green.withValues(alpha: 0.5),
                                      blurRadius: 6,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 10,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const Spacer(),
                      if (hasPlayStore)
                        _LinkIconButton(
                          icon: Icons.android_rounded,
                          tooltip: 'Play Store',
                          onTap: () {
                            widget.onExplored();
                            widget.onOpen(playStoreLink);
                          },
                          accentColor: accentColor,
                        ),
                      if (hasAppStore) ...[
                        if (hasPlayStore) const SizedBox(width: 8),
                        _LinkIconButton(
                          icon: Icons.apple,
                          tooltip: 'App Store',
                          onTap: () {
                            widget.onExplored();
                            widget.onOpen(appStoreLink);
                          },
                          accentColor: accentColor,
                        ),
                      ],
                      if (!hasPlayStore && !hasAppStore && generalLink.isNotEmpty)
                        _LinkIconButton(
                          icon: Icons.open_in_new_rounded,
                          tooltip: 'Open Link',
                          onTap: () {
                            widget.onExplored();
                            widget.onOpen(generalLink);
                          },
                          accentColor: accentColor,
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Title
                  Text(
                    widget.project.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: _hovered
                              ? accentColor
                              : AppTheme.textPrimary,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  // Description
                  Expanded(
                    child: Text(
                      widget.project.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.textSecondary,
                            height: 1.5,
                          ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Tags
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: widget.project.tags.map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: accentColor.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: accentColor.withValues(alpha: 0.15),
                          ),
                        ),
                        child: Text(
                          tag,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: accentColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11,
                                  ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LinkIconButton extends StatefulWidget {
  const _LinkIconButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    required this.accentColor,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final Color accentColor;

  @override
  State<_LinkIconButton> createState() => _LinkIconButtonState();
}

class _LinkIconButtonState extends State<_LinkIconButton> {
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
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: _hovered
                  ? widget.accentColor.withValues(alpha: 0.15)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _hovered
                    ? widget.accentColor.withValues(alpha: 0.25)
                    : Colors.transparent,
              ),
            ),
            child: Icon(
              widget.icon,
              color: _hovered ? widget.accentColor : AppTheme.textMuted,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
