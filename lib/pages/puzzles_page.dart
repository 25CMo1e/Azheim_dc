import 'package:flutter/material.dart';

class PuzzlesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Puzzles'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Brain Puzzles'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PuzzleGame()),
                );
              },
              child: const Text('Solve Puzzles'),
            ),
          ],
        ),
      ),
    );
  }
}


void main() {
  runApp(MaterialApp(
    home: PuzzleGame(),
  ));
}




class PuzzleGame extends StatefulWidget {
  @override
  _PuzzleGameState createState() => _PuzzleGameState();
}

class _PuzzleGameState extends State<PuzzleGame> {
  List<int> _tiles = [];
  int _gridSize = 2;
  int _moves = 0;
  bool _isSolved = false;

  @override
  void initState() {
    super.initState();
    _initializeTiles();
  }

  void _initializeTiles() {
    do {
      _tiles = List<int>.generate(_gridSize * _gridSize, (i) => i);
      _tiles.shuffle();
    } while (!_isSolvable(_tiles) || _isSolvedState());
    _isSolved = false;
  }

  bool _isSolvable(List<int> tiles) {
    int inversions = 0;
    for (int i = 0; i < tiles.length; i++) {
      for (int j = i + 1; j < tiles.length; j++) {
        if (tiles[i] != 0 && tiles[j] != 0 && tiles[i] > tiles[j]) {
          inversions++;
        }
      }
    }
    int emptyRow = tiles.indexOf(0) ~/ _gridSize;
    return (inversions % 2 == 0) == ((_gridSize % 2 == 1) || (emptyRow % 2 == 1));
  }

  bool _isSolvedState() {
    for (int i = 0; i < _tiles.length - 1; i++) {
      if (_tiles[i] != i + 1) {
        return false;
      }
    }
    return _tiles[_tiles.length - 1] == 0;
  }

  void _resetGame() {
    setState(() {
      _moves = 0;
      _initializeTiles();
    });
  }

  void _increaseDifficulty() {
    setState(() {
      if (_gridSize < 5) {
        _gridSize++;
      }
      _resetGame();
    });
  }

  void _decreaseDifficulty() {
    setState(() {
      if (_gridSize > 2) {
        _gridSize--;
      }
      _resetGame();
    });
  }

  void _moveTile(int index) {
    if (_isSolved) return;

    int emptyIndex = _tiles.indexOf(0);
    int row = index ~/ _gridSize;
    int col = index % _gridSize;
    int emptyRow = emptyIndex ~/ _gridSize;
    int emptyCol = emptyIndex % _gridSize;

    if ((row == emptyRow && (col == emptyCol - 1 || col == emptyCol + 1)) ||
        (col == emptyCol && (row == emptyRow - 1 || row == emptyRow + 1))) {
      _swapTiles(index, emptyIndex);
    }

    _checkWinCondition();
  }

  void _swapTiles(int index1, int index2) {
    setState(() {
      int temp = _tiles[index1];
      _tiles[index1] = _tiles[index2];
      _tiles[index2] = temp;
      _moves++;
    });
  }

  void _checkWinCondition() {
    if (_isSolvedState()) {
      setState(() {
        _isSolved = true;
      });
      _showWinDialog();
    }
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Congratulations!"),
          content: Text("You solved the puzzle in $_moves moves."),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                _resetGame();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Puzzle Game'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetGame,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('Moves: $_moves'),
              ),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _gridSize,
                  mainAxisSpacing: 2.0,
                  crossAxisSpacing: 2.0,
                ),
                itemCount: _tiles.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _moveTile(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: _tiles[index] == 0 ? Colors.white : Colors.blue,
                        border: Border.all(color: Colors.black),
                      ),
                      child: Center(
                        child: Text(
                          _tiles[index] == 0 ? '' : '${_tiles[index]}',
                          style: const TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _decreaseDifficulty,
                      child: const Text('Decrease Difficulty'),
                    ),
                    ElevatedButton(
                      onPressed: _increaseDifficulty,
                      child: const Text('Increase Difficulty'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
