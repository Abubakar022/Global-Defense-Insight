import 'package:intl/intl.dart'; // Make sure this import is at the top

class PostModel {
  final int? id;
  final String? date;
  final String? title;
  final String? content;
  final String? excerpt;
  final String? imageUrl;
  final List<int> categories;

  PostModel({
    this.id,
    this.date,
    this.title,
    this.content,
    this.excerpt,
    this.imageUrl,
    List<int>? categories,
  }) : categories = categories ?? [];

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      date: json['date'],
      title: _parseHtmlString(json['title']?['rendered']),
      content: _parseHtmlString(json['content']?['rendered']),
      excerpt: _parseHtmlString(json['excerpt']?['rendered']),
      imageUrl: json['jetpack_featured_media_url'],
      categories: _parseCategories(json['categories']),
    );
  }

  static String? _parseHtmlString(dynamic value) {
    if (value == null) return null;
    return value.toString().replaceAll(RegExp(r'<[^>]*>'), '').trim();
  }

  static List<int> _parseCategories(dynamic jsonCategories) {
    if (jsonCategories is! List) return [];
    return jsonCategories.whereType<int>().toList();
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'title': {'rendered': title},
        'content': {'rendered': content},
        'excerpt': {'rendered': excerpt},
        'jetpack_featured_media_url': imageUrl,
        'categories': categories,
      };

  // ✅ NEW: Formatted Date Getter (Safe, Clean)
  String get formattedDate {
    if (date == null) return '';
    try {
      final parsedDate = DateTime.parse(date!);
      return DateFormat('dd MMMM yyyy').format(parsedDate); // eg: 31 July 2025
    } catch (e) {
      return date!; // fallback
    }
  }
}
