/// One post in the feed. Leave [imageUrl] null for a text-only post.
class Post {
  const Post({
    required this.author,
    required this.avatarUrl,
    required this.time,
    required this.text,
    this.imageUrl,
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
  });

  final String author;
  final String avatarUrl;
  final String time;
  final String text;
  final String? imageUrl;
  final int likes;
  final int comments;
  final int shares;
}
