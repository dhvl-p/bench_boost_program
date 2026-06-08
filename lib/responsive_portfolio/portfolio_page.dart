import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bench_boost_program/responsive_portfolio/portfolio_colors.dart';
import 'package:bench_boost_program/responsive_portfolio/portfolio_theme.dart';
import 'package:bench_boost_program/responsive_portfolio/portfolio_navbar.dart';
import 'package:bench_boost_program/responsive_portfolio/portfolio_strings.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Breakpoints
// ─────────────────────────────────────────────────────────────────────────────
class DeviceSize {
  static const double mobile = 600;
  static const double tablet = 900;
}

// ─────────────────────────────────────────────────────────────────────────────
// Entry Widget
// ─────────────────────────────────────────────────────────────────────────────
class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  bool _isDark = true;
  bool _drawerOpen = false;
  final ScrollController _scrollCtrl = ScrollController();

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PortfolioTheme.of(_isDark);

    return Theme(
      data: theme,
      child: Scaffold(
        backgroundColor: _isDark ? PortfolioColors.bgDark : PortfolioColors.bgLight,
        // Mobile drawer
        drawer: _drawerOpen ? null : null,
        body: LayoutBuilder(
          builder: (ctx, constraints) {
            final w = constraints.maxWidth;
            final isMobile = w < DeviceSize.mobile;
            final isTablet = w >= DeviceSize.mobile && w < DeviceSize.tablet;
            final isDesktop = w >= DeviceSize.tablet;

            return Stack(
              children: [
                // ── Scrollable content
                CustomScrollView(
                  controller: _scrollCtrl,
                  slivers: [
                    // ── Sticky Nav Bar
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: NavBarDelegate(
                        isMobile: isMobile,
                        isDark: _isDark,
                        onToggleDark: () => setState(() => _isDark = !_isDark),
                        onOpenDrawer: () => setState(() => _drawerOpen = true),
                      ),
                    ),

                    // ── Hero Section
                    SliverToBoxAdapter(
                      child: _HeroSection(
                        isMobile: isMobile,
                        isTablet: isTablet,
                        isDesktop: isDesktop,
                        isDark: _isDark,
                      ),
                    ),

                    // ── About Section
                    SliverToBoxAdapter(
                      child: _AboutSection(
                        isMobile: isMobile,
                        isDesktop: isDesktop,
                        isDark: _isDark,
                      ),
                    ),

                    // ── Skills Section
                    SliverToBoxAdapter(
                      child: _SkillsSection(
                        isMobile: isMobile,
                        isDark: _isDark,
                      ),
                    ),

                    // ── Projects Section
                    SliverToBoxAdapter(
                      child: _ProjectsSection(
                        isMobile: isMobile,
                        isDark: _isDark,
                      ),
                    ),

                    // ── Footer
                    SliverToBoxAdapter(
                      child: _Footer(isDark: _isDark),
                    ),
                  ],
                ),

                // ── Mobile Drawer Overlay
                if (_drawerOpen)
                  MobileNavDrawer(
                    isDark: _isDark,
                    onClose: () => setState(() => _drawerOpen = false),
                    onToggleDark: () => setState(() => _isDark = !_isDark),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

}



// ─────────────────────────────────────────────────────────────────────────────
// HERO SECTION
// ─────────────────────────────────────────────────────────────────────────────
class _HeroSection extends StatelessWidget {
  final bool isMobile;
  final bool isTablet;
  final bool isDesktop;
  final bool isDark;

  const _HeroSection({
    required this.isMobile,
    required this.isTablet,
    required this.isDesktop,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final hPad = isMobile ? 24.0 : isTablet ? 48.0 : 80.0;
        final vPad = isMobile ? 48.0 : 80.0;
        final imgSize = isMobile ? 200.0 : isTablet ? 260.0 : 340.0;

        final textBlock = _HeroTextBlock(isMobile: isMobile, isDark: isDark);
        final imageBlock = _HeroImage(size: imgSize, isDark: isDark);

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
          child: isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    imageBlock,
                    const SizedBox(height: 40),
                    textBlock,
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 5, child: textBlock),
                    const SizedBox(width: 40),
                    imageBlock,
                  ],
                ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// HERO TEXT BLOCK
// ─────────────────────────────────────────────────────────────────────────────
class _HeroTextBlock extends StatelessWidget {
  final bool isMobile;
  final bool isDark;
  const _HeroTextBlock({required this.isMobile, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final fg = isDark ? Colors.white : Colors.black87;
    final fgSub = PortfolioColors.textSecondary(isDark);
    final headSize = isMobile ? 32.0 : 42.0;

    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Greeting
        Text(
          PortfolioStrings.heroGreeting.tr,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            color: fg,
            fontSize: headSize,
            fontWeight: FontWeight.w800,
            height: 1.2,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 16),

        // Description
        Text(
          PortfolioStrings.heroBio.tr,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            color: fgSub,
            fontSize: 14,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 24),

        // Location chip
        _InfoChip(
          icon: Icons.location_on_outlined,
          label: PortfolioStrings.heroLocation.tr,
          isDark: isDark,
        ),
        const SizedBox(height: 10),

        // Available chip
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 2),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: PortfolioColors.available,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: PortfolioColors.available.withValues(alpha: 0.5), blurRadius: 6)],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              PortfolioStrings.heroAvailable.tr,
              style: TextStyle(color: fgSub, fontSize: 13),
            ),
          ],
        ),
        const SizedBox(height: 32),

        // CTA Button
        _ConnectButton(isDark: isDark),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// INFO CHIP
// ─────────────────────────────────────────────────────────────────────────────
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDark;
  const _InfoChip({required this.icon, required this.label, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final fg = PortfolioColors.textSecondary(isDark);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: fg, size: 16),
        const SizedBox(width: 6),
        Text(label, style: TextStyle(color: fg, fontSize: 13)),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CONNECT BUTTON (LinkedIn style)
// ─────────────────────────────────────────────────────────────────────────────
class _ConnectButton extends StatefulWidget {
  final bool isDark;
  const _ConnectButton({required this.isDark});

  @override
  State<_ConnectButton> createState() => _ConnectButtonState();
}

class _ConnectButtonState extends State<_ConnectButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: _hovered ? PortfolioColors.accent : (widget.isDark ? const Color(0xFF1E1E1E) : Colors.black12),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _hovered ? PortfolioColors.accent : (widget.isDark ? Colors.white24 : Colors.black26),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.link_rounded,
                    size: 16,
                    color: _hovered ? Colors.black : (widget.isDark ? Colors.white : Colors.black87),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    PortfolioStrings.heroConnectMe.tr,
                    style: TextStyle(
                      color: _hovered ? Colors.black : (widget.isDark ? Colors.white : Colors.black87),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
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

// ─────────────────────────────────────────────────────────────────────────────
// HERO CIRCULAR IMAGE
// ─────────────────────────────────────────────────────────────────────────────
class _HeroImage extends StatelessWidget {
  final double size;
  final bool isDark;
  const _HeroImage({required this.size, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.white.withValues(alpha: 0.06)
                : Colors.black.withValues(alpha: 0.1),
            blurRadius: 40,
            spreadRadius: 8,
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/profile_photo.png',
          fit: BoxFit.cover,
          errorBuilder: (ctx, err, st) => Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFF333333), Color(0xFF1A1A1A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Icon(Icons.person_rounded, size: 80, color: Colors.white38),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ABOUT SECTION
// ─────────────────────────────────────────────────────────────────────────────
class _AboutSection extends StatelessWidget {
  final bool isMobile;
  final bool isDesktop;
  final bool isDark;
  const _AboutSection({required this.isMobile, required this.isDesktop, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final bg = PortfolioColors.bgSection(isDark);
    final fg = isDark ? Colors.white : Colors.black87;
    final fgSub = PortfolioColors.textSecondary(isDark);
    final hPad = isMobile ? 24.0 : isDesktop ? 80.0 : 48.0;

    return Container(
      color: bg,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 72),
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          final sectionLabel = Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isDark ? Colors.white12 : Colors.black12),
              ),
              child: Text(
                PortfolioStrings.aboutLabel.tr,
                style: TextStyle(color: fgSub, fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          );

          final titleBlock = Column(
            crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              sectionLabel,
              const SizedBox(height: 32),
              Text(
                PortfolioStrings.aboutHeading.tr,
                textAlign: isMobile ? TextAlign.center : TextAlign.start,
                style: TextStyle(
                  color: fg,
                  fontSize: isMobile ? 22 : 28,
                  fontWeight: FontWeight.w800,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 24),
              _AboutBullet(
                emoji: '📱',
                title: PortfolioStrings.aboutBullet1Title.tr,
                body: PortfolioStrings.aboutBullet1Body.tr,
                isDark: isDark,
              ),
              const SizedBox(height: 20),
              _AboutBullet(
                emoji: '🎓',
                title: PortfolioStrings.aboutBullet2Title.tr,
                body: PortfolioStrings.aboutBullet2Body.tr,
                isDark: isDark,
              ),
            ],
          );

          final photoBlock = Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/profile_photo.png',
                height: isMobile ? 220 : 320,
                width: isMobile ? double.infinity : 260,
                fit: BoxFit.cover,
                errorBuilder: (ctx, err, st) => Container(
                  height: isMobile ? 220 : 320,
                  width: isMobile ? double.infinity : 260,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1A1A1A) : Colors.grey[300],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Icon(Icons.image_rounded, size: 48, color: Colors.white38),
                  ),
                ),
              ),
            ),
          );

          if (isMobile) {
            return Column(
              children: [
                photoBlock,
                const SizedBox(height: 40),
                titleBlock,
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              photoBlock,
              const SizedBox(width: 56),
              Expanded(child: titleBlock),
            ],
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ABOUT BULLET POINT
// ─────────────────────────────────────────────────────────────────────────────
class _AboutBullet extends StatelessWidget {
  final String emoji;
  final String title;
  final String body;
  final bool isDark;
  const _AboutBullet({
    required this.emoji,
    required this.title,
    required this.body,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final fg = isDark ? Colors.white : Colors.black87;
    final fgSub = PortfolioColors.textSecondary(isDark);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: fg,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          body,
          style: TextStyle(
            color: fgSub,
            fontSize: 13.5,
            height: 1.65,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SKILLS SECTION
// ─────────────────────────────────────────────────────────────────────────────
class _SkillsSection extends StatelessWidget {
  final bool isMobile;
  final bool isDark;
  const _SkillsSection({required this.isMobile, required this.isDark});

  static const _skills = [
    ('Flutter', 0.92, '📱'),
    ('Dart', 0.90, '🎯'),
    ('Android', 0.85, '🤖'),
    ('GetX', 0.88, '⚡'),
    ('MobX', 0.80, '🔄'),
    ('GraphQL', 0.75, '🔗'),
    ('Firebase', 0.82, '🔥'),
    ('REST APIs', 0.90, '🌐'),
  ];

  @override
  Widget build(BuildContext context) {
    final fg = isDark ? Colors.white : Colors.black87;
    final fgSub = PortfolioColors.textSecondary(isDark);
    final hPad = isMobile ? 24.0 : 80.0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 72),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _SectionLabel(label: PortfolioStrings.skillsLabel.tr, isDark: isDark),
          const SizedBox(height: 16),
          Text(
            PortfolioStrings.skillsHeading.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: fg,
              fontSize: isMobile ? 22 : 30,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            PortfolioStrings.skillsSubheading.tr,
            textAlign: TextAlign.center,
            style: TextStyle(color: fgSub, fontSize: 14),
          ),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (ctx, constraints) {
              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: _skills.map((s) {
                  final itemWidth = isMobile
                      ? constraints.maxWidth
                      : (constraints.maxWidth - 16) / 2;
                  return SizedBox(
                    width: itemWidth,
                    child: _SkillBar(
                      name: s.$1,
                      progress: s.$2,
                      emoji: s.$3,
                      isDark: isDark,
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SKILL BAR
// ─────────────────────────────────────────────────────────────────────────────
class _SkillBar extends StatefulWidget {
  final String name;
  final double progress;
  final String emoji;
  final bool isDark;
  const _SkillBar({
    required this.name,
    required this.progress,
    required this.emoji,
    required this.isDark,
  });

  @override
  State<_SkillBar> createState() => _SkillBarState();
}

class _SkillBarState extends State<_SkillBar> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _anim = Tween<double>(begin: 0, end: widget.progress).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic),
    );
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final trackColor = widget.isDark ? const Color(0xFF1E1E1E) : Colors.black12;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PortfolioColors.bgCard(widget.isDark),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.isDark ? PortfolioColors.dividerDark : Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(widget.emoji, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  widget.name,
                  style: TextStyle(
                    color: widget.isDark ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
              AnimatedBuilder(
                animation: _anim,
                builder: (ctx, w) => Text(
                  '${(_anim.value * 100).round()}%',
                  style: TextStyle(
                    color: PortfolioColors.accent,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: AnimatedBuilder(
              animation: _anim,
              builder: (ctx2, w2) => LinearProgressIndicator(
                value: _anim.value,
                minHeight: 6,
                backgroundColor: trackColor,
                valueColor: const AlwaysStoppedAnimation<Color>(PortfolioColors.accent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PROJECTS SECTION
// ─────────────────────────────────────────────────────────────────────────────
class _ProjectsSection extends StatelessWidget {
  final bool isMobile;
  final bool isDark;
  const _ProjectsSection({required this.isMobile, required this.isDark});

  static List<(String, String, String, List<String>)> _buildProjects() => [
    (
      '📦',
      PortfolioStrings.project1Title.tr,
      PortfolioStrings.project1Desc.tr,
      ['Flutter', 'GetX', 'MobX', 'GraphQL'],
    ),
    (
      '💬',
      PortfolioStrings.project2Title.tr,
      PortfolioStrings.project2Desc.tr,
      ['Flutter', 'WebSocket', 'GetX'],
    ),
    (
      '🛒',
      PortfolioStrings.project3Title.tr,
      PortfolioStrings.project3Desc.tr,
      ['Flutter', 'State Management'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final fg = isDark ? Colors.white : Colors.black87;
    final fgSub = PortfolioColors.textSecondary(isDark);
    final bg = PortfolioColors.bgSection(isDark);
    final hPad = isMobile ? 24.0 : 80.0;

    return Container(
      color: bg,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 72),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _SectionLabel(label: PortfolioStrings.projectsLabel.tr, isDark: isDark),
          const SizedBox(height: 16),
          Text(
            PortfolioStrings.projectsHeading.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: fg,
              fontSize: isMobile ? 22 : 30,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            PortfolioStrings.projectsSubheading.tr,
            textAlign: TextAlign.center,
            style: TextStyle(color: fgSub, fontSize: 14),
          ),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (ctx, constraints) {
              final crossCount = isMobile ? 1 : constraints.maxWidth > 800 ? 3 : 2;
              final itemWidth = (constraints.maxWidth - (crossCount - 1) * 20) / crossCount;

              return Wrap(
                spacing: 20,
                runSpacing: 20,
                children: _buildProjects().map((p) {
                  return SizedBox(
                    width: itemWidth,
                    child: _ProjectCard(
                      emoji: p.$1,
                      title: p.$2,
                      desc: p.$3,
                      tags: List<String>.from(p.$4),
                      isDark: isDark,
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PROJECT CARD
// ─────────────────────────────────────────────────────────────────────────────
class _ProjectCard extends StatefulWidget {
  final String emoji;
  final String title;
  final String desc;
  final List<String> tags;
  final bool isDark;
  const _ProjectCard({
    required this.emoji,
    required this.title,
    required this.desc,
    required this.tags,
    required this.isDark,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final fg = widget.isDark ? Colors.white : Colors.black87;
    final fgSub = PortfolioColors.textSecondary(widget.isDark);
    final bg = PortfolioColors.bgCard(widget.isDark);
    final borderColor = _hovered ? PortfolioColors.accent : PortfolioColors.divider(widget.isDark);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: PortfolioColors.accent.withValues(alpha: 0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 16),
            Text(
              widget.title,
              style: TextStyle(
                color: fg,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.desc,
              style: TextStyle(color: fgSub, fontSize: 13, height: 1.6),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: widget.tags.map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: PortfolioColors.accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: PortfolioColors.accent.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(
                      color: PortfolioColors.accent,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
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

// ─────────────────────────────────────────────────────────────────────────────
// SECTION LABEL PILL
// ─────────────────────────────────────────────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  final String label;
  final bool isDark;
  const _SectionLabel({required this.label, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isDark ? Colors.white12 : Colors.black12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: PortfolioColors.textSecondary(isDark),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// FOOTER
// ─────────────────────────────────────────────────────────────────────────────
class _Footer extends StatelessWidget {
  final bool isDark;
  const _Footer({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final fg = PortfolioColors.textSecondary(isDark);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: PortfolioColors.divider(isDark)),
        ),
      ),
      child: Center(
        child: Text(
          PortfolioStrings.footerText.tr,
          style: TextStyle(color: fg, fontSize: 13),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
