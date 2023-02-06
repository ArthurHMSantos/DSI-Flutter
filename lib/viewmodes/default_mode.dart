import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class DefaultMode extends StatefulWidget {
  final List<WordPair> suggestions;
  final Set<WordPair> saved;
  final TextStyle biggerFont;
  const DefaultMode(
      {super.key,
      required this.suggestions,
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
      itemBuilder: (context, i) {
        if (i.isOdd) return const Divider();

        final index = i ~/ 2;
        if (index >= widget.suggestions.length) {
          widget.suggestions.addAll(generateWordPairs().take(10));
        }
        final wordPair = widget.suggestions[index];
        final alreadySaved = widget.saved.contains(widget.suggestions[index]);

        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/second');
          },
          child: ListTile(
            title: Text(
              wordPair.asPascalCase,
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
                    widget.saved.remove(wordPair);
                  } else {
                    widget.saved.add(wordPair);
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
