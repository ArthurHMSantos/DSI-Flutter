import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class CardMode extends StatefulWidget {
  final List<WordPair> suggestions;
  final Set<WordPair> saved;
  final TextStyle biggerFont;
  const CardMode(
      {super.key,
      required this.suggestions,
      required this.saved,
      required this.biggerFont});

  @override
  State<CardMode> createState() => _CardModeState();
}

class _CardModeState extends State<CardMode> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(widget.suggestions.length, (index) {
        final pair = widget.suggestions[index];
        final alreadySaved = widget.saved.contains(pair);
        return Card(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  title: Text(
                    pair.asPascalCase,
                    style: widget.biggerFont,
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      alreadySaved ? Icons.favorite : Icons.favorite_border,
                      color: alreadySaved
                          ? const Color.fromARGB(255, 70, 2, 61)
                          : null,
                    ),
                    onPressed: () {
                      setState(() {
                        if (alreadySaved) {
                          widget.saved.remove(pair);
                        } else {
                          widget.saved.add(pair);
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
