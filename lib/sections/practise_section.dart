import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../data/profile.dart';
import '../theme/app_theme.dart';
import '../widgets/scroll_fade_in.dart';
import '../widgets/section_heading.dart';

class PractiseSection extends StatelessWidget {
  const PractiseSection({
    super.key,
    required this.data,
  });

  final PortfolioData data;

  @override
  Widget build(BuildContext context) {
    final isMobile = AppTheme.isMobile(context);
    final isTablet = AppTheme.isTablet(context);
    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

    // Filter to show specific projects
    final allowedProjects = ['habit quest', 'netflix clone ui'];
    final practiceProjects = data.practiceProjects
        .where((p) => allowedProjects.contains(p.name.trim().toLowerCase()))
        .toList();

    return ScrollFadeIn(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: isMobile ? 40 : 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeading(
              number: '04.',
              title: 'Practise Project Gallery',
              subtitle: 'Sandbox builds, prototypes, and experimental mobile applications.',
            ),
            const SizedBox(height: 28),
            practiceProjects.length == 1
                ? Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400, maxHeight: 280),
                      child: _PracticeCard(
                        project: practiceProjects.first,
                        index: 0,
                      ),
                    ),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: isMobile ? 1.35 : (isTablet ? 1.15 : 1.1),
                    ),
                    itemCount: practiceProjects.length,
                    itemBuilder: (context, index) {
                      final project = practiceProjects[index];
                      return _PracticeCard(
                        project: project,
                        index: index,
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}

class _PracticeCard extends StatefulWidget {
  const _PracticeCard({
    required this.project,
    required this.index,
  });

  final PracticeProject project;
  final int index;

  @override
  State<_PracticeCard> createState() => _PracticeCardState();
}

class _PracticeCardState extends State<_PracticeCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = [AppTheme.accent, AppTheme.violet, AppTheme.emerald];
    final accentColor = colors[widget.index % colors.length];
    final hasVideo = widget.project.youtubeUrl.isNotEmpty;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => _PracticeProjectDetailDialog(project: widget.project),
          );
        },
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
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: accentColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          hasVideo ? Icons.play_circle_outline_rounded : Icons.science_outlined,
                          color: accentColor,
                          size: 22,
                        ),
                      ),
                      const Spacer(),
                      if (hasVideo)
                        Row(
                          children: [
                            const Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.redAccent,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'SHORTS DEMO',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: Colors.redAccent.withValues(alpha: 0.8),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.project.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: _hovered ? accentColor : AppTheme.textPrimary,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
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
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
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

class _PracticeProjectDetailDialog extends StatelessWidget {
  const _PracticeProjectDetailDialog({required this.project});

  final PracticeProject project;

  @override
  Widget build(BuildContext context) {
    final isDesktop = AppTheme.isDesktop(context);
    final videoId = _extractVideoId(project.youtubeUrl);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: isDesktop && videoId != null ? 820 : 450,
            maxHeight: isDesktop ? 620 : MediaQuery.sizeOf(context).height * 0.85,
          ),
          decoration: BoxDecoration(
            color: AppTheme.surfaceDark.withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(AppTheme.radiusXl),
            border: Border.all(color: AppTheme.borderSubtle),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.6),
                blurRadius: 40,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Close button
              Positioned(
                top: 16,
                right: 16,
                child: IconButton(
                  icon: const Icon(Icons.close_rounded, color: AppTheme.textMuted),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(32),
                child: isDesktop && videoId != null
                    ? Row(
                        children: [
                          // Left pane: Project details
                          Expanded(
                            flex: 12,
                            child: _buildDetailsPane(context, videoId),
                          ),
                          const SizedBox(width: 32),
                          // Right pane: Phone mockup
                          Expanded(
                            flex: 10,
                            child: Center(
                              child: _buildPhoneMockup(videoId),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _buildDetailsPane(context, videoId, showVideoHint: videoId != null),
                                  if (videoId != null) ...[
                                    const SizedBox(height: 24),
                                    Center(
                                      child: _buildPhoneMockup(videoId, height: 400),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsPane(BuildContext context, String? videoId, {bool showVideoHint = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppTheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.primary.withValues(alpha: 0.2)),
          ),
          child: Text(
            videoId != null ? 'PRACTISE & DEMO 📱' : 'PRACTISE PROJECT 🛠️',
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: AppTheme.accent,
              letterSpacing: 1.0,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          project.name,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: AppTheme.textPrimary,
              ),
        ),
        const SizedBox(height: 16),
        Text(
          project.description,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
                height: 1.6,
              ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Tech Stack & Concepts',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimary,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: project.tags.map((tag) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.cardBg,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppTheme.borderSubtle),
              ),
              child: Text(
                tag,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ),
        if (showVideoHint) ...[
          const SizedBox(height: 24),
          Row(
            children: [
              const Icon(
                Icons.play_circle_fill_rounded,
                color: Colors.red,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'Shorts Demo playing right side/below',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textMuted,
                      fontStyle: FontStyle.italic,
                    ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildPhoneMockup(String videoId, {double height = 480}) {
    final double phoneHeight = height;
    final double phoneWidth = height * 0.48; // longer modern smartphone ratio

    return Container(
      width: phoneWidth,
      height: phoneHeight,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: const Color(0xFF1E293B), width: 10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.6),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Video Player — fills the phone screen
            Positioned.fill(
              child: _ShortsVideoPlayer(videoId: videoId),
            ),
            
            // Top Cover (hides status bar area neatly)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 32,
              child: Container(
                color: Colors.black,
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        '12:00',
                        style: TextStyle(
                          fontSize: 8.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Row(
                      children: const [
                        Icon(Icons.signal_cellular_alt_rounded, color: Colors.white, size: 8.5),
                        SizedBox(width: 4),
                        Icon(Icons.wifi_rounded, color: Colors.white, size: 8.5),
                        SizedBox(width: 4),
                        Icon(Icons.battery_std_rounded, color: Colors.white, size: 8.5),
                        SizedBox(width: 16),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Cover — tall enough to hide channel name & "Shorts" text overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 24,
              child: Container(
                color: Colors.black,
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  width: 80,
                  height: 3.5,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),

            // Camera cutout notch
            Positioned(
              top: 5,
              child: Container(
                width: 55,
                height: 12,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _extractVideoId(String url) {
    if (url.isEmpty) return null;
    final uri = Uri.tryParse(url);
    if (uri == null) return null;
    if (uri.pathSegments.contains('shorts')) {
      final index = uri.pathSegments.indexOf('shorts');
      if (index >= 0 && index < uri.pathSegments.length - 1) {
        return uri.pathSegments[index + 1];
      }
    }
    if (uri.host.contains('youtube.com') || uri.host.contains('youtu.be')) {
      if (uri.queryParameters.containsKey('v')) {
        return uri.queryParameters['v'];
      }
      if (uri.pathSegments.isNotEmpty) {
        return uri.pathSegments.last;
      }
    }
    return null;
  }
}



class _ShortsVideoPlayer extends StatefulWidget {
  const _ShortsVideoPlayer({required this.videoId});

  final String videoId;

  @override
  State<_ShortsVideoPlayer> createState() => _ShortsVideoPlayerState();
}

class _ShortsVideoPlayerState extends State<_ShortsVideoPlayer> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        _controller = YoutubePlayerController.fromVideoId(
          videoId: widget.videoId,
          autoPlay: true,
          params: const YoutubePlayerParams(
            showControls: false,
            showFullscreenButton: false,
            mute: false,
            loop: true,
            showVideoAnnotations: false,
            strictRelatedVideos: true,
            enableCaption: false,
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = _controller;
    if (ctrl == null) {
      return const ColoredBox(color: Colors.black);
    }
    return YoutubePlayer(
      controller: ctrl,
      aspectRatio: 9 / 16,
    );
  }
}
