import 'package:flutter/material.dart';

import '../wordle.dart';

class WordleView extends StatelessWidget {
  final Wordle wordle;
  const WordleView({super.key, required this.wordle});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: wordle.existInTarget
              ? Colors.green
              : wordle.doesnotexistInTarget
                  ? Colors.blueGrey
                  : null,
          border: Border.all(color: Colors.amber, width: 1.5)),
      child: Text(
        wordle.letter,
        style: TextStyle(
          color: wordle.existInTarget
              ? Colors.black
              : wordle.doesnotexistInTarget
                  ? Colors.white54
                  : Colors.white,
        ),
      ),
    );
  }
}
