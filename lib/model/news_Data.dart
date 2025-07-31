class Post {
  final int id;
  final String title;
  final String content;
  final String date;
  final String? imageUrl;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    this.imageUrl,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title']['rendered'] ?? '',
      content: json['content']['rendered'] ?? '',
      date: json['date'] ?? '',
      imageUrl: json['_embedded']?['wp:featuredmedia']?[0]?['source_url'],
    );
  }
}
