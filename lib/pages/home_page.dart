import 'package:azheim_care/components/my_drawer.dart';
import 'package:azheim_care/pages/games_page.dart';
import 'package:azheim_care/pages/pictures_page.dart';
import 'package:azheim_care/pages/puzzles_page.dart';
import 'package:azheim_care/pages/sounds_page.dart';
import 'package:azheim_care/pages/videos_page.dart';
import 'package:azheim_care/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget{
  const HomePage({super.key});


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.themeData.colorScheme.background,
      appBar: AppBar(
        title: const Text('Cognitive Improvement App'),
        backgroundColor: themeProvider.themeData.colorScheme.primary,
      ),
      drawer: MyDrawer() ,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FeatureButton(title: 'Games', route: GamesPage()),
            FeatureButton(title: 'Pictures', route: PicturesPage()),
            FeatureButton(title: 'Videos', route: VideosPage()),
            FeatureButton(title: 'Sounds', route: SoundsPage()),
            FeatureButton(title: 'Puzzles', route: PuzzlesPage()),
          ],
        ),
      ),
    );
  }
}

class FeatureButton extends StatelessWidget {
  final String title;
  final Widget route;

  FeatureButton({required this.title, required this.route});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => route),
        );
      },
      child: Text(title),
    );
  }
}

