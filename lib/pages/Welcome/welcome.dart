import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/common/constants/colors.dart';
import 'package:quiz_app/pages/quiz/quiz.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().cornflowerBlue.withOpacity(.6),
      body: AnimatedBackground(
        vsync: this,
        behaviour: RandomParticleBehaviour(
          options: const ParticleOptions(
            spawnMaxRadius: 30,
            spawnMinSpeed: 8.00,
            particleCount: 65,
            spawnMaxSpeed: 40,
            minOpacity: 0.3,
            spawnOpacity: 0.4,
            baseColor: Colors.blue,
            image: Image(image: AssetImage('assets/icons/brain.png')),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'are you ready to check your geography ?',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Quiz(),
                      ));
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  width:
                      double.infinity, // to stretch the container horizontally
                  height: 60, // adjust as needed
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        30), // to make the container round
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xff7982DB), // a shade of blue
                        Color(0xffD497E8), // a shade of rose
                        Color(0xffFFB8B8), // a lighter shade of rose
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Let's start",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
