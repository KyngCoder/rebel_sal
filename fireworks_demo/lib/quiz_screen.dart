import 'dart:async';
import 'package:fireworks_demo/const/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const blue = Color(0xFF4285F4);
const darkBlue = Color(0xFF0F9D58);
const lightgrey = Color(0xFFDDDDDD);
const ideas = "assets/images/ideas.png";

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  var currentQuestionIndex = 0;
  int seconds = 60;
  Timer? timer;

  int points = 0;

  var isLoaded = false;

  var optionsList = [];

  var optionsColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  final questionList = [
    {
      "type": "text",
      "content": "Who founded the Rebel Salute festival?",
      "options": [
        {"label": "A", "text": "Bob Marley"},
        {"label": "B", "text": "Sean Paul"},
        {"label": "C", "text": "Tony Rebel", "correct": true},
        {"label": "D", "text": "Peter Tosh"}
      ]
    },
    {
      "type": "image",
      "content": "Which artist is being featured here for the first time ?",
      "options": [
        {"label": "A", "image": "assets/images/sizzla.jpeg",},
        {"label": "B", "image": "assets/images/sean_paul.jpeg","correct": true},
        {
          "label": "C",
          "image": "assets/images/QueenIfrica.jpg",
        },
        {
          "label": "D",
          "image": "assets/images/anthony_b.jpeg",
        }
      ]
    },
     {
  "type": "text",
  "content": "How many years has the Rebel Salute festival been going on?",
  "options": [
    {"label": "A", "text": "15 years"},
    {"label": "B", "text": "20 years"},
    {"label": "C", "text": "25 years", },
    {"label": "D", "text": "30 years", "correct": true}
  ]
},
{
  "type": "image",
  "content": "Whom below is Capleton?",
  "options": [
    {"label": "A", "image": "assets/images/Capleton.jpeg", "correct": true},
    {"label": "B", "image": "assets/images/tony_rebel.jpeg"},
    {"label": "C", "image": "assets/images/Mutabaruka.jpeg"},
    {"label": "D", "image": "assets/images/sizzla.jpeg"}
  ]
},
{
  "type": "text",
  "content": "In which year was Herb Curb introduced?",
  "options": [
    {"label": "A", "text": "2010"},
    {"label": "B", "text": "2012"},
    {"label": "C", "text": "2016", "correct": true},
    {"label": "D", "text": "2018"}
  ]
}


  ];

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  resetColors() {
    optionsColor = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
    ];
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          gotoNextQuestion();
        }
      });
    });
  }

gotoNextQuestion() {
  isLoaded = false;
  resetColors();
  timer!.cancel();
  seconds = 60;

  if (currentQuestionIndex < questionList.length - 1) {
    currentQuestionIndex++;
    startTimer();
  } else {
    // If it's the last question, display the results dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quiz Completed'),
          content: Text('Your score: $points'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}


  @override
  Widget build(BuildContext context) {
    var dimension = MediaQuery.of(context).size;
    print("questions $questionList");
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [blue, darkBlue],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50,),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    normalText(color: Colors.white, size: 24, text: "$seconds"),
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: CircularProgressIndicator(
                        value: seconds / 60,
                        valueColor: const AlwaysStoppedAnimation(Colors.white),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                // Display question based on question type
                _displayQuestion(questionList[currentQuestionIndex]),
                const SizedBox(height: 20),
                // Display options based on question type
                _displayOptions(questionList[currentQuestionIndex]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _displayQuestion(Map<String, dynamic> question) {
    return SizedBox(
      width: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Question ${currentQuestionIndex + 1} of ${questionList.length}",
              style: TextStyle(color: lightgrey, fontSize: 18),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            question["content"],
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(height: 20),
          // Display image for image-based questions
          // if (question["type"] == "image")
          //   Image.asset(question["options"][0]["image"], width: 200),
        ],
      ),
    );
  }
Widget _displayOptions(Map<String, dynamic> question) {
  var options = question["options"] as List<Map<String, dynamic>>;
  var answer = options.firstWhere((option) => option["correct"] == true);

  return SizedBox(
    width: 500,
    child: GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // You can adjust the number of columns as needed
        mainAxisSpacing: 8.0, // Adjust the spacing between items vertically
        crossAxisSpacing: 8.0, // Adjust the spacing between items horizontally
      ),
      itemCount: options.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              // ... (your existing logic for checking the correct answer)

              // Display the correct answer after user selection
              optionsColor[index] = (options[index]["label"] == answer["label"])
                  ? Colors.green
                  : Colors.red;

                    // Increment points if the correct answer is chosen
              if (options[index]["correct"] == true) {
                points++;
              }


              if (currentQuestionIndex < questionList.length - 1) {
                Future.delayed(const Duration(seconds: 1), () {
                  gotoNextQuestion();
                });
              } else {
                timer!.cancel();
                // Display the correct answer after the last question
                optionsColor[options.indexWhere(
                    (option) => option["correct"] == true)] = Colors.green;

                // Here you can do whatever you want with the results
                // For example, display the user's score
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Quiz Completed'),
                      content: Text('Your score: $points'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Close the dialog and navigate to another screen if needed
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              }
            });
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            alignment: Alignment.center,
            width: 250,
           // Adjust the width of the grid items as needed
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: optionsColor[index],
              borderRadius: BorderRadius.circular(12),
            ),
            child: (question["type"] == "image")
                ? Image.asset(
                    options[index]["image"],
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Text(
                    options[index]["text"].toString(),
                    style: TextStyle(color: blue, fontSize: 18),
                  ),
          ),
        );
      },
    ),
  );
}


}
