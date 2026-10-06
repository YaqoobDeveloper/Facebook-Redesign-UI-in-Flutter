import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'story_rail.dart';

/// Header at the top of the feed: the title bar plus the story rail.
/// When you scroll, the stories slide up and fade out, and only the
/// title bar stays pinned.
class FeedHeaderDelegate extends SliverPersistentHeaderDelegate {
  const FeedHeaderDelegate();

  static const titleHeight = 64.0;
  static const storiesHeight = 118.0;

  @override
  double get maxExtent => titleHeight + storiesHeight;

  @override
  double get minExtent => titleHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlaps) {
    // 0 = fully expanded, 1 = fully collapsed.
    final progress = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.page,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35 * progress),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const TitleBar(),
          Expanded(
            child: ClipRect(
              child: OverflowBox(
                alignment: Alignment.bottomCenter,
                minHeight: storiesHeight,
                maxHeight: storiesHeight,
                child: Opacity(
                  opacity: (1 - progress * 1.4).clamp(0.0, 1.0),
                  child: const StoryRail(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(FeedHeaderDelegate oldDelegate) => false;
}

/// Search button, app name and "+" button.
class TitleBar extends StatelessWidget {
  const TitleBar({super.key, this.title = 'Sphere'});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, size: 28),
            color: AppColors.text,
            tooltip: 'Search',
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: AppColors.text,
                letterSpacing: -0.5,
              ),
            ),
          ),
          Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(8),
              child: const SizedBox(
                width: 34,
                height: 34,
                child: Icon(Icons.add, color: AppColors.page, size: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
