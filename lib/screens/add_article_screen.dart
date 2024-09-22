import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/article_controller.dart';
import '../models/news_article_model.dart';

class AddArticleScreen extends StatelessWidget {
  final AddArticleController addArticleController =
      Get.put(AddArticleController());

  final NewsArticle? article;

  AddArticleScreen({super.key, this.article}) {
    // Populate the controllers with the existing article data, if any
    if (article != null) {
      addArticleController.titleController.text = article?.title ?? '';
      addArticleController.contentController.text = article?.content ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Article'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Title
                        TextFormField(
                          controller: addArticleController.titleController,
                          decoration: InputDecoration(
                            labelText: 'Title',
                            prefixIcon: const Icon(Icons.title),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the title';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        // Content
                        TextFormField(
                          controller: addArticleController.contentController,
                          decoration: InputDecoration(
                            labelText: 'Content',
                            prefixIcon: const Icon(Icons.article),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          maxLines: 10,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the content';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (article == null) {
                                addArticleController.addArticle(context);
                              } else {
                                // Call the editArticle method instead of directly editing the repository
                                addArticleController.editArticle(
                                    context, article!.id ?? '');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              article == null ? 'Add Article' : 'Edit Article',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
