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
  final _saved = <String>{};
  final _biggerFont = const TextStyle(fontSize: 20);
  bool switchMode = false;

  void _pushSaved() {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (context) {
        final tiles = _saved.map((pair) {
          return ListTile(
            title: Text(
              pair,
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
  TextEditingController controller = TextEditingController();
  final repository = WordRepository();

  onSubmit() {
    final receivedArg =
        ModalRoute.of(context)!.settings.arguments as PassedArgs;

    final newWord = controller.text;

    if (newWord.isEmpty) {
      return;
    }

    repository.updateWord(receivedArg.id, newWord);
    Navigator.of(context).pop(newWord);
  }

  @override
  Widget build(BuildContext context) {
    final rec = ModalRoute.of(context)?.settings.arguments as PassedArgs;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Screen'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Edit the word',
            style: TextStyle(fontSize: 20),
          ),
          Center(
            child: Text(
              rec.nome,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Edit the word',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 70, 2, 61),
            ),
            onPressed: onSubmit,
            child: const Text('Submit', style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}

class Word {
  String word1;

  Word({required this.word1});
}

class WordRepository {
  final List<Word> words = [
    Word(word1: "Palavra 1"),
    Word(word1: "Palavra 2"),
    Word(word1: "Palavra 3"),
    Word(word1: "Palavra 4"),
    Word(word1: "Palavra 5"),
    Word(word1: "Palavra 6"),
    Word(word1: "Palavra 7"),
    Word(word1: "Palavra 8"),
    Word(word1: "Palavra 9"),
    Word(word1: "Palavra 10"),
    Word(word1: "Palavra 11"),
    Word(word1: "Palavra 12"),
    Word(word1: "Palavra 13"),
    Word(word1: "Palavra 14"),
    Word(word1: "Palavra 15"),
    Word(word1: "Palavra 16"),
    Word(word1: "Palavra 17"),
    Word(word1: "Palavra 18"),
    Word(word1: "Palavra 19"),
    Word(word1: "Palavra 20"),
  ];

  updateWord(int id, String newWord) {
    words[id].word1 = newWord;
  }
}

class PassedArgs {
  String nome;
  int id;

  PassedArgs({
    required this.nome,
    required this.id,
  });
}
