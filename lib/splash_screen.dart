import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translens/const_color.dart';
import 'package:translens/onboard_screen.dart';

import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkOnboarding();
  }

  _checkOnboarding() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // bool onboardCompleted = prefs.getString('onboardScreen') == 'done';

    Future.delayed(Duration(seconds: 3), (){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>  OnboardScreen(),
        ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 59.0),
            child: SvgPicture.asset('assets/images/splash_screen_image.svg').animate()
                .fadeIn(duration: 1.seconds)
                .scale(delay: 500.ms, duration: 1.5.seconds)
                .shake(duration: 800.ms),
          )
        ],
      ),
    );
  }
}
