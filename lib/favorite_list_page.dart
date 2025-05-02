import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translens/const_color.dart';

import 'models.dart';

class FavoriteListPage extends StatefulWidget {
  const FavoriteListPage({super.key});

  @override
  State<FavoriteListPage> createState() => _FavoriteListPageState();
}

class _FavoriteListPageState extends State<FavoriteListPage> {

  List<FavoriteListModel> _favoriteList = [];

  @override
  void initState() {
    super.initState();
    loadFavoriteList().then((list) {
      setState(() {
        _favoriteList = list;
      });
    });
  }

  Future<List<FavoriteListModel>> loadFavoriteList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteListJson = prefs.getStringList('favoriteList');

    if (favoriteListJson != null) {
      return favoriteListJson.map((item) => FavoriteListModel.fromJson(item)).toList();
    }
    return [];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: blackBackgroundColor,
        title:  Text("Favorites", style: TextStyle(
          fontFamily: 'SF-Regular',
          color: Color.fromRGBO(255, 240, 75, 1),
        ),),
      ),
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
                  // height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(255, 240, 75, 0.1),
                          Color.fromRGBO(217, 217, 217, 0),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                      ),
                      color: Color.fromRGBO(19, 19, 20, 1),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                        topRight: Radius.circular(8),
                        topLeft: Radius.circular(8),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      /// _selected Luang..
                      Text(
                        item.fromLanguage,
                        style: TextStyle(
                          color: Color.fromRGBO(255, 240, 75, 1),
                          fontSize: 12,
                          fontFamily: 'SF-Regular',
                          fontWeight: FontWeight.w400,
                        ),
                      ),


                      /// translate from
                      Text(
                        item.enteredText,
                        style: TextStyle(
                          color: backgroundColor,
                          fontSize: 22,
                          fontFamily: 'SF-Regular',
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      SizedBox(height: 8,),

                      /// to luang...
                      Text(
                        item.toLanguage,
                        style: TextStyle(
                          color: Color.fromRGBO(255, 240, 75, 1),
                          fontSize: 12,
                          fontFamily: 'SF-Regular',
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      /// translated text
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
                SizedBox(height: 12,),
              ],
            ),
          );
        },
      ) : Padding(
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
            ),),
            SizedBox(height: 10),

            Text('Tap the heart on any translation to add it to your favorites.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: backgroundColor,

                fontSize: 20,
                fontWeight: FontWeight.w300,
                fontFamily: 'SF-Regular'
            ),)

          ],
        ),
      )
    );
  }
}
