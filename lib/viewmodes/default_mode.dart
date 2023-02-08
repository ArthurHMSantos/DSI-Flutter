import 'package:flutter/material.dart';

import '../main.dart';

class DefaultMode extends StatefulWidget {
  final WordRepository repository;
  final Set<String> saved;
  final TextStyle biggerFont;
  const DefaultMode(
      {super.key,
      required this.repository,
      required this.saved,
      required this.biggerFont});

  @override
  State<DefaultMode> createState() => _DefaultModeState();
}

class _DefaultModeState extends State<DefaultMode> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: 20,
      itemBuilder: (context, i) {
        final word = widget.repository.words[i];
        final alreadySaved = widget.saved.contains(word.word1);

        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/second',
                arguments: PassedArgs(nome: word.word1, id: i));
          },
          child: ListTile(
            title: Text(
              word.word1,
              style: widget.biggerFont,
            ),
            trailing: IconButton(
              icon: alreadySaved
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border),
              color: alreadySaved ? const Color.fromARGB(255, 70, 2, 61) : null,
              onPressed: () {
                setState(() {
                  if (alreadySaved) {
                    widget.saved.remove(word.word1);
                  } else {
                    widget.saved.add(word.word1);
                  }
                });
              },
            ),
          ),
        );
      },
    );
  }
}
