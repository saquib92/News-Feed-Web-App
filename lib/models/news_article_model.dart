import 'package:cloud_firestore/cloud_firestore.dart';

class NewsArticle {
  final String? id;
  final String? title;
  final String? content;
  final String? author;
  final DateTime? publishedDate;

  NewsArticle({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.publishedDate,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "content": content,
      "author": author,
      "publishedDate": publishedDate?.toIso8601String(),
    };
  }

  factory NewsArticle.fromJson(Map<String, dynamic> json, String id) {
    DateTime? publishedDate;

    if (json['publishedDate'] is Timestamp) {
      publishedDate = (json['publishedDate'] as Timestamp).toDate();
    } else if (json['publishedDate'] is String) {
      publishedDate = DateTime.parse(json['publishedDate']);
    }

    return NewsArticle(
      id: id,
      title: json['title'] ?? 'Untitled',
      content: json['content'] ?? '',
      author: json['author'] ?? 'Unknown Author',
      publishedDate: publishedDate ?? DateTime.now(),
    );
  }
}
