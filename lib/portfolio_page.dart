import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import 'data/profile.dart';
import 'sections/about_section.dart';
import 'sections/contact_section.dart';
import 'sections/education_section.dart';
import 'sections/experience_section.dart';
import 'sections/hero_section.dart';
import 'sections/projects_section.dart';
import 'sections/practise_section.dart';
import 'sections/skills_section.dart';
import 'theme/app_theme.dart';
import 'widgets/dot_grid_background.dart';
import 'widgets/nav_bar.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key, required this.data});

  final PortfolioData data;

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _scrollController = ScrollController();
  final _activeSectionNotifier = ValueNotifier<int>(0);

  // Section keys for scroll-to navigation
  final _sectionKeys = List.generate(7, (_) => GlobalKey());

  // Gamification state
  final Set<String> _unlockedAchievements = {};
  final List<AchievementNotification> _activeNotifications = [];

  void _unlockAchievement(String id) {
    if (_unlockedAchievements.contains(id)) return;

    setState(() {
      _unlockedAchievements.add(id);
    });

    String title = '';
    String desc = '';
    IconData icon = Icons.emoji_events_rounded;

    switch (id) {
      case 'curious_mind':
        title = 'Curious Mind';
        desc = 'Read the Professional Summary (+10 XP)';
        icon = Icons.psychology_rounded;
        break;
      case 'career_tracker':
        title = 'Career Tracker';
        desc = 'Reviewed BacBon & SCS Limited Work Experience (+10 XP)';
        icon = Icons.timeline_rounded;
        break;
      case 'skill_appraiser':
        title = 'Skill Appraiser';
        desc = 'Audited Skills & Competencies list (+10 XP)';
        icon = Icons.construction_rounded;
        break;
      case 'academic_reviewer':
        title = 'Academic Reviewer';
        desc = 'Checked educational credentials (+10 XP)';
        icon = Icons.school_rounded;
        break;
      case 'initiator':
        title = 'Initiator';
        desc = 'Interacted with contact links (+15 XP)';
        icon = Icons.chat_bubble_outline_rounded;
        break;
      case 'project_explorer_3':
        title = 'Explorer';
        desc = 'Discovered 3 projects in the catalog (+15 XP)';
        icon = Icons.explore_outlined;
        break;
      case 'project_explorer_9':
        title = 'Master Explorer';
        desc = 'Discovered all 9 project cards (+25 XP)';
        icon = Icons.workspace_premium_rounded;
        break;
      case 'resume_auditor':
        title = 'Resume Auditor';
        desc = 'Opened the printable CV file (+15 XP)';
        icon = Icons.description_rounded;
        break;
    }

    final notif = AchievementNotification(
      id: id,
      title: title,
      description: desc,
      icon: icon,
    );

    setState(() {
      _activeNotifications.add(notif);
    });

    Timer(const Duration(milliseconds: 3000), () {
      if (mounted) {
        setState(() {
          _activeNotifications.removeWhere((n) => n.id == id);
        });
      }
    });
  }

  void _checkScrollAchievements(int sectionIndex) {
    if (sectionIndex == 1) {
      _unlockAchievement('curious_mind');
    } else if (sectionIndex == 2) {
      _unlockAchievement('career_tracker');
    } else if (sectionIndex == 5) {
      _unlockAchievement('skill_appraiser');
      _unlockAchievement('academic_reviewer');
    } else if (sectionIndex == 6) {
      _unlockAchievement('initiator');
    }
  }

  void _showQuestDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final achievementsList = [
          {'id': 'curious_mind', 'title': 'Curious Mind', 'desc': 'Scroll & read the Professional Summary'},
          {'id': 'career_tracker', 'title': 'Career Tracker', 'desc': 'Review Work Experience details'},
          {'id': 'skill_appraiser', 'title': 'Skill Appraiser', 'desc': 'Inspect technical skills list'},
          {'id': 'academic_reviewer', 'title': 'Academic Reviewer', 'desc': 'Check university education degree'},
          {'id': 'initiator', 'title': 'Initiator', 'desc': 'View contact information at the bottom'},
          {'id': 'project_explorer_3', 'title': 'Explorer', 'desc': 'Discover 3 projects in the catalog'},
          {'id': 'project_explorer_9', 'title': 'Master Explorer', 'desc': 'Discover all 9 project cards'},
          {'id': 'resume_auditor', 'title': 'Resume Auditor', 'desc': 'Click the View Resume button'},
        ];

        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 420),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppTheme.cardBg,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppTheme.borderSubtle),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Career Quest Log 🏆',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: AppTheme.textMuted),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Explore the portfolio, hover over cards, and check contacts to unlock special recruiter achievements.',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 20),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: achievementsList.map((ach) {
                      final isUnlocked = _unlockedAchievements.contains(ach['id']);
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: isUnlocked
                              ? Colors.green.withValues(alpha: 0.05)
                              : AppTheme.cardBgHover.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isUnlocked
                                ? Colors.green.withValues(alpha: 0.25)
                                : AppTheme.borderSubtle,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isUnlocked ? Icons.check_circle_rounded : Icons.lock_outline_rounded,
                              color: isUnlocked ? Colors.green : AppTheme.textMuted,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ach['title']!,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: isUnlocked ? AppTheme.textPrimary : AppTheme.textMuted,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    ach['desc']!,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: isUnlocked ? AppTheme.textSecondary : AppTheme.textMuted.withValues(alpha: 0.8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _activeSectionNotifier.dispose();
    super.dispose();
  }

  void _onScroll() {
    _updateActiveSection();
  }

  void _updateActiveSection() {
    for (var i = _sectionKeys.length - 1; i >= 0; i--) {
      final key = _sectionKeys[i];
      final context = key.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          final position = box.localToGlobal(Offset.zero).dy;
          if (position <= 100) {
            if (_activeSectionNotifier.value != i) {
              _activeSectionNotifier.value = i;
              _checkScrollAchievements(i);
            }
            return;
          }
        }
      }
    }
  }

  void _scrollToSection(int index) {
    final key = _sectionKeys[index];
    final context = key.currentContext;
    if (context != null) {
      final box = context.findRenderObject() as RenderBox?;
      if (box != null) {
        final position = box.localToGlobal(Offset.zero);
        final targetOffset = _scrollController.offset + position.dy - 60;
        _scrollController.animateTo(
          targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOutCubic,
        );
      }
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
    );
  }

  // ── Launchers ──────────────────────────────────────────────────────────

  Future<void> _launchUri(
    Uri uri, {
    LaunchMode mode = LaunchMode.platformDefault,
  }) async {
    final success = await launchUrl(uri, mode: mode);
    if (!success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to open link right now.')),
      );
    }
  }

  Future<void> _launchLink(String url) async {
    if (url.isEmpty) return;
    final uri = Uri.base.resolve(url);
    if (url.contains('cv.html')) {
      _unlockAchievement('resume_auditor');
    } else {
      _unlockAchievement('initiator');
    }
    await _launchUri(uri, mode: LaunchMode.externalApplication);
  }

  void _launchMail() {
    _unlockAchievement('initiator');
    _launchUri(Uri(scheme: 'mailto', path: widget.data.email));
  }

  void _launchPhone() {
    _unlockAchievement('initiator');
    _launchUri(Uri(scheme: 'tel', path: widget.data.phone));
  }

  Widget _buildQuestFloatingButton() {
    final unlockedCount = _unlockedAchievements.length;
    final totalCount = 8;

    return Positioned(
      bottom: 24,
      right: 24,
      child: RepaintBoundary(
        child: FloatingActionButton.extended(
          onPressed: _showQuestDialog,
          backgroundColor: AppTheme.cardBg,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: Colors.amber.withValues(alpha: 0.6), width: 1.5),
          ),
          icon: const Icon(
            Icons.emoji_events_rounded,
            color: Colors.amber,
            size: 20,
          )
              .animate(onPlay: (controller) => controller.repeat())
              .shimmer(duration: 2.seconds, delay: 4.seconds),
          label: Text(
            'Quest: $unlockedCount/$totalCount',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: AppTheme.textPrimary,
            ),
          ),
        )
            .animate()
            .scale(
              begin: const Offset(0, 0),
              end: const Offset(1, 1),
              duration: 500.ms,
              curve: Curves.elasticOut,
              delay: 2.seconds,
            ),
      ),
    );
  }

  Widget _buildAchievementNotifications() {
    if (_activeNotifications.isEmpty) return const SizedBox.shrink();

    return Positioned(
      top: 80,
      right: 24,
      width: 320,
      child: RepaintBoundary(
        child: Column(
          children: _activeNotifications.map((notif) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.cardBg.withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber.withValues(alpha: 0.8), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withValues(alpha: 0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.amber.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      notif.icon,
                      color: Colors.amber,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'QUEST UNLOCKED 🏆',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.0,
                            color: Colors.amber,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          notif.title,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          notif.description,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
                .animate(key: ValueKey(notif.id))
                .fadeIn(duration: 400.ms)
                .slideX(begin: 1, end: 0, duration: 400.ms, curve: Curves.easeOutBack)
                .then(delay: 2500.ms)
                .fadeOut(duration: 400.ms)
                .slideX(begin: 0, end: 1.2, duration: 400.ms, curve: Curves.easeIn);
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = AppTheme.isMobile(context);
    final contentWidth =
        MediaQuery.sizeOf(context).width > 1200 ? 1100.0 : MediaQuery.sizeOf(context).width * 0.9;

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(gradient: AppTheme.heroGradient),
          ),
          // Dot grid background
          Positioned.fill(
            child: DotGridBackground(scrollController: _scrollController),
          ),
          // Glowing bottom background wave
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 350,
            child: IgnorePointer(
              child: CustomPaint(
                painter: _GlowingWavePainter(
                  AppTheme.primary.withValues(alpha: 0.25),
                  AppTheme.violet.withValues(alpha: 0.15),
                ),
              ),
            ),
          ),
          // Main content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Sticky nav bar
              SliverPersistentHeader(
                pinned: true,
                delegate: _NavBarDelegate(
                  activeSectionNotifier: _activeSectionNotifier,
                  onSectionTap: _scrollToSection,
                  name: widget.data.name,
                ),
              ),
              // Sections
              SliverToBoxAdapter(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: contentWidth),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 16 : 0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Hero
                          Container(
                            key: _sectionKeys[0],
                            child: RepaintBoundary(
                              child: HeroSection(
                                data: widget.data,
                                onMailTap: _launchMail,
                                onPhoneTap: _launchPhone,
                                onLinkTap: _launchLink,
                                onScrollDown: () => _scrollToSection(1),
                              ),
                            ),
                          ),
                          // About
                          Container(
                            key: _sectionKeys[1],
                            child: RepaintBoundary(child: AboutSection(data: widget.data)),
                          ),
                          // Experience
                          Container(
                            key: _sectionKeys[2],
                            child: RepaintBoundary(child: ExperienceSection(data: widget.data)),
                          ),
                          // Projects
                          Container(
                            key: _sectionKeys[3],
                            child: RepaintBoundary(
                              child: ProjectsSection(
                                data: widget.data,
                                onOpenLink: _launchLink,
                                onAchievementUnlocked: _unlockAchievement,
                              ),
                            ),
                          ),
                          // Practise Gallery
                          Container(
                            key: _sectionKeys[4],
                            child: RepaintBoundary(child: PractiseSection(data: widget.data)),
                          ),
                          // Skills
                          Container(
                            key: _sectionKeys[5],
                            child: RepaintBoundary(child: SkillsSection(data: widget.data)),
                          ),
                          // Education (no own key — part of skills group)
                          RepaintBoundary(child: EducationSection(data: widget.data)),
                          // Contact
                          Container(
                            key: _sectionKeys[6],
                            child: RepaintBoundary(
                              child: ContactSection(
                                data: widget.data,
                                onMailTap: _launchMail,
                                onPhoneTap: _launchPhone,
                                onLinkTap: _launchLink,
                                onScrollToTop: _scrollToTop,
                                onContactClicked: () => _unlockAchievement('initiator'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Quest/Achievement features disabled per user request
        ],
      ),
    );
  }
}

// ── Sticky Nav Bar Delegate ──────────────────────────────────────────────────

class _NavBarDelegate extends SliverPersistentHeaderDelegate {
  _NavBarDelegate({
    required this.activeSectionNotifier,
    required this.onSectionTap,
    required this.name,
  });

  final ValueNotifier<int> activeSectionNotifier;
  final ValueChanged<int> onSectionTap;
  final String name;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ValueListenableBuilder<int>(
      valueListenable: activeSectionNotifier,
      builder: (context, activeSection, child) {
        return NavBar(
          activeSection: activeSection,
          onSectionTap: onSectionTap,
          name: name,
        );
      },
    );
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(covariant _NavBarDelegate oldDelegate) {
    return activeSectionNotifier != oldDelegate.activeSectionNotifier;
  }
}

class AchievementNotification {
  final String id;
  final String title;
  final String description;
  final IconData icon;

  AchievementNotification({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });
}

class _GlowingWavePainter extends CustomPainter {
  final Color primary;
  final Color violet;

  _GlowingWavePainter(this.primary, this.violet);

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.5);
    
    // First curve
    path.quadraticBezierTo(
      size.width * 0.25, size.height * 0.1, 
      size.width * 0.5, size.height * 0.5
    );
    // Second curve
    path.quadraticBezierTo(
      size.width * 0.75, size.height * 0.9, 
      size.width, size.height * 0.4
    );
    
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    final paint = Paint()
      ..shader = LinearGradient(
        colors: [primary, violet],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 60);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
