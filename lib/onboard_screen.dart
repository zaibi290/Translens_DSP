import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:translens/const_color.dart';
import 'package:translens/home_page.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  bool isFinished = false;
  final GlobalKey<SlideActionState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000000),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              // height: 460,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFFF04B), // Yellow
                    Color(0xFF000000), // Black
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 45.0, left: 24),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "TRANSLENS.",
                    style: TextStyle(
                      fontFamily: 'SF-Regular',
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.only(left: 16.0),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         'THE NEXT BEST APP',
          //         style: TextStyle(
          //           fontSize: 20,
          //           fontWeight: FontWeight.w400,
          //           fontFamily: 'SF-Regular',
          //           color: backgroundColor,
          //         ),
          //       ),
          //       Row(
          //         children: [
          //           Text(
          //             'TRANSLATE',
          //             style: TextStyle(
          //               fontSize: 25,
          //               fontWeight: FontWeight.w700,
          //               fontFamily: 'SF-Regular',
          //               color: backgroundColor,
          //             ),
          //           ),
          //           SizedBox(
          //             width: 3,
          //           ),
          //           Text(
          //             'WITH CLARITY',
          //             style: TextStyle(
          //               fontSize: 25,
          //               fontWeight: FontWeight.w400,
          //               fontFamily: 'SF-Regular',
          //               color: backgroundColor,
          //             ),
          //           ),
          //         ],
          //       ),
          //       Row(
          //         children: [
          //           Text(
          //             'TRANSLENS',
          //             style: TextStyle(
          //                 fontSize: 25,
          //                 fontWeight: FontWeight.w700,
          //                 fontFamily: 'SF-Regular',
          //                 color: Color.fromRGBO(255, 240, 75, 1)),
          //           ),
          //           SizedBox(
          //             width: 3,
          //           ),
          //           Text(
          //             'WITH',
          //             style: TextStyle(
          //               fontSize: 25,
          //               fontWeight: FontWeight.w400,
          //               fontFamily: 'SF-Regular',
          //               color: backgroundColor,
          //             ),
          //           ),
          //         ],
          //       ),
          //       Text(
          //         'CONFIDENCE',
          //         style: TextStyle(
          //           fontSize: 25,
          //           fontWeight: FontWeight.w700,
          //           fontFamily: 'SF-Regular',
          //           color: backgroundColor,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      cursor: '',
                      'THE NEXT BEST APP',
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'SF-Regular',
                        color: backgroundColor,
                      ),
                      speed: Duration(milliseconds: 80),
                    ),
                  ],
                  totalRepeatCount: 1,
                ),
                SizedBox(height: 10),

                Row(
                  children: [
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          cursor: '',
                          'TRANSLATE',
                          textStyle: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'SF-Regular',
                            color: backgroundColor,
                          ),
                          speed: Duration(milliseconds: 50),
                        ),
                      ],
                      totalRepeatCount: 1,
                    ),
                    SizedBox(width: 3),
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          cursor: '',
                          'WITH CLARITY',
                          textStyle: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'SF-Regular',
                            color: backgroundColor,
                          ),
                          speed: Duration(milliseconds: 50),
                        ),
                      ],
                      totalRepeatCount: 1,
                    ),
                  ],
                ),
                SizedBox(height: 10),

                Row(
                  children: [
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          cursor: '',
                          'TRANSLENS',
                          textStyle: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'SF-Regular',
                            color: Color.fromRGBO(255, 240, 75, 1),
                          ),
                          speed: Duration(milliseconds: 50),
                        ),
                      ],
                      totalRepeatCount: 1,
                    ),
                    SizedBox(width: 3),
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          cursor: '',
                          'WITH',
                          textStyle: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'SF-Regular',
                            color: backgroundColor,
                          ),
                          speed: Duration(milliseconds: 50),
                        ),
                      ],
                      totalRepeatCount: 1,
                    ),
                  ],
                ),
                SizedBox(height: 10),

                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      cursor: '',
                      'CONFIDENCE',
                      textStyle: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'SF-Regular',
                        color: backgroundColor,
                      ),
                      speed: Duration(milliseconds: 50),
                    ),
                  ],
                  totalRepeatCount: 1,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: SvgPicture.asset('assets/icons/white_slider.svg'),
          ),

          SizedBox(
            height: 37,
          ),



          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SlideAction(
              key: _key,
              outerColor: Colors.yellow,
              innerColor: Colors.white,
              borderRadius: 12,
              sliderButtonIcon: Icon(
                Icons.arrow_forward,
                color: Colors.black,
              ),
              elevation: 0,
              sliderButtonYOffset: 0,
              animationDuration: Duration(milliseconds: 300),

              onSubmit: () {
                // Your action here
                Future.delayed(Duration(seconds: 1), () {
                  _key.currentState?.reset(); // Optional: Reset the slider
                });

                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
              },
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "GET TO ",
                      style: TextStyle(
                        color: Color.fromRGBO(19, 19, 20, 1),
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        fontFamily: 'SF-Regular'
                      ),
                    ),
                    TextSpan(
                      text: "TRANSLENSING",
                      style: TextStyle(
                        color: Color.fromRGBO(19, 19, 20, 1),
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                          fontFamily: 'SF-Regular'

                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // /// swipe button
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 35.0),
          //   child: Container(
          //     width: double.infinity,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10),
          //       border: Border.all(color: Colors.black),
          //     ),
          //     child: TextButton(onPressed: (){
          //             setState(() {
          //               isFinished = true;
          //             });
          //
          //
          //             Navigator.pushAndRemoveUntil(
          //               context,
          //               MaterialPageRoute(builder: (context) => HomePage()),
          //                 (route) => false
          //             );
          //
          //             // final SharedPreferences prefs = await SharedPreferences.getInstance();
          //             // await prefs.setString('onboardScreen', 'done');
          //             //
          //
          //             setState(() {
          //               isFinished = false;
          //             });
          //     }, child: Text("GET TO TRANSLENSING")),
          //     // child: ClipRect(
          //     //   child: SliderButton(
          //     //     action: () async {
          //     //       setState(() {
          //     //         isFinished = true;
          //     //       });
          //     //
          //     //
          //     //       Navigator.pushAndRemoveUntil(
          //     //         context,
          //     //         MaterialPageRoute(builder: (context) => HomePage()),
          //     //           (route) => false
          //     //       );
          //     //
          //     //       // final SharedPreferences prefs = await SharedPreferences.getInstance();
          //     //       // await prefs.setString('onboardScreen', 'done');
          //     //       //
          //     //
          //     //       setState(() {
          //     //         isFinished = false;
          //     //       });
          //     //     },
          //     //     label: Text(
          //     //       "GET TO TRANSLENSING",
          //     //       style: TextStyle(
          //     //         fontWeight: FontWeight.bold,
          //     //         fontSize: 16,
          //     //         color: Colors.black,
          //     //       ),
          //     //     ),
          //     //     icon: SvgPicture.asset('assets/icons/arrow.svg'),
          //     //     buttonColor: Colors.white,
          //     //     backgroundColor: Colors.yellow,
          //     //     shimmer: true,
          //     //     width: double.infinity,
          //     //     radius: 10,
          //     //   ),
          //     // ),
          //   ),
          // ),

          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
