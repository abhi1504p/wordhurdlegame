import 'package:flutter/material.dart';

const keysList = [
  ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
  ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
  ['Z', 'X', 'C', 'V', 'B', 'N', 'M'],
];

class KeyboardView extends StatelessWidget {
  final List<String>excludedLetters;
  final Function(String)onpressed;
   const KeyboardView({super.key, required this.excludedLetters, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            for (int i = 0; i < keysList.length; i++)
              Row(
                children: keysList[i]
                    .map((e) => VirtualKey(
                          letter: e,
                          excluded: excludedLetters.contains(e),
                          onpress: (p0) {
                            onpressed(p0);
                          },
                        ))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}

class VirtualKey extends StatelessWidget {
  final String letter;
  final bool excluded;
  Function(String) onpress;
  VirtualKey(
      {super.key,
      required this.letter,
      required this.excluded,
      required this.onpress});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          onpress(letter);
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: excluded ? Colors.red : Colors.black,
            foregroundColor: Colors.white,padding: EdgeInsets.zero),

        child: Text(letter),
      ),
    );
  }
}
