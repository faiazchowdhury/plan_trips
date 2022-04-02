import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plan_trips/Constants/Style.dart';
import 'package:plan_trips/Screens/Login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:plan_trips/Screens/SplashScreen.dart';

import 'Constants/SizeConfig.dart';
import 'Screens/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          SizeConfig(constraints.maxHeight, constraints.maxWidth);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          );
        }));
  }
}
