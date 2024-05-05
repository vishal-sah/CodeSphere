import 'package:codesphere/dashboard/dashboard.dart';
import 'package:codesphere/firebase/firebase_functions.dart';
import 'package:codesphere/firebase_options.dart';
import 'package:codesphere/landingPage/landing_page.dart';
import 'package:codesphere/provider/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(builder: (context, ThemeModel, child) {
        //ThemeModel.getThememode();
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'CodeSphere',
          // theme: ThemeData(
          //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          //   useMaterial3: true,
          // ),
          theme: ThemeModel.darkTheme ? ThemeData.dark() : ThemeData.light(),
          themeMode: ThemeModel.darkTheme ? ThemeMode.dark : ThemeMode.light,
          home: auth.getCurentUser() == null
              ? const LandingPage(
                  initialPage: 0,
                )
              : const DashBoard(),
        );
      }),
    );
  }
}
