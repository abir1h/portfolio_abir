import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class NavBar extends StatefulWidget {
  const NavBar({
    super.key,
    required this.activeSection,
    required this.onSectionTap,
    required this.name,
  });

  final int activeSection;
  final ValueChanged<int> onSectionTap;
  final String name;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  static const _sections = [
    'Home',
    'About',
    'Experience',
    'Projects',
    'Skills',
    'Contact',
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = AppTheme.isDesktop(context);

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 32 : 16,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: AppTheme.surfaceDark.withValues(alpha: 0.8),
            border: Border(
              bottom: BorderSide(
                color: AppTheme.borderSubtle,
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              // Logo / Name
              GestureDetector(
                onTap: () => widget.onSectionTap(0),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text(
                    widget.name.split(' ').first,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontSize: isDesktop ? 22 : 18,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.accent,
                        ),
                  ),
                ),
              ),
              const Spacer(),
              // Nav links (desktop)
              if (isDesktop)
                Row(
                  children: _sections.asMap().entries.map((entry) {
                    final isActive = entry.key == widget.activeSection;
                    return _NavItem(
                      label: entry.value,
                      isActive: isActive,
                      onTap: () => widget.onSectionTap(entry.key),
                    );
                  }).toList(),
                ),
              // Hamburger (mobile/tablet)
              if (!isDesktop)
                IconButton(
                  icon: const Icon(
                    Icons.menu_rounded,
                    color: AppTheme.textPrimary,
                  ),
                  onPressed: () => _showMobileMenu(context),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppTheme.radiusLg),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.surfaceDark.withValues(alpha: 0.95),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppTheme.radiusLg),
                ),
                border: Border.all(color: AppTheme.borderSubtle),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Drag handle
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      color: AppTheme.borderHover,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  ..._sections.asMap().entries.map((entry) {
                    final isActive = entry.key == widget.activeSection;
                    return ListTile(
                      leading: Icon(
                        _sectionIcons[entry.key],
                        color: isActive ? AppTheme.accent : AppTheme.textMuted,
                        size: 20,
                      ),
                      title: Text(
                        entry.value,
                        style:
                            Theme.of(context).textTheme.titleSmall?.copyWith(
                                  color: isActive
                                      ? AppTheme.accent
                                      : AppTheme.textSecondary,
                                  fontWeight: isActive
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        widget.onSectionTap(entry.key);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hoverColor: AppTheme.cardBgHover,
                    );
                  }),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static const _sectionIcons = [
    Icons.home_rounded,
    Icons.person_outline_rounded,
    Icons.work_outline_rounded,
    Icons.folder_open_rounded,
    Icons.code_rounded,
    Icons.mail_outline_rounded,
  ];
}

class _NavItem extends StatefulWidget {
  const _NavItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(left: 4),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: widget.isActive
                ? AppTheme.accent.withValues(alpha: 0.1)
                : (_hovered ? AppTheme.cardBg : Colors.transparent),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: widget.isActive
                      ? AppTheme.accent
                      : (_hovered
                          ? AppTheme.textPrimary
                          : AppTheme.textMuted),
                  fontWeight:
                      widget.isActive ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 14,
                  letterSpacing: 0.3,
                ),
          ),
        ),
      ),
    );
  }
}
