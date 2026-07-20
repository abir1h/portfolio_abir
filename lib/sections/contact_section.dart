import 'package:flutter/material.dart';

import '../data/profile.dart';
import '../theme/app_theme.dart';
import '../widgets/scroll_fade_in.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({
    super.key,
    required this.data,
    required this.onMailTap,
    required this.onPhoneTap,
    required this.onLinkTap,
    required this.onScrollToTop,
    this.onContactClicked,
  });

  final PortfolioData data;
  final VoidCallback onMailTap;
  final VoidCallback onPhoneTap;
  final ValueChanged<String> onLinkTap;
  final VoidCallback onScrollToTop;
  final VoidCallback? onContactClicked;

  @override
  Widget build(BuildContext context) {
    final isMobile = AppTheme.isMobile(context);

    void onMail() {
      onContactClicked?.call();
      onMailTap();
    }
    void onPhone() {
      onContactClicked?.call();
      onPhoneTap();
    }
    void onLink(String url) {
      onContactClicked?.call();
      onLinkTap(url);
    }

    return ScrollFadeIn(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: isMobile ? 40 : 64),
        child: Column(
          children: [
            // Section number
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '06.',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppTheme.accent,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        letterSpacing: 1.0,
                      ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 40,
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Headline
            Text(
              'Let\'s Build\nSomething Together',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: isMobile ? 28 : 44,
                    height: 1.2,
                  ),
            ),
            const SizedBox(height: 16),
            // Subtitle
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Text(
                data.ctaLabel,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textMuted,
                      fontSize: isMobile ? 14 : 17,
                    ),
              ),
            ),
            const SizedBox(height: 36),
            // Primary CTA
            _ContactCTA(
              label: 'Say Hello',
              icon: Icons.mail_outline_rounded,
              onTap: onMail,
            ),
            SizedBox(height: isMobile ? 32 : 48),
            // Contact links row
            Wrap(
              spacing: 16,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                _ContactChip(
                  icon: Icons.mail_outline_rounded,
                  label: data.email,
                  onTap: onMail,
                ),
                _ContactChip(
                  icon: Icons.phone_outlined,
                  label: data.phone,
                  onTap: onPhone,
                ),
                if (data.linkedinUrl.isNotEmpty)
                  _ContactChip(
                    icon: Icons.business_center_outlined,
                    label: 'LinkedIn',
                    onTap: () => onLink(data.linkedinUrl),
                  ),
                if (data.githubUrl.isNotEmpty)
                  _ContactChip(
                    icon: Icons.code_rounded,
                    label: 'GitHub',
                    onTap: () => onLink(data.githubUrl),
                  ),
              ],
            ),
            SizedBox(height: isMobile ? 48 : 72),
            // Footer divider
            Container(
              width: double.infinity,
              height: 1,
              color: AppTheme.borderSubtle,
            ),
            const SizedBox(height: 24),
            // Footer row
            _buildFooter(context, isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context, bool isMobile) {
    return Column(
      children: [
        // Back to top
        GestureDetector(
          onTap: onScrollToTop,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.keyboard_arrow_up_rounded,
                  color: AppTheme.textMuted,
                  size: 18,
                ),
                const SizedBox(width: 6),
                Text(
                  'Back to Top',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textMuted,
                        letterSpacing: 1.0,
                      ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Copyright + built with
        Text(
          '© ${DateTime.now().year} ${data.name}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.textMuted,
                fontSize: 12,
              ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Built with ',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textMuted,
                    fontSize: 12,
                  ),
            ),
            Icon(
              Icons.favorite_rounded,
              color: AppTheme.accent.withValues(alpha: 0.7),
              size: 12,
            ),
            Text(
              ' & Flutter',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textMuted,
                    fontSize: 12,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _ContactCTA extends StatefulWidget {
  const _ContactCTA({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  State<_ContactCTA> createState() => _ContactCTAState();
}

class _ContactCTAState extends State<_ContactCTA> {
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
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(AppTheme.radiusSm),
            boxShadow: _hovered
                ? AppTheme.hoverGlow(AppTheme.primary)
                : AppTheme.cardShadow,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, color: AppTheme.textPrimary, size: 20),
              const SizedBox(width: 12),
              Text(
                widget.label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactChip extends StatefulWidget {
  const _ContactChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  State<_ContactChip> createState() => _ContactChipState();
}

class _ContactChipState extends State<_ContactChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: _hovered ? AppTheme.cardBgHover : AppTheme.cardBg,
            borderRadius: BorderRadius.circular(AppTheme.radiusSm),
            border: Border.all(
              color: _hovered ? AppTheme.borderHover : AppTheme.borderSubtle,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                color: _hovered ? AppTheme.accent : AppTheme.textMuted,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color:
                          _hovered ? AppTheme.textPrimary : AppTheme.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
