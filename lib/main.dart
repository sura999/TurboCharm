import 'package:flutter/material.dart';
import 'package:turbocharm/section.dart';
import 'package:turbocharm/shop/bottom_navbar.dart';
import 'package:turbocharm/shop/shop_login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Turbo Charm',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(14, 18, 14, 1),
        accentColor: Color.fromRGBO(29, 181, 29, 1),
        primaryColorLight: Color.fromRGBO(25, 25, 27, 1),
        backgroundColor: Color.fromRGBO(26, 26, 31, 1),
        secondaryHeaderColor: Colors.white,
        buttonColor: Color.fromRGBO(29, 181, 29, 1),
        cardColor: Colors.white,
        canvasColor: Color.fromRGBO(14, 18, 14, 1),
        fontFamily: "IBMPlexSans",
        textTheme: TextTheme(
          subtitle1: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 20,
          ),
          bodyText1: TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 17,
          ),
          bodyText2: TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 16,
          ),
        ),
      ),
      home: Section(),
      routes: {
        Section.routeName: (ctx) => Section(),
        ShopLoginScreen.routeName: (ctx) => ShopLoginScreen(),
        BottomNavbar.routeName: (ctx) => BottomNavbar(),
      },
    );
  }
}
