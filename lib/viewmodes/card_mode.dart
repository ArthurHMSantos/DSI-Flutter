import 'package:flutter/material.dart';

import '../main.dart';

class CardMode extends StatefulWidget {
  final WordRepository repository;
  final TextStyle biggerFont;
  final Set<String> saved;
  const CardMode({
    super.key,
    required this.repository,
    required this.biggerFont,
    required this.saved,
  });

  @override
  State<CardMode> createState() => _CardModeState();
}

class _CardModeState extends State<CardMode> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(20, (index) {
        final word = widget.repository.words[index];
        final alreadySaved = widget.saved.contains(word.word1);

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
                      style: widget.biggerFont,
                    ),
                    trailing: IconButton(
                      alignment: Alignment.centerRight,
                      icon: Icon(
                        alreadySaved ? Icons.favorite : Icons.favorite_border,
                        color: alreadySaved
                            ? const Color.fromARGB(255, 70, 2, 61)
                            : null,
                      ),
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
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
