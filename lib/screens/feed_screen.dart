import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../theme/app_colors.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/feed_header.dart';
import '../widgets/post_card.dart';

/// Home feed screen.
///
/// - The header (title + stories) collapses on scroll, title stays pinned.
/// - The bottom bar hides while scrolling down and comes back when
///   scrolling up, reaching the top, or reaching the end.
/// - Tapping "Home" while on Home scrolls back to the top.
class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with SingleTickerProviderStateMixin {
  /// How many pixels of scrolling fully hide / show the bottom bar.
  static const _barTravel = 90.0;

  final _scrollKey = GlobalKey<NestedScrollViewState>();

  /// 1 = bottom bar visible, 0 = hidden.
  late final AnimationController _barController = AnimationController(
    vsync: this,
    value: 1,
    duration: const Duration(milliseconds: 250),
  );

  int _currentTab = 0;

  @override
  void dispose() {
    _barController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Bottom bar show / hide
  // ---------------------------------------------------------------------------

  void _showBar() => _barController.animateTo(1, curve: Curves.easeOutCubic);

  void _hideBar() => _barController.animateTo(0, curve: Curves.easeOutCubic);

  bool _onScroll(ScrollNotification notification) {
    final metrics = notification.metrics;
    // Ignore the horizontal story list.
    if (metrics.axis != Axis.vertical) return false;

    if (notification is ScrollUpdateNotification) {
      final atTop = metrics.extentBefore <= 0;
      // Only the inner post list has a real "end".
      final atBottom = notification.depth > 0 && metrics.extentAfter <= 0;

      if (atTop || atBottom) {
        if (_barController.value < 1 && !_barController.isAnimating) {
          _showBar();
        }
      } else {
        // Move the bar together with the finger.
        _barController.value -= (notification.scrollDelta ?? 0) / _barTravel;
      }
    } else if (notification is ScrollEndNotification) {
      // Snap fully open or closed when the finger is lifted.
      _barController.value >= 0.5 ? _showBar() : _hideBar();
    }
    return false;
  }

  // ---------------------------------------------------------------------------
  // Tabs
  // ---------------------------------------------------------------------------

  void _onTabTap(int index) {
    if (index == 0 && _currentTab == 0) _scrollToTop();
    setState(() => _currentTab = index);
  }

  void _scrollToTop() {
    final scrollState = _scrollKey.currentState;
    if (scrollState == null) return;

    const duration = Duration(milliseconds: 450);
    const curve = Curves.easeOutCubic;
    scrollState.innerController.animateTo(0, duration: duration, curve: curve);
    scrollState.outerController.animateTo(0, duration: duration, curve: curve);
    _showBar();
  }

  // ---------------------------------------------------------------------------
  // UI
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.page,
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: NotificationListener<ScrollNotification>(
          onNotification: _onScroll,
          child: NestedScrollView(
            key: _scrollKey,
            headerSliverBuilder: (context, _) => [
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                  context,
                ),
                sliver: const SliverPersistentHeader(
                  pinned: true,
                  delegate: FeedHeaderDelegate(),
                ),
              ),
            ],
            body: Builder(builder: _buildPostList),
          ),
        ),
      ),
      bottomNavigationBar: SlideTransition(
        // 1.3 instead of 1 so the compose button's glow hides too.
        position: Tween(
          begin: const Offset(0, 1.3),
          end: Offset.zero,
        ).animate(_barController),
        child: BottomNavBar(currentIndex: _currentTab, onTap: _onTabTap),
      ),
    );
  }

  Widget _buildPostList(BuildContext context) {
    return CustomScrollView(
      key: const PageStorageKey('feed'),
      slivers: [
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverPadding(
          // Bottom padding keeps the last post above the bottom bar.
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
          sliver: SliverList.separated(
            itemCount: posts.length,
            separatorBuilder: (_, _) => const SizedBox(height: 16),
            itemBuilder: (_, i) => PostCard(key: ValueKey(i), post: posts[i]),
          ),
        ),
      ],
    );
  }
}
