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
              suggestions: _suggestions,
              saved: _saved,
              biggerFont: _biggerFont,
            )
          : DefaultMode(
              suggestions: _suggestions,
              saved: _saved,
              biggerFont: _biggerFont),
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
