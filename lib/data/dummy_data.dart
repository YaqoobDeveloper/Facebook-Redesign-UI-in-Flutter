import 'package:flutter/material.dart';

import '../models/post.dart';
import '../models/story.dart';

/// Sample data for the UI. Add, remove or edit items here.

const stories = [
  Story(
    name: 'james_doe',
    avatarUrl: 'https://i.pravatar.cc/150?img=12',
    ringColor: Color(0xFFF2994A),
    badgeColor: Color(0xFFE5484D),
  ),
  Story(
    name: 'Philips joe',
    avatarUrl: 'https://i.pravatar.cc/150?img=59',
    ringColor: Color(0xFF3FA34D),
    badgeColor: Color(0xFF3FA34D),
  ),
  Story(
    name: 'Jane Clark',
    avatarUrl: 'https://i.pravatar.cc/150?img=47',
    ringColor: Color(0xFF6C7BFF),
    badgeColor: Color(0xFF6C7BFF),
  ),
  Story(
    name: 'Matthew',
    avatarUrl: 'https://i.pravatar.cc/150?img=33',
    ringColor: Color(0xFFF2994A),
    badgeColor: Color(0xFFE5484D),
  ),
  Story(
    name: 'Sophia',
    avatarUrl: 'https://i.pravatar.cc/150?img=45',
    ringColor: Color(0xFFB45CFF),
    badgeColor: Color(0xFFB45CFF),
  ),
];

const _samplePosts = [
  Post(
    author: 'James Clinton',
    avatarUrl: 'https://i.pravatar.cc/150?img=68',
    time: '2h ago',
    text:
        'Designing with intention beats chasing trends. This is what '
        'I’ve learned so far',
    imageUrl: 'https://picsum.photos/id/1005/800/500',
    likes: 105,
    comments: 15,
    shares: 50,
  ),
  Post(
    author: 'James Clinton',
    avatarUrl: 'https://i.pravatar.cc/150?img=44',
    time: '2h ago',
    text:
        'Designing with intention beats chasing trends. This is what '
        'I’ve learned so far',
    likes: 105,
    comments: 15,
    shares: 50,
  ),
  Post(
    author: 'Philips James',
    avatarUrl: 'https://i.pravatar.cc/150?img=53',
    time: '2h ago',
    text: 'Small habits, repeated daily, compound into big results.',
    imageUrl: 'https://picsum.photos/id/1011/800/500',
    likes: 87,
    comments: 9,
    shares: 21,
  ),
];

/// The sample posts repeated so the feed is long enough to scroll.
final posts = List.generate(15, (i) => _samplePosts[i % _samplePosts.length]);
