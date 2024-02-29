// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'questions.dart';
import 'options.dart';

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int counter = 1;
  int o1 = 1;
  int o2 = 2;
  int o3 = 3;
  int o4 = 4;
  List colr = List.filled(10, false);
  bool isAnswered = false;

  Color defaultColor = Colors.white;
  void correctAnswer(int selectedOption) {
    if (selectedOption == answer[counter - 1]) {
      setState(() {
        colr[counter - 1] = true;
        isAnswered = true;
      });
    } else {
      setState(() {
        colr[counter - 1] = false;
        isAnswered = true;
      });
    }
  }

  Color getCorrectColor(int option) {
    if (answer[counter - 1] == option && colr[counter - 1]) {
      return Colors.green;
    } else if (!colr[counter - 1] && isAnswered) {
      return Colors.red;
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz App"),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              child: Text(
                "Question: $counter/10",
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Question $counter: ${list[counter - 1]}",
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: getCorrectColor(o1),
                ),
                onPressed: () {
                  correctAnswer(1);
                },
                child: Text("${options1[counter - 1]}"),
              ),
            ),
            Container(
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: getCorrectColor(o2),
                ),
                onPressed: () {
                  correctAnswer(2);
                },
                child: Text("${options2[counter - 1]}"),
              ),
            ),
            Container(
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: getCorrectColor(o3),
                ),
                onPressed: () {
                  correctAnswer(3);
                },
                child: Text("${options3[counter - 1]}"),
              ),
            ),
            Container(
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: getCorrectColor(o4),
                ),
                onPressed: () {
                  correctAnswer(4);
                },
                child: Text("${options4[counter - 1]}"),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: null,
            onPressed: () {
              setState(() {
                isAnswered = false;
                if (counter < 10) {
                  counter++;
                }
              });
            },
            child: const Icon(
              Icons.navigate_next,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            heroTag: null,
            onPressed: () {
              setState(
                () {
                  isAnswered = false;
                  if (counter >= 2) {
                    counter--;
                  }
                },
              );
            },
            child: const Icon(Icons.navigate_before),
          ),
        ],
      ),
    );
  }
}
