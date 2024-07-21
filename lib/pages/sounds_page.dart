import 'package:flutter/material.dart';

class SoundsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sounds'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Relaxing Sounds'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SoundBoard()),
                );
              },
              child: Text('Play Sounds'),
            ),
          ],
        ),
      ),
    );
  }
}

class SoundBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sound Board'),
      ),
      body: Center(
        child: Text('Sound board functionality goes here'),
      ),
    );
  }
}