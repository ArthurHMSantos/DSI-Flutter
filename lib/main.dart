import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'viewmodes/card_mode.dart';
import 'viewmodes/default_mode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Statup name generator',
        initialRoute: '/',
        routes: {
          '/': (context) => const RandomWords(),
          '/second': (context) => const EditScreen(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 70, 2, 61),
          foregroundColor: Color.fromARGB(255, 255, 255, 255),
        )));
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 20);
  bool switchMode = false;

  void _pushSaved() {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (context) {
        final tiles = _saved.map((pair) {
          return ListTile(
            title: Text(
              pair.asPascalCase,
              style: _biggerFont,
            ),
          );
        });
        final divided = tiles.isNotEmpty
            ? ListTile.divideTiles(context: context, tiles: tiles).toList()
            : <Widget>[];

        return Scaffold(
          appBar: AppBar(
            title: const Text("Saved suggestions"),
          ),
          body: ListView(children: divided),
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
        actions: [
          IconButton(
            onPressed: _pushSaved,
            icon: const Icon(Icons.list),
            tooltip: "Saved suggestions",
          )
        ],
      ),
      body: switchMode
          ? CardMode(
              repository: WordRepository(),
              biggerFont: _biggerFont,
              saved: _saved,
            )
          : DefaultMode(
              saved: _saved,
              biggerFont: _biggerFont,
              repository: WordRepository(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            switchMode = !switchMode;
          });
        },
        backgroundColor: const Color.fromARGB(255, 70, 2, 61),
        child: const Icon(Icons.swap_horiz),
      ),
    );
  }
}

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 70, 2, 61),
          ),
          onPressed: () {
            Navigator.pop(context);
            // Navigate back to first screen when tapped.
          },
          child: const Text('Go back!', style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}

class Word {
  final String word1;
  final String word2;

  Word({required this.word1, required this.word2});
}

class WordRepository {
  final List<Word> words = [
    Word(word1: "Palavra", word2: " 1"),
    Word(word1: "Palavra", word2: " 2"),
    Word(word1: "Palavra", word2: " 3"),
    Word(word1: "Palavra", word2: " 4"),
    Word(word1: "Palavra", word2: " 5"),
    Word(word1: "Palavra", word2: " 6"),
    Word(word1: "Palavra", word2: " 7"),
    Word(word1: "Palavra", word2: " 8"),
    Word(word1: "Palavra", word2: " 9"),
    Word(word1: "Palavra", word2: " 10"),
    Word(word1: "Palavra", word2: " 11"),
    Word(word1: "Palavra", word2: " 12"),
    Word(word1: "Palavra", word2: " 13"),
    Word(word1: "Palavra", word2: " 14"),
    Word(word1: "Palavra", word2: " 15"),
    Word(word1: "Palavra", word2: " 16"),
    Word(word1: "Palavra", word2: " 17"),
    Word(word1: "Palavra", word2: " 18"),
    Word(word1: "Palavra", word2: " 19"),
    Word(word1: "Palavra", word2: " 20"),
  ];
}
