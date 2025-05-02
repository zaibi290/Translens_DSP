import 'package:flutter/material.dart';
import 'package:translens/const_color.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: blackBackgroundColor,
        title:  Text("About us", style: TextStyle(
          fontFamily: 'SF-Regular',
          color: Color.fromRGBO(255, 240, 75, 1),
        ),),
      ),


      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About Us',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SF-Regular',
                  color: backgroundColor,
                ),
              ),
              SizedBox(height: 10,),
              Text(
                'Welcome to Translens, your go-to app for seamless translations! We strive to make communication across languages effortless and accessible. Whether you\'re typing, speaking, or snapping a picture of text, Translens provides an easy and quick way to translate words and phrases in real time.\n\n'
                    'Our app is designed with a focus on user experience, offering three main features:\n\n'
                    '1. Text Translation: Type or paste text to translate instantly.\n'
                    '2. Image Text Extraction: Snap a picture and let Translens extract and translate the text for you.\n'
                    '3. Voice Translation: Speak the word or phrase and get a translation in your desired language.\n\n'
                    'Our goal is to break down language barriers, helping you connect with the world and communicate freely. With Translens, the world is at your fingertips.\n\n'
                    'We are constantly improving and adding new features to make your translation experience even better. Thank you for choosing Translens, and we hope to be a part of your language learning and communication journey!\n\n'
                    'Feel free to reach out if you have any questions or feedback—we are here to help!',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'SF-Regular',
                  color: Colors.white,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
