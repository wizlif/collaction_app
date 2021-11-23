import 'package:auto_route/auto_route.dart';
import 'package:collaction_app/application/splash/splash_bloc.dart';
import 'package:collaction_app/presentation/routes/app_routes.gr.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../themes/constants.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final PageController _imageController = PageController();
  final PageController _textController = PageController();
  double currentPage = 0;

  @override
  void initState() {
    super.initState();
    _imageController.addListener(() {
      if (_imageController.page != currentPage) {
        setState(() {
          currentPage = _imageController.page!;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).size.height > 700 ? 1.0 : 0.8;
    final imagePages = [
      Image.asset(
        'assets/images/onboarding_one.png',
        scale: scaleFactor != 1.0 ? scaleFactor * 1.5 : scaleFactor,
      ),
      Image.asset(
        'assets/images/onboarding_two.png',
        scale: scaleFactor != 1.0 ? scaleFactor * 1.5 : scaleFactor,
      ),
      Image.asset(
        'assets/images/onboarding_three.png',
        scale: scaleFactor != 1.0 ? scaleFactor * 1.5 : scaleFactor,
      ),
    ];
    final titlePages = [
      "Goal",
      "Crowd",
      "Action",
    ];
    final textPages = [
      "Choose or suggest a challenge you want to participate in",
      "See how your actions are amplified by a crowd with similar goals",
      "Commit to the challenge and make impact",
    ];

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 250.0,
                  width: MediaQuery.of(context).size.width,
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    controller: _imageController,
                    itemBuilder: (context, index) => imagePages[index],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height *
                (scaleFactor == 1.0 ? 0.45 : 0.46),
            width: double.infinity,
            /*decoration: const BoxDecoration(
                color: kAlmostTransparent,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0))),*/
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 5.0 * scaleFactor, horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 100.0 * (scaleFactor + 0.1),
                      width: MediaQuery.of(context).size.width - 50,
                      child: PageView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 3,
                        controller: _textController,
                        itemBuilder: (context, index) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              titlePages[index],
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 34.0 * scaleFactor,
                                  color: kPrimaryColor400),
                            ),
                            SizedBox(height: 25.0 * scaleFactor),
                            Text(
                              textPages[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 16.0 * scaleFactor,
                                color: kPrimaryColor300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 25.0 * scaleFactor),
                    DotsIndicator(
                      position: currentPage,
                      dotsCount: 3,
                      decorator: const DotsDecorator(
                          activeColor: kAccentColor,
                          color: kSecondaryTransparent,
                          size: Size(12, 12),
                          activeSize: Size(12, 12)),
                    ),
                    const SizedBox(height: 25.0),
                    Row(
                      children: [
                        Expanded(
                          child: FloatingActionButton(
                            child: const Icon(Icons.chevron_right),
                            onPressed: () =>
                                currentPage == 2.0 ? _getStarted() : nextPage(),
                          ),
                        ),
                      ],
                    ),
                    if (currentPage != 2)
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: _getStarted,
                              child: const Text(
                                "Skip",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kAccentColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      const SizedBox(
                        height: 50,
                      ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void nextPage() {
    _imageController.nextPage(
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
    _textController.nextPage(
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  void _getStarted() {
    context.read<SplashBloc>().add(
      const SplashEvent.setOnBoarding(
          isOnBoarded: true),
    );

    context.router.replaceAll([
      const HomeRoute()
    ]);
  }
}
