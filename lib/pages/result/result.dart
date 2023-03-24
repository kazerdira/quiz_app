import 'package:flutter/material.dart';
import 'package:quiz_app/common/constants/colors.dart';

class Result extends StatelessWidget {
  Result({Key? key, required this.result}) : super(key: key);

  final int result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TweenAnimationBuilder<Offset>(
        tween: Tween<Offset>(
          begin: const Offset(0, -1),
          end: Offset.zero,
        ),
        duration: const Duration(seconds: 1),
        builder: (BuildContext context, Offset offset, Widget? child) {
          return Transform.translate(
            offset: offset * MediaQuery.of(context).size.height / 2,
            child: Center(
              child: Text(
                '  your result is :  \n ${result.toString()}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor().indigo,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.repeat_outlined,
          color: AppColor().blueViolet,
          size: 16,
        ),
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/');
        },
      ),
    );
  }
}
