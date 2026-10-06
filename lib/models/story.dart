import 'package:flutter/material.dart';

/// One bubble in the story rail at the top of the feed.
class Story {
  const Story({
    required this.name,
    required this.avatarUrl,
    required this.ringColor,
    required this.badgeColor,
  });

  final String name;
  final String avatarUrl;
  final Color ringColor; // colored circle around the avatar
  final Color badgeColor; // small "+" badge in the corner
}
