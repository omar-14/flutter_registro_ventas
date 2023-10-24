import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const colorSeed = Color(0xff424CB8);
// const scaffoldBackgroundColor = Color(0xFFF8F7F7);

class AppTheme {
  final bool isDarkmode;

  AppTheme({this.isDarkmode = false});

  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      brightness: isDarkmode ? Brightness.dark : Brightness.light,
      colorSchemeSeed: colorSeed,
      // scaffoldBackgroundColor: scaffoldBackgroundColor,
      textTheme: TextTheme(
          titleLarge: GoogleFonts.montserratAlternates()
              .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
          titleMedium: GoogleFonts.montserratAlternates()
              .copyWith(fontSize: 30, fontWeight: FontWeight.bold),
          titleSmall:
              GoogleFonts.montserratAlternates().copyWith(fontSize: 20)),
      filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
              textStyle: MaterialStatePropertyAll(
                  GoogleFonts.montserratAlternates()
                      .copyWith(fontWeight: FontWeight.w700)))),

      ///* AppBar
      appBarTheme: AppBarTheme(
        // color: scaffoldBackgroundColor,
        titleTextStyle: GoogleFonts.montserratAlternates().copyWith(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: isDarkmode ? Colors.white : Colors.black),
      ));

  AppTheme copyWith({bool? isDarkmode}) =>
      AppTheme(isDarkmode: isDarkmode ?? this.isDarkmode);
}
