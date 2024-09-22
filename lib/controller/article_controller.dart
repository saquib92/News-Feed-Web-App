import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/news_article_model.dart';
import '../repository/user_repository.dart/user_repository.dart';

class AddArticleController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final UserRepository userRepository = UserRepository();

  void addArticle(BuildContext context) {
    final title = titleController.text.trim();
    final content = contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    NewsArticle article = NewsArticle(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      content: content,
      author: 'Author Name', // Ideally, fetch from user data
      publishedDate: DateTime.now(),
    );

    userRepository.addArticle(article);
    _clearFields(); // Clear fields after adding
    Navigator.pop(context); // Navigate back after adding
  }

  void editArticle(BuildContext context, String articleId) {
    final title = titleController.text.trim();
    final content = contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    NewsArticle updatedArticle = NewsArticle(
      id: articleId,
      title: title,
      content: content,
      author: 'Author Name', // Ideally, fetch from user data
      // Maintain original published date if not updating
      publishedDate: DateTime
          .now(), // Optional: change if you want to keep the original date
    );

    userRepository.editArticle(updatedArticle);
    _clearFields(); // Clear fields after editing
    Navigator.pop(context); // Navigate back after editing
  }

  // Method to populate fields when editing
  void populateFields(NewsArticle article) {
    titleController.text = article.title ?? '';
    contentController.text = article.content ?? '';
  }

  // Clear the input fields
  void _clearFields() {
    titleController.clear();
    contentController.clear();
  }
}
