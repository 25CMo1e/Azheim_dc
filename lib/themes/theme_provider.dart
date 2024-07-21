import 'package:azheim_care/themes/dark_mode.dart';
import 'package:azheim_care/themes/light_mode.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  //initially
  ThemeData _themeData = lightMode;
  //get theme
  ThemeData get themeData => _themeData;
  //set theme
  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {

    _themeData = themeData;
  //update UI
    notifyListeners();
  }

  //toggle theme
  void toggleTheme(){
    if(_themeData == lightMode) {
      themeData = darkMode;
    }else{
      themeData = lightMode;
    }
  }
}