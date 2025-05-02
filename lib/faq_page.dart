import 'package:flutter/material.dart';
import 'package:translens/const_color.dart';

import 'models.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  List<FAQ> faq = [
    FAQ(questions: '1. How do I translate text using the app?', answers: 'To translate text, simply type or paste the text into the input box and select the language you want to translate to. Press the "Transcribe" button, and your translation will appear instantly.'),

    FAQ(questions: '2. Can I translate text from images?', answers: 'Yes! You can snap a picture of any text using the "Image Text Extraction" feature. The app will automatically extract the text from the image and translate it for you.'),

    FAQ(questions: '3. How does the voice translation feature work?', answers: 'To use voice translation, tap the microphone icon, say the word or phrase you want to translate, and the app will automatically convert your speech into text. Then, it will translate the text to your selected language.'),

    FAQ(questions: '4. Can I save my favorite translations?', answers: 'Absolutely! You can add any translation to your "Favorites" list by tapping the heart icon. This allows you to quickly access your favorite translations later.'),

    FAQ(questions: '5. Is there a limit to the number of translations I can perform?', answers: 'No, there’s no limit! You can translate as many texts or images as you want without any restrictions. Just keep using the app for as long as you need!'),
  ];

  int _expandedIndex = -1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackBackgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: blackBackgroundColor,
          title:  Text("FAQ\'s", style: TextStyle(
            fontFamily: 'SF-Regular',
            color: Color.fromRGBO(255, 240, 75, 1),
          ),),
        ),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14),
        child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: faq.length,
            itemBuilder: (BuildContext context, int index) {
              bool isExpanded = _expandedIndex == index;
              return Column(
                children: [
                  InkWell(
                    onTap: (){
                      setState(() {
                        _expandedIndex = isExpanded ? -1 : index;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 240, 75, 1),
                        borderRadius: BorderRadius.only(
                          bottomLeft: isExpanded ? Radius.zero : Radius.circular(10),
                          bottomRight: isExpanded ? Radius.zero : Radius.circular(10),
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(faq[index].questions, style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 17,
                                    fontFamily: 'SF-Regular',
                                    color: Colors.black
                                ),),
                              ),
                            ),

                            IconButton(
                              icon: isExpanded
                                  ? Image.asset('assets/icons/minus.png')
                                  : Image.asset('assets/icons/elements.png'),
                              onPressed: () {
                                setState(() {
                                  _expandedIndex = isExpanded ? -1 : index;
                                });
                              },
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(height: 10,),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 1),
                    curve: Curves.easeInOut,
                    child: isExpanded
                        ? Container(
                        padding: EdgeInsets.only(bottom: 15),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 28, right: 28, top: 10),
                          child: Text( faq[index].answers, style:
                          TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              fontFamily: 'SF-Regular',
                              color: Colors.black
                          )
                            ,),
                        )


                    )
                        : SizedBox.shrink(),
                  ),

                  SizedBox(height: 20,)
                ],
              );
            }
        ),
      )

    );
  }
}
