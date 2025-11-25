import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import 'data/profile.dart';
import 'theme/app_theme.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key, required this.data});

  final PortfolioData data;

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
    await _launchUri(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  Future<void> _launchMail(String email) async {
    await _launchUri(Uri(scheme: 'mailto', path: email));
  }

  Future<void> _launchPhone(String phone) async {
    await _launchUri(Uri(scheme: 'tel', path: phone));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.heroGradient),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 720;
            final contentWidth = constraints.maxWidth > 1200
                ? 1100.0
                : constraints.maxWidth * 0.9;

            final sections = [
              _buildHero(isMobile),
              _gap(isMobile),
              _buildSummary(isMobile),
              _gap(isMobile),
              _buildExperience(isMobile),
              _gap(isMobile),
              _buildProjects(isMobile),
              _gap(isMobile),
              _buildSkills(isMobile),
              _gap(isMobile),
              _buildEducation(isMobile),
              _gap(isMobile),
              _buildContact(isMobile),
            ];

            return Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: isMobile ? 24 : 48),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: contentWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: sections
                        .animate(interval: 80.ms)
                        .fadeIn(duration: const Duration(milliseconds: 500))
                        .slideY(begin: 0.08, end: 0)
                        .toList(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHero(bool isMobile) {
    final data = widget.data;
    final highlights = [
      _HeroHighlight(
        title: 'Products shipped',
        value: '25+',
        caption: 'from MVPs to nationwide releases',
      ),
      _HeroHighlight(
        title: 'Avg. crash-free',
        value: '99.3%',
        caption: 'monitored with CI + analytics',
      ),
      _HeroHighlight(
        title: 'Primary domains',
        value: 'EdTech & Mobility',
        caption: 'but adaptable to any domain',
      ),
    ];

    Widget rightColumn(double size) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _HeadshotCard(
            assetPath: data.headshotAsset,
            imageUrl: data.headshotUrl,
            size: size,
          ),
          const SizedBox(height: 22),
          _heroStats(isMobile),
        ],
      );
    }

    return Container(
      padding: EdgeInsets.all(isMobile ? 26 : 42),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        gradient: const LinearGradient(
          colors: [Color(0xFF1F1B45), Color(0xFF040B1A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.45),
            blurRadius: 60,
            offset: const Offset(0, 30),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Positioned(
                right: -80,
                top: -80,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.accent.withValues(alpha: 0.12),
                  ),
                ),
              ),
              Positioned(
                left: -60,
                bottom: -60,
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.primary.withValues(alpha: 0.08),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: isMobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _heroTitle(data, isMobile: true),
                          const SizedBox(height: 26),
                          Align(child: rightColumn(240)),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _heroTitle(data)),
                          const SizedBox(width: 36),
                          SizedBox(width: 320, child: rightColumn(320)),
                        ],
                      ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          _HeroHighlightRow(highlights: highlights, isMobile: isMobile),
        ],
      ),
    );
  }

  Widget _heroTitle(PortfolioData data, {bool isMobile = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppTheme.accent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Flutter · Mobile · Web',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                  fontSize: 13,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(data.title, style: Theme.of(context).textTheme.displayLarge),
        const SizedBox(height: 16),
        Text(data.summary, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton.icon(
              icon: const Icon(Icons.mail_outline),
              onPressed: () => _launchMail(data.email),
              label: Text(data.email),
            ),
            OutlinedButton.icon(
              icon: const Icon(Icons.near_me_outlined),
              onPressed: () => _launchLink(
                'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(data.location)}',
              ),
              label: Text(data.location),
            ),
          ],
        ),
      ],
    );
  }

  Widget _heroStats(bool isMobile) {
    final data = widget.data;
    final cards = [
      _statTile(
        heading: 'Experience',
        value: data.experienceLabel,
        description: 'Shipped across EdTech, fleet, and services.',
        icon: Icons.workspace_premium_outlined,
      ),
      _statTile(
        heading: 'Availability',
        value: data.ctaLabel,
        description: data.phone,
        icon: Icons.schedule_outlined,
      ),
      _statTile(
        heading: 'Focus',
        value: 'Mobile & Web',
        description: 'Performance-tuned Flutter builds.',
        icon: Icons.auto_graph_outlined,
      ),
    ];

    final double cardWidth = isMobile
        ? MediaQuery.sizeOf(context).width * 0.9
        : 240;
    return Wrap(
      spacing: 14,
      runSpacing: 14,
      children: cards
          .map((card) => SizedBox(width: cardWidth, child: card))
          .toList(),
    );
  }

  Widget _statTile({
    required String heading,
    required String value,
    required String description,
    IconData? icon,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.white70, size: 22),
            const SizedBox(height: 12),
          ],
          Text(
            heading,
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 6),
          Text(value, style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 6),
          Text(
            description,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildSummary(bool isMobile) {
    return _SectionShell(
      title: 'Product DNA',
      subtitle: 'Impact first, design-forward, measurable delivery.',
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: const [
          _SummaryPill(
            icon: Icons.speed,
            title: 'Fast & Reliable',
            description: 'Performance budgets baked into CI and monitoring.',
          ),
          _SummaryPill(
            icon: Icons.auto_awesome,
            title: 'Design Systems',
            description: 'Pixel-perfect handoffs with accessible components.',
          ),
          _SummaryPill(
            icon: Icons.shield_moon_outlined,
            title: 'Quality Driven',
            description: 'Crash analytics and tooling keep releases stable.',
          ),
        ],
      ),
    );
  }

  Widget _buildExperience(bool isMobile) {
    final experiences = widget.data.experiences;
    return _SectionShell(
      title: 'Experience',
      subtitle: 'Crafting apps for education, fleet, and talent platforms.',
      child: Column(
        children: experiences
            .map(
              (exp) => Padding(
                padding: EdgeInsets.only(bottom: isMobile ? 16 : 20),
                child: _ExperienceCard(experience: exp),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildProjects(bool isMobile) {
    final projects = widget.data.projects;
    final crossAxisCount = isMobile ? 1 : 2;
    return _SectionShell(
      title: 'Selected Projects',
      subtitle: 'Product experiments and production launches.',
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: isMobile ? 1.1 : 1.5,
        ),
        itemCount: projects.length,
        itemBuilder: (context, index) =>
            _ProjectCard(project: projects[index], onOpen: _launchLink),
      ),
    );
  }

  Widget _buildSkills(bool isMobile) {
    return _SectionShell(
      title: 'Skills & Tools',
      subtitle: 'Modern Flutter stack with battle-tested patterns.',
      child: Column(
        children: widget.data.skills
            .map(
              (skill) => Padding(
                padding: EdgeInsets.only(bottom: isMobile ? 16 : 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      skill.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: skill.skills
                          .map((item) => Chip(label: Text(item)))
                          .toList(),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildEducation(bool isMobile) {
    return _SectionShell(
      title: 'Education',
      subtitle: 'Grounded in computer science fundamentals.',
      child: Column(
        children: widget.data.education
            .map(
              (edu) => Padding(
                padding: EdgeInsets.only(bottom: isMobile ? 12 : 16),
                child: _EducationTile(education: edu),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildContact(bool isMobile) {
    final data = widget.data;
    return _SectionShell(
      title: 'Let’s Talk',
      subtitle: 'Available for full-time roles and impactful collaborations.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.ctaLabel,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _ContactButton(
                icon: Icons.mail_outline,
                label: data.email,
                onPressed: () => _launchMail(data.email),
              ),
              _ContactButton(
                icon: Icons.phone_outlined,
                label: data.phone,
                onPressed: () => _launchPhone(data.phone),
              ),
              _ContactButton(
                icon: Icons.link_outlined,
                label: 'linkedin.com/in/abir-rahman-3a7050145/',
                onPressed: () => _launchLink(
                  'https://www.linkedin.com/in/abir-rahman-3a7050145/',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _gap(bool isMobile) => SizedBox(height: isMobile ? 24 : 36);
}

class _HeadshotCard extends StatelessWidget {
  const _HeadshotCard({
    required this.assetPath,
    required this.size,
    this.imageUrl,
  });

  final String assetPath;
  final String? imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    final image = imageUrl?.isNotEmpty == true
        ? Image.network(imageUrl!, fit: BoxFit.cover)
        : Image.asset(
            assetPath,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => _HeadshotFallback(size: size),
          );

    return Animate(
      effects: [
        FadeEffect(duration: 500.ms),
        ScaleEffect(
          begin: const Offset(0.94, 0.94),
          end: const Offset(1, 1),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutBack,
        ),
        ShimmerEffect(
          duration: const Duration(milliseconds: 2400),
          delay: 400.ms,
          angle: 0.3,
        ),
      ],
      child: Container(
        width: double.infinity,
        height: size,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size * 0.2),
          gradient: const LinearGradient(
            colors: [Color(0xFF2563EB), Color(0xFF0F172A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size * 0.18),
          child: image,
        ),
      ),
    );
  }
}

class _HeadshotFallback extends StatelessWidget {
  const _HeadshotFallback({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0F172A),
      child: Center(
        child: Text(
          'AR',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _SectionShell extends StatelessWidget {
  const _SectionShell({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.sizeOf(context).width < 720 ? 20 : 28),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}

class _SummaryPill extends StatelessWidget {
  const _SummaryPill({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(height: 14),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  const _ExperienceCard({required this.experience});

  final Experience experience;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  experience.role,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                experience.period,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.white70),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${experience.company} • ${experience.location}',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: experience.points
                .map(
                  (point) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '• ',
                          style: TextStyle(color: Colors.white70),
                        ),
                        Expanded(
                          child: Text(
                            point,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.white70),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({required this.project, this.onOpen});

  final Project project;
  final ValueChanged<String>? onOpen;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovering = false;

  void _setHover(bool value) {
    if (_hovering == value) return;
    setState(() => _hovering = value);
  }

  @override
  Widget build(BuildContext context) {
    final hasLink = widget.project.link.isNotEmpty;
    return MouseRegion(
      onEnter: (_) => _setHover(true),
      onExit: (_) => _setHover(false),
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
        tween: Tween<double>(begin: 0, end: _hovering ? -6 : 0),
        builder: (context, value, child) =>
            Transform.translate(offset: Offset(0, value), child: child),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          padding: const EdgeInsets.all(1.5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            gradient: _hovering
                ? const LinearGradient(
                    colors: [Color(0xFF38BDF8), Color(0xFF2563EB)],
                  )
                : null,
          ),
          child: Material(
            color: Colors.white.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(24),
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: hasLink
                  ? () => widget.onOpen?.call(widget.project.link)
                  : null,
              splashColor: Colors.white.withValues(alpha: 0.1),
              highlightColor: Colors.white.withValues(alpha: 0.05),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.project.name,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        if (hasLink)
                          IconButton(
                            icon: const Icon(
                              Icons.open_in_new,
                              color: Colors.white70,
                            ),
                            onPressed: () =>
                                widget.onOpen?.call(widget.project.link),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.project.description,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                    ),
                    const Spacer(),
                    Wrap(
                      spacing: 8,
                      children: widget.project.tags
                          .map((tag) => Chip(label: Text(tag)))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EducationTile extends StatelessWidget {
  const _EducationTile({required this.education});

  final Education education;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  education.degree,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  education.institution,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                education.period,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.white70),
              ),
              Text(
                education.location,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.white54),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContactButton extends StatelessWidget {
  const _ContactButton({
    required this.icon,
    required this.label,
    this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: Icon(icon, color: Colors.white70),
      label: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: Colors.white),
      ),
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      ),
    );
  }
}

class _HeroHighlight {
  const _HeroHighlight({
    required this.title,
    required this.value,
    required this.caption,
  });

  final String title;
  final String value;
  final String caption;
}

class _HeroHighlightRow extends StatelessWidget {
  const _HeroHighlightRow({required this.highlights, required this.isMobile});

  final List<_HeroHighlight> highlights;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 18,
      runSpacing: 18,
      alignment: WrapAlignment.spaceBetween,
      children: highlights
          .map(
            (item) => AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              width: isMobile ? double.infinity : 220,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.value,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.caption,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.white60),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
