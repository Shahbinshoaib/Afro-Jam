import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:afro_jam/splash_screen/splash_screen_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown,
          DeviceOrientation.portraitUp,
        ]);

    return MaterialApp(
      title: 'Afro Jam',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(primarySwatch: Colors.deepOrange,),
      debugShowCheckedModeBanner: true,
      home: SplashScreenWidget(),
    );
  }
}
