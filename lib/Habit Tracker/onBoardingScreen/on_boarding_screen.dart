import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Controller/habitController.dart';
import '../View/homePage.dart';
import '../utils/habit_utils.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;
    PageController controller = PageController();
    HabitController habitControllerTrue =
    Provider.of<HabitController>(context, listen: true);
    HabitController habitControllerFalse =
    Provider.of<HabitController>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            PageView(
                controller: controller,
                onPageChanged: (index) {
                  habitControllerFalse.pageIndex(index);
                },
                children: [
                  buildPage(
                      height,
                      width,
                      'assets/Images/analysis.png',
                      'Stay Motivated',
                      'Create streaks of success for your habits and complete all your tasks. Use the charts and tools to deeply analyze your progress.',
                       width * 0.068
                  ),
                  buildPage(
                      height,
                      width,
                      'assets/Images/clipboard.png',
                      'Make Each Day Count',
                      'Every day, you will receive a list of all your scheduled activities. Make use of our customizable reminders to ensure you complete them all!',
                      width * 0.071
                  ),
                  buildPage(
                      height,
                      width,
                      'assets/Images/calendar.png',
                      'Build a Better Routine',
                      'To begin using HabitNow, start by recording the habits you want to track in your life along with your pending tasks.',0)
                ]),
            (habitControllerTrue.currentPage == 2)
                ? Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: const HomePage(),
                          type: PageTransitionType.rightToLeft));
                  habitControllerFalse.removeScreen();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: width * 0.0185, vertical: 15),
                  width: width * 0.28,
                  height: height * 0.068,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    'Start',
                    style: TextStyle(
                        fontFamily: 'montR',
                        color: Colors.white,
                        fontSize: width * 0.028,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            )
                : Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.0188, vertical: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.animateToPage(2,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                        habitControllerFalse.removeScreen();
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'montM',
                            fontSize: width * 0.021),
                      ),
                    ),
                    SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      onDotClicked: (index) {
                        habitControllerFalse.pageIndex(index);
                        controller.animateToPage(index,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      },
                      effect: WormEffect(
                          type: WormType.thin,
                          dotColor: Colors.white24,
                          activeDotColor: Colors.green),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      },
                      child: Text(
                        'Next',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'montM',
                            fontSize: width * 0.021),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

