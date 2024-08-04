import 'package:azheim_care/pages/pictures_page.dart';
import 'package:azheim_care/pages/puzzles_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'themes/theme_provider.dart';
import 'package:azheim_care/components/photo_provider.dart'; // 确保导入你的PhotoProvider类

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => PhotoProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Cognitive Improvement App',
            theme: themeProvider.themeData,
            home: const HomePage(),
            routes: {
              // 添加你的路由，比如:
              '/pictures': (context) => PicturesPage(),
              '/puzzles': (context) => PuzzlesPage(),
              // 其他路由...
            },
          );
        },
      ),
    );
  }
}

