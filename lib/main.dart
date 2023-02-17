import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Word {
  String word1;

  Word({required this.word1});
}

class WordRepository {
  List<Word> words = [
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

  void addWord(String word) {
    words.add(Word(word1: word));
  }
}

final WordRepository repository = WordRepository();
final Set<String> saved = <String>{};
const TextStyle biggerFont = TextStyle(fontSize: 20);

class PassedArgs {
  String nome;
  int id;

  PassedArgs({
    required this.nome,
    required this.id,
  });
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
          EditScreen.routeName: (context) => const EditScreen(),
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
  bool switchMode = false;
  void _pushSaved() {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (context) {
        final tiles = saved.map((pair) {
          return ListTile(
            title: Text(
              pair,
              style: biggerFont,
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

  bady() {
    if (switchMode == false) {
      return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: repository.words.length,
        itemBuilder: (context, i) {
          final word = repository.words[i];
          final alreadySaved = saved.contains(word.word1);

          return ListTile(
              title: Text(
                word.word1,
                style: biggerFont,
              ),
              onTap: () {
                Navigator.pushNamed(context, '/second',
                    arguments: PassedArgs(nome: word.word1, id: i));
              },
              trailing: IconButton(
                icon: alreadySaved
                    ? const Icon(Icons.favorite)
                    : const Icon(Icons.favorite_border),
                color:
                    alreadySaved ? const Color.fromARGB(255, 70, 2, 61) : null,
                onPressed: () {
                  setState(() {
                    if (alreadySaved) {
                      saved.remove(word.word1);
                    } else {
                      saved.add(word.word1);
                    }
                  });
                },
              ));
        },
      );
    } else {
      return GridView.count(
        crossAxisCount: 2,
        children: List.generate(repository.words.length, (index) {
          final word = repository.words[index];
          final alreadySaved = saved.contains(word.word1);

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/second',
                  arguments: PassedArgs(nome: word.word1, id: index));
            },
            child: Card(
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      title: Text(
                        word.word1,
                        style: biggerFont,
                      ),
                      trailing: IconButton(
                        alignment: Alignment.bottomLeft,
                        icon: Icon(
                          alreadySaved ? Icons.favorite : Icons.favorite_border,
                          color: alreadySaved
                              ? const Color.fromARGB(255, 70, 2, 61)
                              : null,
                        ),
                        onPressed: () {
                          setState(() {
                            if (alreadySaved) {
                              saved.remove(word.word1);
                            } else {
                              saved.add(word.word1);
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
        actions: [
          IconButton(
            onPressed: _pushSaved,
            icon: const Icon(Icons.list_rounded),
            tooltip: "Saved suggestions",
          ),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/second',
                    arguments:
                        PassedArgs(nome: "", id: repository.words.length + 1));
              },
              icon: const Icon(Icons.add_circle_outline))
        ],
      ),
      body: bady(),
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

  static const routeName = "/second";

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController controller = TextEditingController();

  onSubmit() {
    final receivedArg =
        ModalRoute.of(context)!.settings.arguments as PassedArgs;

    final newWord = controller.text;

    if (newWord.isEmpty) {
      return;
    }

    repository.updateWord(receivedArg.id, newWord);
    Navigator.pushNamed(context, '/');
  }

  addWord() {
    final word = controller.text;

    if (word.isEmpty) {
      return;
    }

    repository.addWord(word);
    Navigator.pushNamed(context, '/');
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
            child: const Text('Editar', style: TextStyle(fontSize: 20)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 70, 2, 61),
            ),
            onPressed: addWord,
            child:
                const Text('Adicionar palavra', style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}
