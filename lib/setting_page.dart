import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:translens/about_us_page.dart';
import 'package:translens/faq_page.dart';
import 'package:url_launcher/url_launcher.dart';

import 'const_color.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  final Uri _url = Uri.parse('https://play.google.com/store/apps/details?id=com.translens');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: blackBackgroundColor,
        title:  Text("Settings", style: TextStyle(
          fontFamily: 'SF-Regular',
          color: Color.fromRGBO(255, 240, 75, 1),
        ),),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              // height: 500,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromRGBO(19, 19, 20, 1),
                borderRadius: BorderRadius.circular(12)
              ),
              child: Column(
                children: [
                  InkWell(
                      onTap:_launchUrl,
                      child: buildIconRow(Icons.star, 'Rate')),
                  SizedBox(height: 18,),
                  InkWell(
                      onTap: (){
                        Share.share(
                          'Download Translens & Translate FREE\nhttps://play.google.com/store/apps/details?id=com.translens',
                          subject: 'Translens App',
                        );
                      },
                      child: buildIconRow(Icons.share, 'Share')),
                  SizedBox(height: 18,),
                  InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => FaqPage()));

                      },
                      child: buildIconRow(Icons.help, 'FAQ\'s')),
                  SizedBox(height: 18,),
                  InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsPage()));
                      },
                      child: buildIconRow(Icons.info, 'About us')),


                ],
              ),
            ),
            SizedBox(height: 15,),

            // ElevatedButton(
            //     onPressed: (){},
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Color.fromRGBO(255, 240, 75, 1),
            //       shape:  RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(12),
            //       ),
            //     ),
            //     child: Center(
            //       child:Text('CLEAR HISTORY', style: TextStyle(
            //         color: blackBackgroundColor,
            //         fontSize: 18,
            //         fontFamily: 'SF-Regular',
            //         fontWeight: FontWeight.w500,
            //       ),),
            //     ))
          ],
        ),
      ),
    );
  }

  Widget buildIconRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white),
        SizedBox(width: 18),
        Text(
          text,
          style: TextStyle(
            fontFamily: 'SF-Regular',
            fontSize: 20,
            color: backgroundColor,
          ),
        ),
      ],
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
