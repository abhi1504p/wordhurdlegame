import 'dart:math';
import 'package:get/get.dart';
import 'package:english_words/english_words.dart' as words;
import '../wordle.dart'; // Ensure this import is correct

class HurdleGetx extends GetxController {
  final random = Random.secure();
  var totalwords = <String>[].obs; // Observable list of words
  var rowInput = <String>[].obs;
  var excludedLetters = <String>[].obs;
  var hurdleBoard = <Wordle>[].obs;
  final attempt=0.obs;
  final totalattempt=6.obs;

  RxString targetWord = ''.obs;
  RxInt count = 0.obs;
  RxInt index = 0.obs;
  final letterrow = 5;
  RxBool wins = false.obs;

  @override
  void onInit() {
    // Assign filtered words to class-level totalwords
    totalwords.value =
        words.all.where((element) => element.length == 5).toList();
    generateBoard();
    generateRandomWord();

    super.onInit();
  }

  void generateBoard() {
    // Assign to class-level hurdleBoard
    hurdleBoard.value = List.generate(30, (index) => Wordle(letter: ""));
  }

  void generateRandomWord() {
    // Check if totalwords is empty
    if (totalwords.isEmpty) {

      return;
    }
    // Generate a random word and assign it to targetWord
    targetWord.value =
        totalwords[random.nextInt(totalwords.length)].toUpperCase();
  }

  bool get isvalidWord => totalwords.contains(rowInput.join('').toLowerCase());

  bool get checktheanswer => rowInput.length == letterrow;

  bool get notattemptLeft => attempt.value==totalattempt.value;

  inputLetter(String letter) {
    if (count < letterrow) {
      rowInput.add(letter);
      count++;
      hurdleBoard[index.value] = Wordle(letter: letter);
      index.value++;
    }
    refresh();
  }

  void deleteLetter() {
    if (rowInput.isNotEmpty) {
      rowInput.remove(rowInput.length - 1);
    }
    if (count > 0) {
      hurdleBoard[index.value - 1] = Wordle(letter: '');
      count--;
      index--;
    }
    refresh();
  }

  void checkanswer() {
    final input = rowInput.join("");
    if (targetWord == input) {
      wins.value = true;
    } else {
      _markletterboard();
      if(attempt.value<totalattempt.value){
        _gonextrow();
      }
    }
  }

  void _markletterboard() {
    for (int i = 0; i < hurdleBoard.length; i++) {
      if (hurdleBoard[i].letter.isNotEmpty &&
          targetWord.contains(hurdleBoard[i].letter)) {
        hurdleBoard[i].existInTarget = true;
      } else if (hurdleBoard[i].letter.isNotEmpty &&
          !targetWord.contains(hurdleBoard[i].letter)) {
        hurdleBoard[i].doesnotexistInTarget = true;
        excludedLetters.add(hurdleBoard[i].letter);
      }
      refresh();
    }
  }

  void _gonextrow() {
    attempt.value++;
    count.value=0;
    rowInput.clear();
  }
  reset(){
    count.value=0;
    index.value=0;
    rowInput.clear();
    hurdleBoard.clear();
    excludedLetters.clear();
    attempt.value=0;
    wins.value=false;
    targetWord.value="";
    generateBoard();
    generateRandomWord();
    refresh();
  }
}
