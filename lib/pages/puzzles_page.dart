import 'package:flutter/material.dart';

class PuzzlesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Puzzles'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Brain Puzzles'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PuzzleGame()),
                );
              },
              child: Text('Solve Puzzles'),
            ),
          ],
        ),
      ),
    );
  }
}

class PuzzleGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Puzzle Game'),
      ),
      body: Center(
        child: Text('Puzzle game functionality goes here'),
      ),
    );
  }
}