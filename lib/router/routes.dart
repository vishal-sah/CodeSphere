import 'package:codesphere/auth/login_page.dart';
import 'package:codesphere/landingPage/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyRoutes {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: LandingPage(initialPage: 0),
          );
        },
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: EmailPasswordLoginPage(),
          );
        },
      ),
    ],
    // redirect: (context, state) async {
    //   User? user = FirebaseAuth.instance.currentUser;
    //   if (user == null && state.matchedLocation == '/') {
    //     return '/login';
    //   } else {
    //     return null;
    //   }
    // },
  );
}
