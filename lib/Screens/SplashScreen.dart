import 'package:flutter/material.dart';
import 'package:plan_trips/Bloc/bloc/authentication_bloc.dart';
import 'package:plan_trips/Constants/SizeConfig.dart';
import 'package:plan_trips/Constants/Style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_trips/Screens/HomePage.dart';
import 'package:plan_trips/Screens/Login.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final bloc = new AuthenticationBloc();
  @override
  void initState() {
    super.initState();
    bloc.add(checkUser());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener(
        bloc: bloc,
        listener: (context, state) {
          if (state is AuthenticationLoaded) {
            if (state.statusCode == 200) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomePage()),
                (route) => false,
              );
            } else {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false,
              );
            }
          }
        },
        child: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            return Container(
              height: SizeConfig.heightRatio * 100,
              width: SizeConfig.widthRatio * 100,
              child: Image.asset(
                "assets/bus.jpg",
                fit: BoxFit.fill,
                color: defaultColor,
                colorBlendMode: BlendMode.modulate,
              ),
            );
          },
        ),
      ),
    );
  }
}
