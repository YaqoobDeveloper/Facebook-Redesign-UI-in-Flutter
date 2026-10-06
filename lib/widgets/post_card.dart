import 'package:flutter/material.dart';

import '../models/post.dart';
import '../theme/app_colors.dart';
import 'avatar.dart';

/// A single post: author row, text, optional image, and reaction buttons.
class PostCard extends StatefulWidget {
  const PostCard({super.key, required this.post});

  final Post post;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  /// Text longer than this is cut off with "... see more".
  static const _previewLength = 74;

  bool _liked = false;
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _AuthorRow(post: post),
          const SizedBox(height: 12),
          _buildText(post.text),
          if (post.imageUrl != null) ...[
            const SizedBox(height: 12),
            PostImage(url: post.imageUrl!),
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              ReactionButton(
                icon: Icons.favorite,
                color: AppColors.heart,
                count: post.likes + (_liked ? 1 : 0),
                onTap: () => setState(() => _liked = !_liked),
              ),
              const SizedBox(width: 14),
              ReactionButton(
                icon: Icons.chat_bubble,
                color: AppColors.blue,
                count: post.comments,
                onTap: () {},
              ),
              const SizedBox(width: 14),
              ReactionButton(
                icon: Icons.send,
                color: AppColors.blue,
                count: post.shares,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildText(String text) {
    final isLong = text.length > _previewLength;
    final showAll = _expanded || !isLong;

    return GestureDetector(
      onTap: isLong ? () => setState(() => _expanded = !_expanded) : null,
      child: Text.rich(
        TextSpan(
          text: showAll ? text : text.substring(0, _previewLength).trimRight(),
          children: [
            if (!showAll)
              const TextSpan(
                text: '... see more',
                style: TextStyle(color: AppColors.muted),
              ),
          ],
        ),
        style: const TextStyle(
          fontSize: 15,
          height: 1.55,
          color: AppColors.body,
        ),
      ),
    );
  }
}

/// Avatar, name, time and a "more" button.
class _AuthorRow extends StatelessWidget {
  const _AuthorRow({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Avatar(url: post.avatarUrl, size: 50),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.author,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.text,
                ),
              ),
              Text(
                post.time,
                style: const TextStyle(fontSize: 11, color: AppColors.muted),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_horiz),
          color: AppColors.muted,
          tooltip: 'More',
        ),
      ],
    );
  }
}

/// Rounded 16:9 image with a play button on top.
class PostImage extends StatelessWidget {
  const PostImage({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              url,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) =>
                  const ColoredBox(color: AppColors.placeholder),
            ),
            Center(
              child: Container(
                width: 58,
                height: 58,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  size: 40,
                  color: Color(0xFF2B2B2B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Small colored circle icon with a number next to it (likes, comments...).
class ReactionButton extends StatelessWidget {
  const ReactionButton({
    super.key,
    required this.icon,
    required this.color,
    required this.count,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        child: Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Icon(icon, size: 12, color: Colors.white),
            ),
            const SizedBox(width: 4),
            Text(
              '$count',
              style: const TextStyle(fontSize: 14, color: AppColors.muted),
            ),
          ],
        ),
      ),
    );
  }
}
