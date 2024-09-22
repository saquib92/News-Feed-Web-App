// screens/auth_wrapper.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/routing_name.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // While checking auth state, show a loading indicator
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData) {
          // If user is logged in, navigate to NewsFeed
          Future.microtask(() => Get.offAllNamed(RoutingNames.newsFeed));
        } else {
          // If not logged in, navigate to Login
          Future.microtask(() => Get.offAllNamed(RoutingNames.login));
        }
        // Return an empty container while navigating
        return const SizedBox.shrink();
      },
    );
  }
}
