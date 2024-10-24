class Post {
  final String name;
  final String image;
  final String content;
  final String time;
  final int likes;
  final int comments;
  final int shares;
  Post({
    required this.name,
    required this.image,
    required this.content,
    required this.time,
    required this.likes,
    required this.comments,
    required this.shares,
  });
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      name: json['name'] ?? "",
      image: json['image_url'] ?? "",
      content: json['caption_post'],
      time: json['created_at'],
      likes: json['likes'],
      comments: json['comments'],
      shares: json['shares'],
    );
  }
}
