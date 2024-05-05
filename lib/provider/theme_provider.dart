import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool darkTheme = false;

  void toggleTheme() async {
    darkTheme = !darkTheme;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkTheme', darkTheme);
  }

  Future<bool> getThememode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? gotTheme = await prefs.getBool('darkTheme');
    if (gotTheme == null) {
      darkTheme = false;
    } else {
      darkTheme = gotTheme;
    }
    return darkTheme;
  }
}
