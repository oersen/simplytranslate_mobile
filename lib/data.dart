import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

const greyColor = Color(0xff131618);
const lightgreyColor = Color(0xff495057);
const secondgreyColor = Color(0xff212529);
const whiteColor = Color(0xfff5f6f7);
const greenColor = Color(0xff3fb274);
const lightThemeGreyColor = Color(0xffa9a9a9);

var boxDecorationCustomDark = BoxDecoration(
  color: greyColor,
  border: Border.all(
    color: lightgreyColor,
    width: 1.5,
    style: BorderStyle.solid,
  ),
  borderRadius: BorderRadius.circular(2),
);

var themeRadio = AppTheme.system;
var boxDecorationCustomLight = BoxDecoration(
    color: whiteColor,
    border: Border.all(
      color: lightThemeGreyColor,
      // color: Color(0xff3fb274),
      width: 1.5,
      style: BorderStyle.solid,
    ),
    borderRadius: BorderRadius.circular(2));

var boxDecorationCustomLightBlack = BoxDecoration(
    color: whiteColor,
    border: Border.all(
      color: lightThemeGreyColor,
      width: 1.5,
      style: BorderStyle.solid,
    ),
    borderRadius: BorderRadius.circular(2));

var focus = FocusNode();

String fromLanguageValue = 'English';
String toLanguageValue = 'Arabic';

String fromLanguage = '';
String toLanguage = '';

String instance = 'https://simplytranslate.org';
int instanceIndex = 0;

String translationInput = '';
String googleTranslationOutput = '';
String libreTranslationOutput = '';

String customInstance = '';
String customUrl = '';

bool translationInputOpen = false;

// int translationInputController.text.length = 0;

enum TranslateEngine { GoogleTranslate, LibreTranslate }

enum AppTheme { dark, light, system }

var themeValue = '';

Brightness theme = SchedulerBinding.instance!.window.platformBrightness;

enum customInstanceValidation { False, True, NotChecked }

bool isThereLibreTranslate = false;

const methodChannel = MethodChannel('com.simplytranslate/translate');

bool isClipboardEmpty = true;

checkLibreTranslatewithRespone(response, {setState}) {
  if (parse(response.body)
      .getElementsByTagName('a')[1]
      .innerHtml
      .contains('LibreTranslate')) {
    if (setState != null)
      setState(() => isThereLibreTranslate = true);
    else
      isThereLibreTranslate = true;
  } else {
    if (setState != null)
      setState(() => isThereLibreTranslate = false);
    else
      isThereLibreTranslate = false;
  }
}

checkLibreTranslate(setStateCustom) async {
  final url;
  if (instance == 'custom') {
    customInstance = customUrlController.text;
    url = Uri.parse('customInstance?engine:$engineSelected');
  } else if (instance == 'random') {
    url = Uri.https(
        instances[instanceIndex].substring(8), '/', {'engine': engineSelected});
  } else
    url = Uri.https(
        instance.toString().substring(8), '/', {'engine': engineSelected});
  // default https://
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      checkLibreTranslatewithRespone(response, setState: setStateCustom);
    }
  } catch (err) {}
}

Map selectLanguagesMap = {};
Map fromSelectLanguagesMap = {};
List selectLanguages = [];
List selectLanguagesFrom = [];

bool loading = false;

final customUrlController = TextEditingController();
final translationInputController = TextEditingController();

final session = GetStorage();

String engineSelected = 'google';

var instances = [
  "https://simplytranslate.org",
  "https://st.alefvanoon.xyz",
];

var supportedLanguages = [
  "Afrikaans",
  "Albanian",
  "Amharic",
  "Arabic",
  "Armenian",
  "Azerbaijani",
  "Basque",
  "Belarusian",
  "Bengali",
  "Bosnian",
  "Bulgarian",
  "Catalan",
  "Cebuano",
  "Chichewa",
  "Chinese",
  "Corsican",
  "Croatian",
  "Czech",
  "Danish",
  "Dutch",
  "English",
  "Esperanto",
  "Estonian",
  "Filipino",
  "Finnish",
  "French",
  "Frisian",
  "Galician",
  "Georgian",
  "German",
  "Greek",
  "Gujarati",
  "Haitian Creole",
  "Hausa",
  "Hawaiian",
  "Hebrew",
  "Hindi",
  "Hmong",
  "Hungarian",
  "Icelandic",
  "Igbo",
  "Indonesian",
  "Irish",
  "Italian",
  "Japanese",
  "Javanese",
  "Kannada",
  "Kazakh",
  "Khmer",
  "Kinyarwanda",
  "Korean",
  "Kurdish (Kurmanji)",
  "Kyrgyz",
  "Lao",
  "Latin",
  "Latvian",
  "Lithuanian",
  "Luxembourgish",
  "Macedonian",
  "Malagasy",
  "Malay",
  "Malayalam",
  "Maltese",
  "Maori",
  "Marathi",
  "Mongolian",
  "Myanmar (Burmese)",
  "Nepali",
  "Norwegian",
  "Odia (Oriya)",
  "Pashto",
  "Persian",
  "Polish",
  "Portuguese",
  "Punjabi",
  "Romanian",
  "Russian",
  "Samoan",
  "Scots Gaelic",
  "Serbian",
  "Sesotho",
  "Shona",
  "Sindhi",
  "Sinhala",
  "Slovak",
  "Slovenian",
  "Somali",
  "Spanish",
  "Sundanese",
  "Swahili",
  "Swedish",
  "Tajik",
  "Tamil",
  "Tatar",
  "Telugu",
  "Thai",
  "Turkish",
  "Turkmen",
  "Ukrainian",
  "Urdu",
  "Uyghur",
  "Uzbek",
  "Vietnamese",
  "Welsh",
  "Xhosa",
  "Yiddish",
  "Yoruba",
  "Zulu"
];
