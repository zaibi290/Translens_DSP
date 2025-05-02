// import 'package:api_integration/Dictionary%20App/dictionary_model.dart';
import 'package:flutter/material.dart';
import 'package:translens/dictionary_files/services.dart';

import '../const_color.dart';
import 'dictionary_model.dart';


class DictionaryHomePage extends StatefulWidget {
  const DictionaryHomePage({super.key});

  @override
  State<DictionaryHomePage> createState() => _DictionaryHomePageState();
}

class _DictionaryHomePageState extends State<DictionaryHomePage> {
  DictionaryModel? myDictionaryModel;
  bool isLoading = false;
  String noDataFound = "Now You Can Search";

  searchContain(String word) async {
    setState(() {
      isLoading = true;
    });
    try {
      myDictionaryModel = await APIservices.fetchData(word);
      setState(() {});
    } catch (e) {
      myDictionaryModel = null;
      noDataFound = "Meaning can't be found";
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: blackBackgroundColor,
        title:  Text("Dictionary", style: TextStyle(
          fontFamily: 'SF-Regular',
          color: Color.fromRGBO(255, 240, 75, 1),
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SearchBar(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              hintText: "Search for a word...",
              hintStyle: MaterialStateProperty.all(
                const TextStyle(color: Colors.grey, fontSize: 16),
              ),
              textStyle: MaterialStateProperty.all(
                const TextStyle(color: Colors.black),
              ),              onSubmitted: (value) {
                searchContain(value);
              },
            ),
            const SizedBox(height: 10),
            if (isLoading)
               LinearProgressIndicator(
                color: Color.fromRGBO(255, 240, 75, 1),
              )
            else if (myDictionaryModel != null)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Text(
                      myDictionaryModel!.word,
                      style: const TextStyle(
                        fontFamily: 'SF-Regular',
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Color.fromRGBO(255, 240, 75, 1),
                      ),
                    ),
                    Text(
                      myDictionaryModel!.phonetics.isNotEmpty
                          ? myDictionaryModel!.phonetics[0].text ?? ""
                          : "",

                      style: TextStyle(
                        color: backgroundColor
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: myDictionaryModel!.meanings.length,
                        itemBuilder: (context, index) {
                          return showMeaning(
                              myDictionaryModel!.meanings[index]);
                        },
                      ),
                    ),
                  ],
                ),
              )
            else
              Center(
                child: Text(
                  noDataFound,
                  style:  TextStyle(
                      fontFamily: 'SF-Regular',
                      fontSize: 18,
                    color: backgroundColor
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  showMeaning(Meaning meaning) {
    String wordDefination = "";
    for (var element in meaning.definitions) {
      int index = meaning.definitions.indexOf(element);
      wordDefination += "\n${index + 1}.${element.definition}\n";
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              meaning.partOfSpeech,
              style: const TextStyle(
                fontFamily: 'SF-Regular',
                fontWeight: FontWeight.w400,
                fontSize: 22,
                // color: Colors.blue,
                color: Color.fromRGBO(255, 240, 75, 1),

              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Definations : ",
              style: TextStyle(
                fontFamily: 'SF-Regular',
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: backgroundColor,
              ),
            ),
            Text(
              wordDefination,
              style:  TextStyle(
                fontFamily: 'SF-Regular',
                fontSize: 16,
                color: backgroundColor,
                height: 1,
              ),
            ),
            wordRelation("Synonyms", meaning.synonyms),
            wordRelation("Antonyms", meaning.antonyms),

          ],
        ),
      ),
    );
  }

  wordRelation(String title, List<String>? setList) {
    if (setList?.isNotEmpty ?? false) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title : ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: backgroundColor,
            ),
          ),
          Text(
            setList!.toSet().toString().replaceAll("{", "").replaceAll("}", ""),
            style:  TextStyle(fontSize: 18, color: backgroundColor),
          ),
          const SizedBox(height: 10),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}