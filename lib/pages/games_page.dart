
import 'dart:async';

import 'package:flutter/material.dart';

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Games'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoryGamePage()),
                );
              },
              child: const Text('Memory Matching Game'),
            ),
            // 其他游戏按钮在此处添加
          ],
        ),
      ),
    );
  }
}

class MemoryGamePage extends StatefulWidget {
  @override
  _MemoryGamePageState createState() => _MemoryGamePageState();
}

class _MemoryGamePageState extends State<MemoryGamePage> {
  List<String> _cards = [
    '🍎', '🍎',
    '🍌', '🍌',
    '🍇', '🍇',
    '🍉', '🍉',
  ];
  List<bool> _cardFlipped = [false, false, false, false, false, false, false, false];
  List<int> _selectedIndices = [];
  int _matchesFound = 0;
  Timer? _timer;
  int _secondsPassed = 0;

  @override
  void initState() {
    super.initState();
    _cards.shuffle();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _secondsPassed++;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _resetGame() {
    setState(() {
      _cards.shuffle();
      _cardFlipped = [false, false, false, false, false, false, false, false];
      _selectedIndices.clear();
      _matchesFound = 0;
      _secondsPassed = 0;
      _startTimer();
    });
  }

  void _onCardTap(int index) {
    if (_cardFlipped[index] || _selectedIndices.length == 2) {
      return;
    }

    setState(() {
      _cardFlipped[index] = true;
      _selectedIndices.add(index);
    });

    if (_selectedIndices.length == 2) {
      if (_cards[_selectedIndices[0]] == _cards[_selectedIndices[1]]) {
        _matchesFound++;
        _selectedIndices.clear();
        if (_matchesFound == _cards.length ~/ 2) {
          _stopTimer();
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Congratulations!'),
              content: Text('You found all matches in $_secondsPassed seconds!'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _resetGame();
                  },
                  child: Text('Play Again'),
                ),
              ],
            ),
          );
        }
      } else {
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _cardFlipped[_selectedIndices[0]] = false;
            _cardFlipped[_selectedIndices[1]] = false;
            _selectedIndices.clear();
          });
        });
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memory Matching Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Time: $_secondsPassed seconds'),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: _cards.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _onCardTap(index),
                  child: Card(
                    child: Center(
                      child: Text(
                        _cardFlipped[index] ? _cards[index] : '',
                        style: TextStyle(fontSize: 32),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
