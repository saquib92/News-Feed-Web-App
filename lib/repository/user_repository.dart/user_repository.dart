import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/models/news_article_model.dart';
import 'package:flutter_assignment/models/user_model.dart';
import 'package:get/get.dart';

import '../../routes/routing_name.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  bool isLoggedInSync() {
    return _auth.currentUser != null;
  }

  Future<void> registerUser(UserModel user, String password) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: user.email ?? '',
        password: password,
      );

      UserModel newUser = UserModel(
        id: cred.user?.uid,
        email: user.email,
        fullName: user.fullName,
        phoneNo: user.phoneNo,
        password: password,
      );

      await _db.collection("Users").doc(cred.user?.uid).set(newUser.toJson());

      Get.snackbar(
        "Success",
        "Your account has been created",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade500,
        colorText: Colors.white,
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        e.message ?? "An error occurred",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong. Try again",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
      debugPrint("error: ${e.toString()}");
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar(
        "Success",
        "Logged in successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade500,
        colorText: Colors.white,
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        e.message ?? "An error occurred",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong. Try again",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
      debugPrint("error: ${e.toString()}");
    }
  }

  Future<void> addArticle(NewsArticle article) async {
    if (currentUser == null) {
      Get.snackbar(
        "Error",
        "You must be logged in to add an article.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
      return;
    }

    final newArticle = NewsArticle(
      id: article.id,
      title: article.title,
      content: article.content,
      author: currentUser?.email ?? '',
      publishedDate: article.publishedDate,
    );

    await _db
        .collection('news_articles')
        .doc(newArticle.id)
        .set(newArticle.toJson());
  }

  Stream<List<NewsArticle>> getArticles() {
    return _db.collection('news_articles').snapshots().map((snapshot) {
      debugPrint('Snapshot received: ${snapshot.docs.length} documents');
      return snapshot.docs.map((doc) {
        return NewsArticle.fromJson(doc.data(), doc.id);
      }).toList();
    }).handleError((error) {
      debugPrint('Error fetching articles: $error');
    });
  }

  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed(RoutingNames.authWrapper);
  }

  User? get currentUser => _auth.currentUser;

  Future<void> editArticle(NewsArticle article) async {
    if (currentUser == null) {
      Get.snackbar(
        "Error",
        "You must be logged in to edit an article.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
      return;
    }

    // Debugging prints
    print('Updating article with ID: ${article.id}');
    print('Edited Fields:');
    print('Title: ${article.title}');
    print('Content: ${article.content}');
    print('Author: ${article.author}');
    print('Published Date: ${article.publishedDate}');
    print('Data to be sent: ${article.toJson()}');

    // Update the article in Firestore
    try {
      await _db
          .collection('news_articles')
          .doc(article.id)
          .update(article.toJson());
      Get.snackbar(
        "Success",
        "Article updated successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade500,
        colorText: Colors.white,
      );
      Get.offAllNamed(RoutingNames.newsFeed);
    } catch (error) {
      print('Error updating article: $error'); // Debug print
      Get.snackbar(
        "Error",
        "Failed to update article: $error",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
    }
  }

  Future<void> deleteArticle(String articleId) async {
    if (currentUser == null) {
      Get.snackbar(
        "Error",
        "You must be logged in to delete an article.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
      return;
    }

    // Delete the article from Firestore
    await _db.collection('news_articles').doc(articleId).delete().then((_) {
      Get.snackbar(
        "Success",
        "Article deleted successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade500,
        colorText: Colors.white,
      );
    }).catchError((error) {
      Get.snackbar(
        "Error",
        "Failed to delete article: $error",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
    });
  }
}
