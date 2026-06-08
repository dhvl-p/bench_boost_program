import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bench_boost_program/responsive_portfolio/portfolio_colors.dart';
import 'package:bench_boost_program/responsive_portfolio/portfolio_strings.dart';

// ─────────────────────────────────────────────────────────────────────────────
// NAV BAR DELEGATE  (Sticky SliverPersistentHeader)
// ─────────────────────────────────────────────────────────────────────────────

/// Sticky navigation bar rendered inside a [SliverPersistentHeader].
/// Switches between a desktop horizontal link-row and a mobile
/// hamburger+toggle strip, driven by [isMobile].
class NavBarDelegate extends SliverPersistentHeaderDelegate {
  final bool isMobile;
  final bool isDark;
  final VoidCallback onToggleDark;
  final VoidCallback onOpenDrawer;

  const NavBarDelegate({
    required this.isMobile,
    required this.isDark,
    required this.onToggleDark,
    required this.onOpenDrawer,
  });

  static const double _height = 64;

  @override
  double get minExtent => _height;
  @override
  double get maxExtent => _height;

  @override
  Widget build(BuildContext ctx, double shrinkOffset, bool overlapsContent) {
    final bg = isDark
        ? PortfolioColors.bgDark.withValues(alpha: 0.95)
        : Colors.white.withValues(alpha: 0.95);
    final fg = isDark ? Colors.white : Colors.black87;

    return Container(
      height: _height,
      decoration: BoxDecoration(
        color: bg,
        border: Border(
          bottom: BorderSide(
            color: PortfolioColors.divider(isDark),
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          // ── Brand handle
          NavBrandLabel(fg: fg),

          const Spacer(),

          if (isMobile) ...[
            NavDarkToggle(isDark: isDark, fg: fg, onTap: onToggleDark),
            const SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.menu_rounded, color: fg),
              onPressed: onOpenDrawer,
              tooltip: PortfolioStrings.navOpenMenu.tr,
            ),
          ] else ...[
            ..._buildNavLinks(fg),
            const SizedBox(width: 24),
            NavDarkToggle(isDark: isDark, fg: fg, onTap: onToggleDark),
          ],
        ],
      ),
    );
  }

  List<Widget> _buildNavLinks(Color fg) {
    final labels = [
      PortfolioStrings.navAbout.tr,
      PortfolioStrings.navServices.tr,
      PortfolioStrings.navSkills.tr,
      PortfolioStrings.navProjects.tr,
      PortfolioStrings.navContact.tr,
    ];
    return labels.map((label) => NavLink(label: label, fg: fg)).toList();
  }

  @override
  bool shouldRebuild(covariant NavBarDelegate old) =>
      old.isMobile != isMobile || old.isDark != isDark;
}

// ─────────────────────────────────────────────────────────────────────────────
// BRAND LABEL
// ─────────────────────────────────────────────────────────────────────────────

/// The "@handle" text shown on the left of the nav bar.
class NavBrandLabel extends StatelessWidget {
  final Color fg;
  const NavBrandLabel({super.key, required this.fg});

  @override
  Widget build(BuildContext context) {
    return Text(
      PortfolioStrings.brandHandle.tr,
      style: TextStyle(
        color: fg,
        fontWeight: FontWeight.bold,
        fontSize: 16,
        letterSpacing: 0.5,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// NAV LINK  (desktop, with hover underline animation)
// ─────────────────────────────────────────────────────────────────────────────

/// A single nav link with a gold animated underline on hover.
class NavLink extends StatefulWidget {
  final String label;
  final Color fg;
  const NavLink({super.key, required this.label, required this.fg});

  @override
  State<NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  color: _hovered ? PortfolioColors.accent : widget.fg,
                  fontSize: 14,
                  fontWeight: _hovered ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              const SizedBox(height: 2),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: _hovered ? 28 : 0,
                decoration: BoxDecoration(
                  color: PortfolioColors.accent,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// DARK MODE TOGGLE BUTTON
// ─────────────────────────────────────────────────────────────────────────────

/// Circular icon button that toggles between dark and light mode.
class NavDarkToggle extends StatelessWidget {
  final bool isDark;
  final Color fg;
  final VoidCallback onTap;

  const NavDarkToggle({
    super.key,
    required this.isDark,
    required this.fg,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDark ? const Color(0xFF222222) : Colors.black12,
        ),
        child: Icon(
          isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
          color: fg,
          size: 18,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// MOBILE DRAWER OVERLAY
// ─────────────────────────────────────────────────────────────────────────────

/// Full-screen overlay drawer that slides in from the right on mobile.
/// Tapping the scrim (outside the panel) calls [onClose].
class MobileNavDrawer extends StatelessWidget {
  final bool isDark;
  final VoidCallback onClose;
  final VoidCallback onToggleDark;

  const MobileNavDrawer({
    super.key,
    required this.isDark,
    required this.onClose,
    required this.onToggleDark,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isDark ? PortfolioColors.bgDark : Colors.white;
    final fg = isDark ? Colors.white : Colors.black87;

    return GestureDetector(
      onTap: onClose, // tap scrim → close
      child: Container(
        color: Colors.black54,
        child: Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () {}, // absorb taps inside the panel
            child: Container(
              width: 260,
              height: double.infinity,
              color: bg,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Header row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NavBrandLabel(fg: fg),
                      IconButton(
                        icon: Icon(Icons.close_rounded, color: fg),
                        onPressed: onClose,
                        tooltip: PortfolioStrings.navCloseMenu.tr,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // ── Nav links
                  ..._buildLinks(fg),

                  const SizedBox(height: 32),
                  Divider(color: PortfolioColors.divider(isDark)),
                  const SizedBox(height: 16),

                  // ── Dark mode row
                  Row(
                    children: [
                      Text(
                        PortfolioStrings.navDarkMode.tr,
                        style: TextStyle(color: fg, fontSize: 14),
                      ),
                      const Spacer(),
                      NavDarkToggle(isDark: isDark, fg: fg, onTap: onToggleDark),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildLinks(Color fg) {
    final labels = [
      PortfolioStrings.navAbout.tr,
      PortfolioStrings.navServices.tr,
      PortfolioStrings.navSkills.tr,
      PortfolioStrings.navProjects.tr,
      PortfolioStrings.navContact.tr,
    ];
    return labels
        .map(
          (label) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: GestureDetector(
              onTap: () {},
              child: Text(
                label,
                style: TextStyle(
                  color: fg,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        )
        .toList();
  }
}
