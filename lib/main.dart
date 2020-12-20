import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'service/calls_service.dart';
import 'ui/home_page.dart';
import 'ui/login_page.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

GetIt locator = GetIt();

void setupLocator() {
  locator.registerSingleton(CallsAndMessagesService());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: LoginPage.id,
        routes: {
          LoginPage.id: (context) => LoginPage(),
          '/list': (context) => HomePage()
        });
  }
}
