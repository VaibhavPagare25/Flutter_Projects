import 'package:flutter/material.dart';
import 'questions.dart';
import 'options.dart';

class QuizApp1 extends StatefulWidget {
  const QuizApp1({super.key});

  @override
  State<QuizApp1> createState() => _QuizApp1State();
}

class _QuizApp1State extends State<QuizApp1> {
  int counter = 1;
  int selectedOption = 0; // atta select kelele selectedOption
  //bool isAnswered = false; // fakt answer select kele ahe ka nahi ya sathi

  Color getOptionColor(int option) {
    if (selectedOption == option) {
      return answer[counter - 1] == option ? Colors.green : Colors.red;
    } else {
      return Colors.white;
    }
  }

  void checkAnswer(int selectedOption) {
    setState(() {
      //isAnswered = true;
      this.selectedOption = selectedOption;
    });
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
                  backgroundColor: getOptionColor(1),
                ),
                onPressed: () => checkAnswer(1),
                child: Text("${options1[counter - 1]}"),
              ),
            ),
            Container(
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: getOptionColor(2),
                ),
                onPressed: () => checkAnswer(2),
                child: Text("${options2[counter - 1]}"),
              ),
            ),
            Container(
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: getOptionColor(3),
                ),
                onPressed: () => checkAnswer(3),
                child: Text("${options3[counter - 1]}"),
              ),
            ),
            Container(
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: getOptionColor(4),
                ),
                onPressed: () => checkAnswer(4),
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
              if (counter < 10) {
                setState(() {
                  counter++;
                  //isAnswered = false;
                  selectedOption =
                      0; //jevha question pudhe kivva mage jato tevha slected option parart reset kr
                });
              }
            },
            child: const Icon(Icons.navigate_next),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: null,
            onPressed: () {
              if (counter >= 2) {
                setState(() {
                  counter--;
                  //isAnswered = false;
                  selectedOption =
                      0; //jevha question pudhe kivva mage jato tevha slected option parart reset kr
                });
              }
            },
            child: const Icon(Icons.navigate_before),
          ),
        ],
      ),
    );
  }
}
