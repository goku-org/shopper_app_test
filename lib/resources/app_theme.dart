
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopper_app/resources/app_colors.dart';

class AppTheme {
  final BuildContext context;

  AppTheme(this.context);

  ThemeData get lightTheme {
    return Theme.of(context).copyWith(
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: Theme.of(context).colorScheme.copyWith(
              background: AppColors.primaryColor,
              secondary: AppColors.accentColor,
              primary: AppColors.primaryColor,
              brightness: Brightness.light,
            ),
        textSelectionTheme: const TextSelectionThemeData(cursorColor: AppColors.primaryColor),
        errorColor: const Color(0xFFB00020),
        platform: defaultTargetPlatform,
        highlightColor: AppColors.accentColor.withOpacity(.5),
        primaryColor: AppColors.primaryColor,
        indicatorColor: AppColors.primaryColor,
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: AppColors.accentColor),
        unselectedWidgetColor: Colors.grey,
        brightness: Brightness.light,
        cardColor: const Color.fromRGBO(250, 250, 250, 1),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.grey.shade100,
          filled: true,
          alignLabelWithHint: true,
          hintStyle: Theme.of(context).textTheme.bodyText1,
          contentPadding: const EdgeInsets.all(15.0),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor, width: .3),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade100, width: .3),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade200),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: const Color(0xFFB00020).withOpacity(.5), width: .3),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              )),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFB00020), width: .3),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          labelStyle: Theme.of(context).textTheme.bodyText1,
          errorStyle:
              Theme.of(context).textTheme.bodyText2!.copyWith(color: const Color(0xFFB00020)),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        tabBarTheme: TabBarTheme(
          unselectedLabelColor: Colors.black.withOpacity(.5),
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(
              color: Colors.black, fontFamily: GoogleFonts.quicksand().fontFamily, fontSize: 18),
          bodyText2: TextStyle(color: Colors.black, fontFamily: GoogleFonts.quicksand().fontFamily),
          caption: TextStyle(color: Colors.black, fontFamily: GoogleFonts.quicksand().fontFamily),
          headline1: TextStyle(color: Colors.black, fontFamily: GoogleFonts.quicksand().fontFamily),
          headline2: TextStyle(color: Colors.black, fontFamily: GoogleFonts.quicksand().fontFamily),
          headline3: TextStyle(color: Colors.black, fontFamily: GoogleFonts.quicksand().fontFamily),
          headline4: TextStyle(color: Colors.black, fontFamily: GoogleFonts.quicksand().fontFamily),
          headline5: TextStyle(color: Colors.black, fontFamily: GoogleFonts.quicksand().fontFamily),
          headline6: TextStyle(color: Colors.black, fontFamily: GoogleFonts.notoSerif().fontFamily),
          subtitle1: TextStyle(color: Colors.black, fontFamily: GoogleFonts.quicksand().fontFamily),
          subtitle2: TextStyle(color: Colors.black, fontFamily: GoogleFonts.quicksand().fontFamily),
          overline: TextStyle(color: Colors.black, fontFamily: GoogleFonts.quicksand().fontFamily),
          button: TextStyle(color: Colors.black, fontFamily: GoogleFonts.quicksand().fontFamily),
        ),
        dividerColor: Colors.grey,
        appBarTheme: AppBarTheme(
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            color: AppColors.primaryColor,
            iconTheme: const IconThemeData(color: Colors.white),
            actionsIconTheme: const IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.notoSerif().fontFamily)));
  }
}
