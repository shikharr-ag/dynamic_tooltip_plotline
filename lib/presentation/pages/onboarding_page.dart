import 'dart:developer';

import 'package:dynamic_tooltip_plotline/application/tooltip/onboarding_page_provider.dart';
import 'package:dynamic_tooltip_plotline/presentation/core/route_navigator.dart';
import 'package:dynamic_tooltip_plotline/presentation/pages/design_tooltip_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/style_elements.dart';

class OnboardingPage extends StatefulWidget {
  static const routeName = 'onboarding';
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  PageController ctrl = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<OnboardingStateProvider>(builder: (context, obprov, _) {
        return Stack(
          children: [
            PageView(
                controller: ctrl,
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: (val) {
                  log('page change called');
                  obprov.setCurrentIndex(val);
                },
                children: List.generate(
                    obprov.pages,
                    (index) => Container(
                          constraints: const BoxConstraints.expand(),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/gifs/${index + 1}.png'),
                            ),
                          ),
                        ))),

            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: ElevatedButton(
                  onPressed: () {
                    // obprov.setNextPage();
                    if (obprov.currentIndex == 2) {
                      RouteNavigator.navigateReplacementWithFade(
                          routeName: DesignTooltipPage.routeName,
                          context: context);
                    }
                    ctrl.nextPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.linear);
                    // ctrl
                    //     .animateToPage(obprov.currentIndex + 1,
                    //         duration: const Duration(milliseconds: 200),
                    //         curve: Curves.linear)
                    //     .then((value) {
                    //   log('Page Changed..NOW Call');
                    //   obprov.setCurrentIndex(obprov.currentIndex);
                    // });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: renderButtonColor,
                    shape: defaultElevatedButtonShape,
                  ),
                  child: Text(
                    obprov.currentIndex == 2 ? 'Lets dive in' : 'Next',
                    style: bodyMedium.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
            if (obprov.currentIndex > 0)
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // obprov.setNextPage();
                      ctrl.previousPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeIn);
                      // ctrl
                      //     .animateToPage(obprov.currentIndex - 1,
                      //         duration: const Duration(milliseconds: 200),
                      //         curve: Curves.easeIn)
                      //     .then((value) {
                      //   // log('Page Changed..NOW Call');
                      //   obprov.setCurrentIndex(obprov.currentIndex);
                      // });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: renderButtonColor,
                      shape: defaultElevatedButtonShape,
                    ),
                    child: Text(
                      obprov.currentIndex == 0 ? '' : 'Back',
                      style: bodyMedium.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Row(
            //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: List.generate(
            //       3,
            //       (index) => Container(
            //         constraints: BoxConstraints.tightFor(height: 10, width: 10),
            //         margin: EdgeInsets.symmetric(
            //             vertical: MediaQuery.of(context).size.height / 7,
            //             horizontal: 30),
            //         decoration: BoxDecoration(
            //             shape: BoxShape.circle, color: Colors.black),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        );
      }),
    );
  }
}
