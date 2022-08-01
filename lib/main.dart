import 'package:calculator_app/constant/constants.dart';
import 'package:calculator_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: DarkColors.scaffoldBgColor));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

ThemeMode defaultThemeMode = ThemeMode.dark;

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: defaultThemeMode == ThemeMode.dark
          ? ChangeTheme.dark().gettheme()
          : ChangeTheme.light().gettheme(),
      home: CalculateScreen(
        togglethememodeLight: () {
          setState(() {
            defaultThemeMode = ThemeMode.light;
          });
        },
        togglethememodeDark: () {
          setState(() {
            defaultThemeMode = ThemeMode.dark;
          });
        },
      ),
    );
  }
}

class ChangeTheme {
  final Color primaryColor;
  final Color primarytextcolor;
  final Color backgroundcolor;
  final Color surfacecolor;
  final Brightness brightness;

  ChangeTheme.light()
      : brightness = Brightness.light,
        primarytextcolor = Colors.black,
        surfacecolor = LightColors.sheetBgColor,
        backgroundcolor = LightColors.scaffoldBgColor,
        primaryColor = LightColors.btnBgColor;
  ChangeTheme.dark()
      : brightness = Brightness.dark,
        primarytextcolor = Colors.white,
        surfacecolor = DarkColors.sheetBgColor,
        backgroundcolor = DarkColors.scaffoldBgColor,
        primaryColor = DarkColors.btnBgColor;
  ThemeData gettheme() {
    return ThemeData(
        brightness: brightness,
        scaffoldBackgroundColor: backgroundcolor,
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(primaryColor),
                minimumSize: MaterialStateProperty.all(Size(70, 70)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(color: Colors.transparent, width: 0))))),
        colorScheme: ColorScheme.dark(
            brightness: brightness,
            primary: primaryColor,
            background: backgroundcolor,
            surface: surfacecolor,
            onSurface: primarytextcolor),
        textTheme: TextTheme(
          headline6: TextStyle(color: primarytextcolor, fontSize: 60),
          bodyText1: TextStyle(
              color: primarytextcolor,
              fontWeight: FontWeight.bold,
              fontSize: 28),
          bodyText2: TextStyle(fontSize: 26),
        ));
  }
}
