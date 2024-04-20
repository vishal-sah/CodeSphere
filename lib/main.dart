import 'package:codesphere/dashboard/dashboard.dart';
import 'package:codesphere/firebase/firebase_functions.dart';
import 'package:codesphere/firebase_options.dart';
import 'package:codesphere/landingPage/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AuthServices auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CodeSphere',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: auth.getCurentUser() == null ? const LandingPage(
        initialPage: 0,
      ) : const DashBoard(),
    );
  }
}
