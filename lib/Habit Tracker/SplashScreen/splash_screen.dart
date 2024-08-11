import 'dart:async';
import 'package:database/Habit%20Tracker/Controller/habitController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../View/homePage.dart';
import '../onBoardingScreen/on_boarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HabitController habitControllerFalse = Provider.of<HabitController>(context, listen: true);
    Timer(const Duration(seconds: 4), () {
      if (habitControllerFalse.isShow) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const OnBoardingScreen()));
      }
    });
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: height * 0.057,horizontal: width * 0.04),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('HABIT TRACKER & GOAL PLANNER',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: width * 0.036,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'montB')),
                Image.asset(
                  'assets/Images/img.png',
                  height: width * 0.33,
                ),
                Column(
                  children: [
                    Text('TICK IT!',
                        style: TextStyle(
                            fontSize: width * 0.068,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'montB')),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 0.9,horizontal: 6),
                            child: Text('LEAP',
                                style: TextStyle(
                                    fontSize: width * 0.03,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'montM'))),
                        const SizedBox(width: 8.5),
                        Text('FITNESS',
                            style: TextStyle(
                                fontSize: width * 0.03,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'montM'))
                      ],
                    ),
                    SizedBox(height: height * 0.04),
                    LinearProgressIndicator(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
