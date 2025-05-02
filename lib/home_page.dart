import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:language_detector/language_detector.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:translator/translator.dart';
import 'package:translens/dictionary_files/DictionaryHomePage.dart';
import 'package:translens/const_color.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:translens/favorite_list_page.dart';
import 'package:translens/setting_page.dart';
import 'models.dart';
import 'package:image_cropper/image_cropper.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FlutterTts _flutterTts = FlutterTts();
  TextEditingController _textController = TextEditingController();

  String _translatedText = "";
  String _fromLanguage = 'en';
  String _toLanguage = '';
  String _localId = '';


  String _topShowSelectedLanguage = 'English';
  String _showSelectedLanguage = '';

  File? _image;
  String _extractedText = "";
  final ImagePicker _picker = ImagePicker();

  final GoogleTranslator _translator = GoogleTranslator();

  bool _isLoading = false;
  bool _isLoading2 = false;
  bool _isLoading3 = false;

  bool _isLoadingForLike = false;
  bool _isLoadingForShare = false;


  bool isMicActive = false;

  SpeechToText speechToText = SpeechToText();
  bool isListening = false;
  String currentText = '';

  final List<LanguageModel> _languages = [
    LanguageModel(language: 'Afrikaans', code: 'af', codeForVoice: 'af-ZA'),
    LanguageModel(language: 'Albanian', code: 'sq', codeForVoice: 'sq-AL'),
    LanguageModel(language: 'Amharic', code: 'am', codeForVoice: 'am-ET'),
    LanguageModel(language: 'Arabic', code: 'ar', codeForVoice: 'ar-SA'),
    LanguageModel(language: 'Armenian', code: 'hy', codeForVoice: 'hy-AM'),
    LanguageModel(language: 'Assamese', code: 'as', codeForVoice: 'as-IN'),
    LanguageModel(language: 'Azerbaijani', code: 'az', codeForVoice: 'az-AZ'),
    LanguageModel(language: 'Basque', code: 'eu', codeForVoice: 'eu-ES'),
    LanguageModel(language: 'Belarusian', code: 'be', codeForVoice: 'be'),
    LanguageModel(language: 'Bengali', code: 'bn', codeForVoice: 'bn-IN'),
    LanguageModel(language: 'Bhojpuri', code: 'bho', codeForVoice: 'bho'),
    LanguageModel(language: 'Bosnian', code: 'bs', codeForVoice: 'bs-BA'),
    LanguageModel(language: 'Bulgarian', code: 'bg', codeForVoice: 'bg-BG'),
    LanguageModel(language: 'Catalan', code: 'ca', codeForVoice: 'ca-ES'),
    LanguageModel(language: 'Cebuano', code: 'ceb', codeForVoice: 'ceb'),
    LanguageModel(language: 'Chinese (Simplified)', code: 'zh-cn', codeForVoice: 'zh'),
    LanguageModel(language: 'Chinese (Traditional)', code: 'zh-tw', codeForVoice: 'zh-TW'),
    LanguageModel(language: 'Corsican', code: 'co', codeForVoice: 'co'),
    LanguageModel(language: 'Croatian', code: 'hr', codeForVoice: 'hr-HR'),
    LanguageModel(language: 'Czech', code: 'cs', codeForVoice: 'cs-CZ'),
    LanguageModel(language: 'Danish', code: 'da', codeForVoice: 'da-DK'),
    LanguageModel(language: 'Dhivehi', code: 'dv', codeForVoice: 'dv'),
    LanguageModel(language: 'Dogri', code: 'doi', codeForVoice: 'doi'),
    LanguageModel(language: 'Dutch', code: 'nl', codeForVoice: 'nl-NL'),
    LanguageModel(language: 'English', code: 'en', codeForVoice: 'en-US'),
    LanguageModel(language: 'Esperanto', code: 'eo', codeForVoice: 'eo'),
    LanguageModel(language: 'Estonian', code: 'et', codeForVoice: 'et-EE'),
    LanguageModel(language: 'Ewe', code: 'ee', codeForVoice: 'ee'),
    LanguageModel(
        language: 'Filipino (Tagalog)', code: 'fil', codeForVoice: 'fil-PH'),
    LanguageModel(language: 'Finnish', code: 'fi', codeForVoice: 'fi-FI'),
    LanguageModel(language: 'French', code: 'fr', codeForVoice: 'fr-FR'),
    LanguageModel(language: 'Frisian', code: 'fy', codeForVoice: 'fy'),
    LanguageModel(language: 'Galician', code: 'gl', codeForVoice: 'gl'),
    LanguageModel(language: 'Georgian', code: 'ka', codeForVoice: 'ka-GE'),
    LanguageModel(language: 'German', code: 'de', codeForVoice: 'de-DE'),
    LanguageModel(language: 'Greek', code: 'el', codeForVoice: 'el-GR'),
    LanguageModel(language: 'Guarani', code: 'gn', codeForVoice: 'gn'),
    LanguageModel(language: 'Gujarati', code: 'gu', codeForVoice: 'gu-IN'),
    LanguageModel(language: 'Haitian Creole', code: 'ht', codeForVoice: 'ht'),
    LanguageModel(language: 'Hausa', code: 'ha', codeForVoice: 'ha'),
    LanguageModel(language: 'Hawaiian', code: 'haw', codeForVoice: 'haw'),
    LanguageModel(language: 'Hebrew', code: 'iw', codeForVoice: 'he-IL'),
    LanguageModel(language: 'Hindi', code: 'hi', codeForVoice: 'hi-IN'),
    LanguageModel(language: 'Hmong', code: 'hmn', codeForVoice: 'hmn'),
    LanguageModel(language: 'Hungarian', code: 'hu', codeForVoice: 'hu-HU'),
    LanguageModel(language: 'Icelandic', code: 'is', codeForVoice: 'is-IS'),
    LanguageModel(language: 'Igbo', code: 'ig', codeForVoice: 'ig'),
    LanguageModel(language: 'Ilocano', code: 'ilo', codeForVoice: 'ilo'),
    LanguageModel(language: 'Indonesian', code: 'id', codeForVoice: 'id-ID'),
    LanguageModel(language: 'Irish', code: 'ga', codeForVoice: 'ga'),
    LanguageModel(language: 'Italian', code: 'it', codeForVoice: 'it-IT'),
    LanguageModel(language: 'Japanese', code: 'ja', codeForVoice: 'ja-JP'),
    LanguageModel(language: 'Javanese', code: 'jv', codeForVoice: 'jv'),
    LanguageModel(language: 'Kannada', code: 'kn', codeForVoice: 'kn-IN'),
    LanguageModel(language: 'Kazakh', code: 'kk', codeForVoice: 'kk-KZ'),
    LanguageModel(language: 'Khmer', code: 'km', codeForVoice: 'km-KH'),
    LanguageModel(language: 'Kinyarwanda', code: 'rw', codeForVoice: 'rw-RW'),
    // LanguageModel(language: 'Konkani', code: 'gom', codeForVoice: ''),
    LanguageModel(language: 'Korean', code: 'ko', codeForVoice: 'ko-KR'),
    // LanguageModel(language: 'Krio', code: 'kri', codeForVoice: ''),
    // LanguageModel(language: 'Kurdish (Kurmanji)', code: 'ku', codeForVoice: ''),
    // LanguageModel(language: 'Kurdish (Sorani)', code: 'ckb', codeForVoice: ''),
    // LanguageModel(language: 'Kyrgyz', code: 'ky', codeForVoice: ''),
    LanguageModel(language: 'Lao', code: 'lo', codeForVoice: 'lo-LA'),
    LanguageModel(language: 'Latin', code: 'la', codeForVoice: 'ss-Latn-ZA'),
    LanguageModel(language: 'Latvian', code: 'lv', codeForVoice: 'lv-LV'),
    // LanguageModel(language: 'Lingala', code: 'ln', codeForVoice: ''),
    LanguageModel(language: 'Lithuanian', code: 'lt', codeForVoice: 'lt-LT'),
    // LanguageModel(language: 'Luganda', code: 'lg', codeForVoice: ''),
    // LanguageModel(language: 'Luxembourgish', code: 'lb', codeForVoice: ''),
    LanguageModel(language: 'Macedonian', code: 'mk', codeForVoice: 'mk-MK'),
    // LanguageModel(language: 'Maithili', code: 'mai', codeForVoice: ''),
    // LanguageModel(language: 'Malagasy', code: 'mg', codeForVoice: ''),
    LanguageModel(language: 'Malay', code: 'ms', codeForVoice: 'ms-MY'),
    LanguageModel(language: 'Malayalam', code: 'ml', codeForVoice: 'ml-IN'),
    // LanguageModel(language: 'Maltese', code: 'mt', codeForVoice: ''),
    // LanguageModel(language: 'Maori', code: 'mi', codeForVoice: ''),
    LanguageModel(language: 'Marathi', code: 'mr', codeForVoice: 'mr-IN'),
    // LanguageModel(language: 'Meiteilon (Manipuri)', code: 'mni-mtei', codeForVoice: ''),
    // LanguageModel(language: 'Mizo', code: 'lus', codeForVoice: ''),
    // LanguageModel(language: 'Mongolian', code: 'mn', codeForVoice: ''),
    LanguageModel(language: 'Myanmar (Burmese)', code: 'my', codeForVoice: 'my-MM'),
    LanguageModel(language: 'Nepali', code: 'ne', codeForVoice: 'ne-NP'),
    LanguageModel(language: 'Norwegian', code: 'no', codeForVoice: 'nb-NO'),
    // LanguageModel(language: 'Nyanja (Chichewa)', code: 'ny', codeForVoice: ''),
    LanguageModel(language: 'Odia (Oriya)', code: 'or', codeForVoice: 'or-IN'),
    // LanguageModel(language: 'Oromo', code: 'om', codeForVoice: ''),
    // LanguageModel(language: 'Pashto', code: 'ps', codeForVoice: ''),
    LanguageModel(language: 'Persian', code: 'fa', codeForVoice: 'fa-IR'),
    LanguageModel(language: 'Polish', code: 'pl', codeForVoice: 'pl-PL'),
    LanguageModel(language: 'Portuguese', code: 'pt', codeForVoice: 'pt-PT'),
    LanguageModel(language: 'Punjabi', code: 'pa', codeForVoice: 'pa-IN'),
    // LanguageModel(language: 'Quechua', code: 'qu', codeForVoice: ''),
    LanguageModel(language: 'Romanian', code: 'ro', codeForVoice: 'ro-RO'),
    LanguageModel(language: 'Russian', code: 'ru', codeForVoice: 'ru-RU'),
    // LanguageModel(language: 'Samoan', code: 'sm', codeForVoice: ''),
    // LanguageModel(language: 'Sanskrit', code: 'sa', codeForVoice: ''),
    // LanguageModel(language: 'Scots Gaelic', code: 'gd', codeForVoice: ''),
    // LanguageModel(language: 'Sepedi', code: 'nso', codeForVoice: ''),
    LanguageModel(language: 'Serbian', code: 'sr', codeForVoice: 'sr-RS'),
    // LanguageModel(language: 'Sesotho', code: 'st', codeForVoice: ''),
    // LanguageModel(language: 'Shona', code: 'sn', codeForVoice: ''),
    // LanguageModel(language: 'Sindhi', code: 'sd', codeForVoice: ''),
    LanguageModel(language: 'Sinhala', code: 'si', codeForVoice: 'si-LK'),
    LanguageModel(language: 'Slovak', code: 'sk', codeForVoice: 'sk-SK'),
    LanguageModel(language: 'Slovenian', code: 'sl', codeForVoice: 'sl-SI'),
    // LanguageModel(language: 'Somali', code: 'so', codeForVoice: ''),
    LanguageModel(language: 'Spanish', code: 'es', codeForVoice: 'es-ES'),
    // LanguageModel(language: 'Sundanese', code: 'su', codeForVoice: ''),
    LanguageModel(language: 'Swahili', code: 'sw', codeForVoice: 'sw-KE'),
    LanguageModel(language: 'Swedish', code: 'sv', codeForVoice: 'sv-SE'),
    LanguageModel(
        language: 'Tagalog (Filipino)', code: 'tl', codeForVoice: 'fil-PH'),
    // LanguageModel(language: 'Tajik', code: 'tg', codeForVoice: ''),
    LanguageModel(language: 'Tamil', code: 'ta', codeForVoice: 'ta-IN'),
    // LanguageModel(language: 'Tatar', code: 'tt', codeForVoice: ''),
    LanguageModel(language: 'Telugu', code: 'te', codeForVoice: 'te-IN'),
    LanguageModel(language: 'Thai', code: 'th', codeForVoice: 'th-TH'),
    // LanguageModel(language: 'Tigrinya', code: 'ti', codeForVoice: ''),
    // LanguageModel(language: 'Tsonga', code: 'ts', codeForVoice: ''),
    LanguageModel(language: 'Turkish', code: 'tr', codeForVoice: 'tr-TR'),
    // LanguageModel(language: 'Turkmen', code: 'tk', codeForVoice: ''),
    // LanguageModel(language: 'Twi (Akan)', code: 'ak', codeForVoice: ''),
    LanguageModel(language: 'Ukrainian', code: 'uk', codeForVoice: 'uk-UA'),
    LanguageModel(language: 'Urdu', code: 'ur', codeForVoice: 'ur-PK'),
    // LanguageModel(language: 'Uyghur', code: 'ug', codeForVoice: ''),
    // LanguageModel(language: 'Uzbek', code: 'uz', codeForVoice: ''),
    LanguageModel(language: 'Vietnamese', code: 'vi', codeForVoice: 'vi-VN'),
    LanguageModel(language: 'Welsh', code: 'cy', codeForVoice: 'cy-GB'),
    // LanguageModel(language: 'Xhosa', code: 'xh', codeForVoice: ''),
    // LanguageModel(language: 'Yiddish', code: 'yi', codeForVoice: ''),
    // LanguageModel(language: 'Yoruba', code: 'yo', codeForVoice: ''),
    LanguageModel(language: 'Zulu', code: 'zu', codeForVoice: 'zu-ZA'),
  ];

  List<FavoriteListModel> _favoriteList = [];

  @override
  void initState() {
    super.initState();
    checkMic();
    _detectAndSpeakText();
  }

  void checkMic() async {
    bool micAvailable = await speechToText.initialize(
        onStatus: (status){
          if (status == 'notListening' || status == 'done') {
            setState(() {
              isListening = false;
              isMicActive = false;
            });
          }
        }
    );
    if (micAvailable) {
      print("MicroPhone Available");
    } else {
      print("User Denied the use of speech micro");
    }
  }


  Future<void> saveFavoriteList(FavoriteListModel item) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> favoriteList = prefs.getStringList('favoriteList') ?? [];

    favoriteList.add(item.toJson());

    await prefs.setStringList('favoriteList', favoriteList);
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: blackBackgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              children: [
                Container(
                  height: 562,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(255, 240, 75, 0.1),
                          Color.fromRGBO(217, 217, 217, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                      ),
                      color: Color.fromRGBO(19, 19, 20, 1),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(34),
                        bottomRight: Radius.circular(34),
                      )),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "TRAN",
                                      style: TextStyle(
                                        fontFamily: 'SF-Regular',
                                        color: Colors.transparent,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),

                                    Text(
                                      "TRANSLENS.",
                                      style: TextStyle(
                                        fontFamily: 'SF-Regular',
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => SettingPage()));
                                        },
                                        child: Icon(Icons.settings, color: Colors.white,))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 21,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 90),
                                child: Divider(
                                  color: Color.fromRGBO(142, 145, 143, 1),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              /// selected luanguage text
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  _topShowSelectedLanguage,
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 240, 75, 1),
                                    fontSize: 11,
                                    fontFamily: 'SF-Regular',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),

                              /// field
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 23.0),
                                child: TextField(
                                  onChanged: (text) {
                                    setState(() {});
                                  },
                                  controller: _textController,
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  style: TextStyle(
                                    color: Color.fromRGBO(227, 227, 227, 1),
                                    fontFamily: 'SF-Regular',
                                    fontSize: 32,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  cursorHeight: 32,
                                  cursorColor: Color.fromRGBO(142, 145, 143, 1),
                                  decoration: InputDecoration(
                                    suffixIcon: _textController.text.isNotEmpty
                                        ? IconButton(
                                            icon: const Icon(Icons.close,
                                                color: Colors.grey),
                                            onPressed: () {
                                              _textController.clear();
                                              _translatedText = '';
                                              setState(() {});
                                            },
                                          )
                                        : null,
                                    hintText: 'Enter Text',
                                    hintStyle: TextStyle(
                                        color: Color.fromRGBO(142, 145, 143, 1),
                                        fontFamily: 'SF-Regular',
                                        fontSize: 32,
                                        fontWeight: FontWeight.w400),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                ),
                              ),

                              if (_textController.text.isNotEmpty)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    InkWell(
                                      onTap: () async {
                                        setState(() {
                                          _isLoading = true;
                                        });

                                        await _detectAndSpeakText();

                                        setState(() {
                                          _isLoading = false;
                                        });
                                      },
                                      borderRadius: BorderRadius.circular(50),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                          height: 80,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          child: _isLoading
                                              ? Center(
                                            child: Container(
                                              height: 24,
                                              width: 24,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2,
                                              ),
                                            ),
                                          )
                                              : SvgPicture.asset(
                                            'assets/icons/volume1_icon.svg',
                                            height: 24,
                                            width: 24,
                                          ),
                                        ),
                                      ),
                                    ),

                                    InkWell(
                                      onTap: () {
                                        final value = ClipboardData(
                                            text: _textController.text);
                                        Clipboard.setData(value);
                                        _copySnackBar(context);
                                      },
                                      borderRadius: BorderRadius.circular(50),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                          height: 80,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          child: SvgPicture.asset(
                                            'assets/icons/copy_icon1.svg',
                                            height: 24,
                                            width: 24,
                                          ),
                                        ),
                                      ),
                                    ),


                                  ],
                                ),

                              if (_translatedText.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 90.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Divider(
                                          color: Color.fromRGBO(142, 145, 143, 1),
                                          thickness: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                        child: InkWell(
                                            onTap: (){
                                              setState(() {
                                                final tempText = _textController.text;
                                                final tempTranslated = _translatedText;
                                                final tempFrom = _fromLanguage;
                                                final tempTo = _toLanguage;
                                                final tempShowLang = _showSelectedLanguage;
                                                final tempTopShowLang = _topShowSelectedLanguage;

                                                _textController.text = tempTranslated;
                                                _translatedText = tempText;

                                                _fromLanguage = tempTo;
                                                _toLanguage = tempFrom;

                                                _showSelectedLanguage = tempTopShowLang;
                                                _topShowSelectedLanguage = tempShowLang;
                                              });
                                            },
                                            child: Icon(Icons.swap_calls_sharp, color: Colors.white)),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          color: Color.fromRGBO(142, 145, 143, 1),
                                          thickness: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  _showSelectedLanguage,
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 240, 75, 1),
                                    fontSize: 11,
                                    fontFamily: 'SF-Regular',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  _translatedText,
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 240, 75, 1),
                                    fontSize: 32,
                                    fontFamily: 'SF-Regular',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              if (_translatedText.isNotEmpty)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    /// volume icon
                                    InkWell(
                                      onTap: () async {
                                        setState(() {
                                          _isLoading2 = true;
                                        });
                                        await _detectAndSpeakText2();

                                        setState(() {
                                          _isLoading2 = false;
                                        });
                                      },
                                      borderRadius: BorderRadius.circular(50),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                          height: 80,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          child: _isLoading2
                                              ? Center(
                                            child: Container(
                                              height: 24,
                                              width: 24,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2,
                                              ),
                                            ),
                                          )
                                              : SvgPicture.asset(
                                            'assets/icons/volume2_iocn.svg',
                                            height: 24,
                                            width: 24,
                                          ),
                                        ),
                                      ),
                                    ),

                                    /// like icon
                                    InkWell(
                                      onTap: () async {

                                        setState(() {
                                          _isLoadingForLike = true;
                                        });

                                        FavoriteListModel newFavorite = FavoriteListModel(
                                          translatedText: _translatedText,
                                          enteredText: _textController.text,
                                          fromLanguage: _topShowSelectedLanguage,
                                          toLanguage: _showSelectedLanguage,
                                        );

                                        await saveFavoriteList(newFavorite);


                                        setState(() {
                                          _isLoadingForLike = false;
                                        });

                                        _fvrtSnackBar(context);
                                      },
                                      borderRadius: BorderRadius.circular(50),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                          height: 80,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          child: _isLoadingForLike
                                              ? Center(
                                            child: Container(
                                              height: 24,
                                              width: 24,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2,
                                              ),
                                            ),
                                          )
                                              : Icon(Icons.favorite_border,
                                            color: Color.fromRGBO(255, 240, 75, 1),
                                          )
                                        ),
                                      ),
                                    ),

                                    /// share icon
                                    InkWell(
                                      onTap: () async {
                                        setState(() {
                                          _isLoadingForShare = true;
                                        });

                                        Share.share(_translatedText);

                                        setState(() {
                                          _isLoadingForShare = false;
                                        });
                                      },
                                      borderRadius: BorderRadius.circular(50),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                          height: 80,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          child: _isLoadingForShare
                                              ? Center(
                                            child: Container(
                                              height: 24,
                                              width: 24,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2,
                                              ),
                                            ),
                                          )
                                              : Icon(Icons.share_outlined,
                                            color: Color.fromRGBO(255, 240, 75, 1),
                                          )
                                        ),
                                      ),
                                    ),

                                    /// copy icon
                                    InkWell(
                                      onTap: () {
                                        final value = ClipboardData(
                                            text: _translatedText);
                                        Clipboard.setData(value);
                                        _copySnackBar(context);
                                      },
                                      borderRadius: BorderRadius.circular(50),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                          height: 80,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          child: SvgPicture.asset(
                                            'assets/icons/copy_icon2.svg',
                                            height: 24,
                                            width: 24,
                                          ),
                                        ),
                                      ),
                                    ),

                                    // ///
                                    // InkWell(
                                    //   borderRadius: BorderRadius.circular(50),
                                    //   onTap: () async {
                                    //     setState(() {
                                    //       _isLoading2 = true;
                                    //     });
                                    //     await _detectAndSpeakText2();
                                    //
                                    //     setState(() {
                                    //       _isLoading2 = false;
                                    //     });
                                    //   },
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.symmetric(
                                    //         horizontal: 25.0),
                                    //     child: Container(
                                    //         height: 80,
                                    //         width: 30,
                                    //         child: _isLoading2
                                    //             ? Center(
                                    //                 child:
                                    //                     CircularProgressIndicator(
                                    //                 color: Colors.white,
                                    //               ))
                                    //             : SvgPicture.asset(
                                    //                 'assets/icons/volume2_iocn.svg')),
                                    //   ),
                                    // ),
                                    //
                                    // InkWell(
                                    //   borderRadius: BorderRadius.circular(50),
                                    //   onTap: () {
                                    //     final value = ClipboardData(
                                    //         text: _translatedText);
                                    //     Clipboard.setData(value);
                                    //     _copySnackBar(context);
                                    //   },
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.symmetric(
                                    //         horizontal: 25.0),
                                    //     child: Container(
                                    //         height: 80,
                                    //         width: 30,
                                    //         child: SvgPicture.asset(
                                    //             'assets/icons/copy_icon2.svg')),
                                    //   ),
                                    // ),
                                  ],
                                ),

                              // SizedBox(height: 190,),
                            ],
                          ),
                        ),
                      ),


                      /// paste and transcribe button row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              _paste();
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 22, vertical: 6),
                              height: 30,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(9, 9, 11, 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                  'Paste',
                                  style: TextStyle(
                                    fontFamily: 'SF-Regular',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: backgroundColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () async {
                              if (_toLanguage.isEmpty) {

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Please select the language you want to translate to.',
                                      style: TextStyle(
                                          fontFamily: 'SF-Regular',
                                          fontSize: 16, color: Color.fromRGBO(19, 19, 20, 1)),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    backgroundColor: Color.fromRGBO(255, 240, 75, 1),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              } else {
                                setState(() {
                                  _isLoading3 = true;
                                });
                                await _translateText();

                                setState(() {
                                  _isLoading3 = false;
                                });
                              }
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 6),
                              height: 30,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(9, 9, 11, 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: _isLoading3
                                    ? Center(
                                  child: Container(
                                    height: 17,
                                    width: 15,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                )
                                    : Text(
                                  'Transcribe',
                                  style: TextStyle(
                                    fontFamily: 'SF-Regular',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: backgroundColor,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 19,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),

                /// Language selecting containers row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _openFromLanguageSelectionBottomSheet,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 51,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(19, 19, 20, 1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            _topShowSelectedLanguage.isEmpty
                                ? 'Select Language'
                                : _topShowSelectedLanguage,
                            style: TextStyle(color: backgroundColor),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13.0),
                      child: SvgPicture.asset('assets/icons/divider_icon.svg'),
                    ),
                    GestureDetector(
                      onTap: _openLanguageSelectionBottomSheet,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 51,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(19, 19, 20, 1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            _showSelectedLanguage.isEmpty
                                ? 'Select Language'
                                : _showSelectedLanguage,
                            style: TextStyle(color: backgroundColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),


                /// camera and mic icon row
                Row(
                  mainAxisAlignment: isMicActive
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceEvenly,
                  children: [
                    if (!isMicActive)
                      InkWell(
                        onTap: _captureImage,
                        child: SvgPicture.asset('assets/icons/camera.svg'),
                      ),

                    GestureDetector(

                      onTap: () async{
                        if (!isListening) {
                          bool micAvailable = await speechToText.initialize(

                          );

                          if (micAvailable) {
                            setState(() {
                              isListening = true;
                              isMicActive = true;
                              currentText = _textController.text;
                            });
                            speechToText.listen(

                                localeId: _localId,
                                pauseFor: Duration(seconds: 120),
                                listenFor: Duration(minutes: 2),
                                onResult: (result) {
                                  setState(() {
                                    if (result.finalResult) {
                                      _textController.text = currentText + ' ' + result.recognizedWords;
                                      print("this is controller ${_textController.text}");
                                    }
                                    else {
                                      if (result.recognizedWords.isNotEmpty) {
                                        _textController.text = currentText + ' ' + result.recognizedWords;
                                      }
                                    }
                                  });
                                }
                            );
                          }
                        } else {
                          setState(() {
                            isListening = false;
                            isMicActive = false;
                            speechToText.stop();
                          });
                        }
                      },

                      child: AvatarGlow(
                        animate: isListening,
                        duration: Duration(milliseconds: 2000),
                        glowColor: isListening ? Colors.yellow : Color.fromRGBO(9, 9, 11, 1),
                        child:
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isListening ? Colors.yellow : Colors.transparent,

                          ),
                          child: Center(
                            child: isListening
                                ? SvgPicture.asset(
                              'assets/icons/mic_active.svg',
                              width: 40,
                              height: 40,
                            )
                                : SvgPicture.asset(
                              'assets/icons/audio_icon.svg',
                            ),
                          ),
                        ),
                      ),
                    ),

                    if (!isMicActive)
                      InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteListPage()));
                          },
                          child: Icon(Icons.favorite_border, color: Colors.white,)
                      ),
                    if (!isMicActive)
                      InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DictionaryHomePage()));
                      },
                        child: Icon(Icons.book_outlined, color: Colors.white,)),



                  ],

                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openLanguageSelectionBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          height: 529,
          decoration: BoxDecoration(
            color: Color.fromRGBO(19, 19, 20, 1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(17),
              topRight: Radius.circular(17),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  children: [
                    Text(
                      'Translate to',
                      style: TextStyle(
                        color: backgroundColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'SF-Regular',
                      ),
                    ),
                    SizedBox(height: 11),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60.0),
                      child: Divider(
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _languages.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _toLanguage = _languages[index].code!;
                          _showSelectedLanguage = _languages[index].language!;
                        });
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          _languages[index].language!,
                          style: TextStyle(
                            color: _toLanguage == _languages[index].code
                                ? Colors.yellow
                                : backgroundColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'SF-Regular',
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openFromLanguageSelectionBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          height: 529,
          decoration: BoxDecoration(
            color: Color.fromRGBO(19, 19, 20, 1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(17),
              topRight: Radius.circular(17),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  children: [
                    Text(
                      'Translate to',
                      style: TextStyle(
                        color: backgroundColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'SF-Regular',
                      ),
                    ),
                    SizedBox(height: 11),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60.0),
                      child: Divider(
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _languages.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _fromLanguage = _languages[index].code!;
                          _topShowSelectedLanguage = _languages[index].language;
                          _localId= _languages[index].codeForVoice;
                        });
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          _languages[index].language!,
                          style: TextStyle(
                            color: _fromLanguage == _languages[index].code
                                ? Colors.yellow
                                : backgroundColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'SF-Regular',
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _translateText() async {
    if (_textController.text.isNotEmpty) {
      var translation = await _translator.translate(_textController.text,
          from: _fromLanguage, to: _toLanguage);
      setState(() {
        _translatedText = translation.text;
      });
    }
  }

  Future<void> _captureImage() async {
    final XFile? capturedFile =
    await _picker.pickImage(source: ImageSource.camera);
    if (capturedFile != null) {
      final croppedFile = await _cropImage(File(capturedFile.path));
      if (croppedFile != null) {
        setState(() {
          _image = croppedFile;
        });
        _extractText();
      }
    }
  }

  Future<File?> _cropImage(File imageFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: CropAspectRatio(ratioX: 16, ratioY: 9),
      compressQuality: 90,
      compressFormat: ImageCompressFormat.jpg,
    );
    return croppedFile != null ? File(croppedFile.path) : null;
  }

  Future<void> _extractText() async {
    if (_image == null) return;

    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final InputImage inputImage = InputImage.fromFile(_image!);

    try {
      final RecognizedText recognizedText =
      await textRecognizer.processImage(inputImage);
      setState(() {
        _textController.text = recognizedText.text;
      });
    } catch (e) {
      print("Error: $e");
    } finally {
      textRecognizer.close();
    }
  }

  // Future<void> _captureImage() async {
  //   final XFile? capturedFile =
  //       await _picker.pickImage(source: ImageSource.camera);
  //   if (capturedFile != null) {
  //     setState(() {
  //       _image = File(capturedFile.path);
  //     });
  //     _extractText();
  //   }
  // }
  //
  // Future<void> _extractText() async {
  //   if (_image == null) return;
  //
  //   final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  //   final InputImage inputImage = InputImage.fromFile(_image!);
  //
  //   try {
  //     final RecognizedText recognizedText =
  //         await textRecognizer.processImage(inputImage);
  //     setState(() {
  //       _textController.text = recognizedText.text;
  //     });
  //   } catch (e) {
  //     print("Error: $e");
  //   } finally {
  //     textRecognizer.close();
  //   }
  // }

  Future<void> _detectAndSpeakText() async {
    String text = _textController.text;
    if (text.isEmpty) return;

    await _flutterTts.awaitSpeakCompletion(true);

    await _flutterTts.setEngine("com.google.android.tts");

    int result = await _flutterTts.setLanguage(_fromLanguage);
    if (result == 0) {
      print("Error: Language $_fromLanguage is not supported.");
      return;
    }

    await _flutterTts.speak(text);
  }

  Future<void> _detectAndSpeakText2() async {
    String text = _translatedText;
    if (text.isNotEmpty) {
      String detectedLanguage =
          await LanguageDetector.getLanguageCode(content: text);

      print("Detected Language: $detectedLanguage");

      if (detectedLanguage.trim().isEmpty) {
        print("Error: Could not detect language.");
        return;
      }

      List<String> availableLanguages =
          List<String>.from(await _flutterTts.getLanguages);
      print("Available TTS Languages: $availableLanguages");

      String matchedLanguage = availableLanguages.firstWhere(
        (lang) => lang.toLowerCase().contains(detectedLanguage.toLowerCase()),
        orElse: () => "en-US",
      );

      if (matchedLanguage.trim().isEmpty) {
        print(
            "Error: TTS does not support detected language: $detectedLanguage");
        return;
      }

      print("Using Matched Language: $matchedLanguage");

      await _flutterTts.setLanguage(matchedLanguage);
      await _flutterTts.awaitSpeakCompletion(true);
      await _flutterTts.speak(text);
    }
  }

  void _copySnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Text copied to clipboard",
          style: TextStyle(
              fontFamily: 'SF-Regular',
              fontSize: 16, color: Color.fromRGBO(19, 19, 20, 1)),
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        backgroundColor: Color.fromRGBO(255, 240, 75, 1),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _fvrtSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Text added to favourite list",
          style: TextStyle(
              fontFamily: 'SF-Regular',
              fontSize: 16, color: Color.fromRGBO(19, 19, 20, 1)),
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        backgroundColor: Color.fromRGBO(255, 240, 75, 1),
        duration: Duration(seconds: 1),
      ),
    );
  }


  _paste() async {
    final data = await Clipboard.getData('text/plain');
    if (data != null) {
      setState(() {
        _textController.text = data.text ?? '';
      });
    }
  }
}
