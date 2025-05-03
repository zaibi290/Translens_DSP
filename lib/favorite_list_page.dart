import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For storing data locally on device
import 'package:translens/const_color.dart'; // Custom color constants for consistent theme

import 'models.dart'; // Import the FavoriteListModel used to define each favorite entry

// This screen displays a list of favorite translations saved by the user
class FavoriteListPage extends StatefulWidget {
  const FavoriteListPage({super.key});

  @override
  State<FavoriteListPage> createState() => _FavoriteListPageState();
}

class _FavoriteListPageState extends State<FavoriteListPage> {

  // Holds the list of favorite items retrieved from local storage
  List<FavoriteListModel> _favoriteList = [];

  @override
  void initState() {
    super.initState();
    // Load the saved favorite list when the screen is first opened
    loadFavoriteList().then((list) {
      setState(() {
        _favoriteList = list;
      });
    });
  }

  // Fetches favorite data from SharedPreferences and converts it from JSON
  Future<List<FavoriteListModel>> loadFavoriteList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteListJson = prefs.getStringList('favoriteList');

    if (favoriteListJson != null) {
      // Converts each JSON string into a FavoriteListModel object
      return favoriteListJson.map((item) => FavoriteListModel.fromJson(item)).toList();
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blackBackgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: true, // Shows back arrow
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: blackBackgroundColor,
          title:  Text("Favorites", style: TextStyle(
            fontFamily: 'SF-Regular',
            color: Color.fromRGBO(255, 240, 75, 1),
          )),
        ),

        // Show the list if favorites exist, otherwise show empty message
        body: _favoriteList.isNotEmpty ?
        ListView.builder(
          itemCount: _favoriteList.length,
          itemBuilder: (context, index) {
            final item = _favoriteList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(255, 240, 75, 0.1), // Slight highlight
                          Color.fromRGBO(217, 217, 217, 0),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                      ),
                      color: Color.fromRGBO(19, 19, 20, 1), // Dark base
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        // Original language selected
                        Text(
                          item.fromLanguage,
                          style: TextStyle(
                            color: Color.fromRGBO(255, 240, 75, 1),
                            fontSize: 12,
                            fontFamily: 'SF-Regular',
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        // Text entered by user
                        Text(
                          item.enteredText,
                          style: TextStyle(
                            color: backgroundColor,
                            fontSize: 22,
                            fontFamily: 'SF-Regular',
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        SizedBox(height: 8),

                        // Target language selected
                        Text(
                          item.toLanguage,
                          style: TextStyle(
                            color: Color.fromRGBO(255, 240, 75, 1),
                            fontSize: 12,
                            fontFamily: 'SF-Regular',
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        // Translated output
                        Text(
                          item.translatedText,
                          style: TextStyle(
                            color: Color.fromRGBO(255, 240, 75, 1),
                            fontSize: 22,
                            fontFamily: 'SF-Regular',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                ],
              ),
            );
          },
        )

        // If there are no favorites, show a friendly empty state message
            : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.favorite_border,
                color: Color.fromRGBO(255, 240, 75, 1),
              ),
              SizedBox(height: 8),

              Text('No Favorites', style: TextStyle(
                  color: backgroundColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  fontFamily: 'SF-Regular'
              )),
              SizedBox(height: 10),

              Text(
                  'Tap the heart on any translation to add it to your favorites.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: backgroundColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'SF-Regular'
                  )),
            ],
          ),
        )
    );
  }
}
