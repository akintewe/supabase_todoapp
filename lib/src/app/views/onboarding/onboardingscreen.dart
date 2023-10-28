import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todoapp/src/app/views/onboarding/introPage1.dart';
import 'package:todoapp/src/app/views/onboarding/introPage3.dart';
import 'package:todoapp/src/app/views/onboarding/introPage4.dart';
import 'package:todoapp/src/app/views/onboarding/intropage2.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 315,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.white.withOpacity(0.5),
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: const Offset(0, 2))
                    ],
                    color: Colors.black,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: PageView(
                  controller: controller,
                  children: [
                    IntroPage1(controller: controller),
                    IntroPage2(
                      controller: controller,
                    ),
                    IntroPage3(
                      controller: controller,
                    ),
                    Intro4()
                  ],
                ),
              ),
              Positioned(
                bottom: 80,
                left: 155,
                child: SmoothPageIndicator(
                    controller: controller,
                    count: 4,
                    effect: ExpandingDotsEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      activeDotColor: Colors.grey,
                      dotColor: Colors.white,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
