import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quiz_app/common/dummy%20data/dummy_data.dart';

import '../../common/constants/colors.dart';
import '../result/result.dart';

class Quiz extends StatefulWidget {
  Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> with SingleTickerProviderStateMixin {
  int questNum = 0;
  int result = 0;
  Color _color = AppColor().magenta; // starting color
  final _random = Random();
  bool? changeTS;

  TextStyle _style = const TextStyle(
      color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w300);

  TextStyle style1 = const TextStyle(
      color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600);

  @override
  void initState() {
    super.initState();
    changeStyle();

    _startColorAnimation();
  }

  void changeStyle() {
    Future.delayed(const Duration(milliseconds: 500)).then((_) {
      setState(() {
        _style = style1;
      });
    });
  }

  void _startColorAnimation() {
    Future.delayed(Duration(seconds: 1)).then((_) {
      setState(() {
        changeTS = true;

        // generate a random color
        _color = Color.fromRGBO(_random.nextInt(256), _random.nextInt(256),
            _random.nextInt(256), 1);
        _startColorAnimation(); // repeat the animation
      });
    });
  }

  resulting(String answer) {
    bool isLastQuestion = questNum + 1 == DummyData.questions.length;

    answer == DummyData.questions[questNum]['correct'] ? result++ : null;

    if (isLastQuestion) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Result(result: result)));
    } else {
      setState(() {
        questNum++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Center(
        child: Container(
          child: modelOfQuiz(),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: AppColor().magenta,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          print('tapped on the icon of leading ');
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: const CircleAvatar(
              radius: 12, backgroundImage: AssetImage('assets/icons/quiz.png')),
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
              return FittedBox(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 1500),
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(
                      bottom: 20, left: 8, right: 8, top: 10),
                  decoration: BoxDecoration(
                    color: _color,
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(seconds: 1),
                        curve: Curves.bounceInOut,
                        style: _style,
                        child: Text(
                          DummyData.questions[questNum]['question'],
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
        Expanded(
          child: ListView.builder(
            itemCount: DummyData.questions[questNum]['answer'].length,
            itemBuilder: (context, index) {
              return answerBox(DummyData.questions[questNum]['answer'][index]);
            },
          ),
        )
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
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }
}
