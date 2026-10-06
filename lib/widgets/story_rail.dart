import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../theme/app_colors.dart';
import 'avatar.dart';

/// Horizontal list of stories: "Your story" first, then everyone else.
class StoryRail extends StatelessWidget {
  const StoryRail({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      key: const PageStorageKey('stories'),
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: stories.length + 1,
      separatorBuilder: (_, _) => const SizedBox(width: 14),
      itemBuilder: (_, i) {
        if (i == 0) return const YourStory();
        final story = stories[i - 1];
        return StoryBubble(
          label: story.name,
          ring: LinearGradient(colors: [story.ringColor, story.ringColor]),
          badgeColor: story.badgeColor,
          child: Avatar(url: story.avatarUrl, size: 64),
        );
      },
    );
  }
}

/// The first bubble, used to add your own story.
class YourStory extends StatelessWidget {
  const YourStory({super.key});

  static const _rainbow = SweepGradient(
    colors: [
      Color(0xFFF2994A),
      Color(0xFFE5484D),
      Color(0xFFB45CFF),
      Color(0xFF2F7BFF),
      Color(0xFF3FD1C4),
      Color(0xFFF2994A),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return StoryBubble(
      label: 'Your story',
      ring: _rainbow,
      badgeColor: AppColors.placeholder,
      child: Container(
        width: 64,
        height: 64,
        decoration: const BoxDecoration(
          color: Color(0xFF0E1220),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 36),
      ),
    );
  }
}

/// A circle with a colored ring, a small "+" badge and a name underneath.
class StoryBubble extends StatelessWidget {
  const StoryBubble({
    super.key,
    required this.label,
    required this.ring,
    required this.badgeColor,
    required this.child,
  });

  final String label;
  final Gradient ring;
  final Color badgeColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 76,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              // Ring
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  gradient: ring,
                  shape: BoxShape.circle,
                ),
                // Gap between ring and avatar
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: AppColors.page,
                    shape: BoxShape.circle,
                  ),
                  child: child,
                ),
              ),
              // "+" badge
              Positioned(
                right: -1,
                bottom: 0,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: badgeColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: const Icon(Icons.add, size: 13, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: AppColors.body),
          ),
        ],
      ),
    );
  }
}
