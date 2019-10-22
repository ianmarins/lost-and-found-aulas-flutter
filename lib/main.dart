import 'package:flutter/material.dart';
import 'package:lost_and_found/themes/theme.dart';
import 'package:lost_and_found/views/about_page.dart';
import 'package:lost_and_found/views/found_page.dart';
import 'package:lost_and_found/views/home_page.dart';
import 'package:lost_and_found/views/profile_page.dart';
import 'package:lost_and_found/views/root_page.dart';
import 'package:lost_and_found/views/sign_in_page.dart';
import 'package:lost_and_found/views/sign_up.page.dart';
import 'package:lost_and_found/views/use_term_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Achados e Perdidos',
      theme: myTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        SignInPage.routeName: (context) => new SignInPage(),
        SignUpPage.routeName: (context) => new SignUpPage(),
        HomePage.routeName: (context) => new HomePage(),
        AboutPage.routeName: (context) => new AboutPage(),
        ProfilePage.routeName: (context) => new ProfilePage(),
        UseTermPage.routeName: (context) => new UseTermPage(),
        FoundPage.routeName: (context) => new FoundPage(),
      },
      home: RootPage(),
    );
  }
}
