import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quiz_app/common/constants/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Quiz(),
    );
  }
}

class Quiz extends StatefulWidget {
  Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> with SingleTickerProviderStateMixin {
  int questNum = 0;
  int result = 0;
  Color _color = Colors.red; // starting color
  final _random = Random();

  @override
  void initState() {
    super.initState();
    _startColorAnimation();
  }

  void _startColorAnimation() {
    Future.delayed(Duration(seconds: 1)).then((_) {
      setState(() {
        // generate a random color
        _color = Color.fromRGBO(_random.nextInt(256), _random.nextInt(256),
            _random.nextInt(256), 1);
        _startColorAnimation(); // repeat the animation
      });
    });
  }

  final List questions = [
    {
      'question': 'ou est aokas ?',
      'answer': ['Bejaia', 'setif', 'tindouf'],
      'correct': 'Bejaia'
    },
    {
      'question': 'qui est le plus grand pays ?',
      'answer': ['algerie', 'usa', 'russie'],
      'correct': 'russie'
    },
    {
      'question': 'qui est la voiture la plus vendu au monde  ?',
      'answer': ['bmw', 'toyota', 'volvo'],
      'correct': 'toyota'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor().magenta,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            print('tapped on the icon of leading ');
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            child: const CircleAvatar(
                radius: 12,
                backgroundImage: AssetImage('assets/icons/quiz.png')),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Quiz app',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.5),
        ),
      ),
      body: Center(
        child: Container(
          child: modelOfQuiz(),
        ),
      ),
    );
  }

  Column modelOfQuiz() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TweenAnimationBuilder(
            tween: ColorTween(begin: _color, end: _color.withOpacity(0.7)),
            duration: Duration(milliseconds: 1500),
            curve: Curves.easeInOut,
            builder: (_, color, child) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 1500),
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(bottom: 60),
                decoration: BoxDecoration(
                    color: _color,
                    //   gradient: ,
                    /* LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColor().deepPink.withOpacity(0.5),
                    AppColor().blueViolet.withOpacity(0.8),
                    AppColor().indigo..withOpacity(0.8),
                  ]), */
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(80))),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                      child: Text(
                        questions[questNum]['question'],
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              );
            }),
        ...List.generate(questions[questNum]['answer'].length,
            (index) => answerBox(questions[questNum]['answer'][index]))
        /* answerBox(answers[0]),
        answerBox(answers[1]),
        answerBox(answers[2]), */
      ],
    );
  }

  GestureDetector answerBox(
    String answer,
  ) {
    return GestureDetector(
      onTap: () {
        resulting(answer);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            border: Border.all(color: AppColor().dodgerBlue, width: 1.5),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColor().skyBlue, AppColor().turquoise])),
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(20),
        height: 80,
        width: 280,
        child: Center(
          child: Text(
            answer,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  resulting(String answer) {
    bool isLastQuestion = questNum + 1 == questions.length;

    answer == questions[questNum]['correct'] ? result++ : null;

    if (isLastQuestion) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Result(result: result)));
    } else {
      setState(() {
        questNum++;
      });
    }
  }
}

class Result extends StatelessWidget {
  Result({super.key, required this.result});

  final int result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(result.toString()),
      ),
    );
  }
}
