import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:plan_trips/Bloc/bloc/mainfunction_bloc.dart';
import 'package:plan_trips/Constants/Style.dart';
import 'package:plan_trips/Model/TripInfo.dart';
import 'package:plan_trips/Screens/BookedTrips.dart';
import 'package:plan_trips/Screens/Login.dart';
import 'package:plan_trips/Screens/SplashScreen.dart';
import 'package:plan_trips/Widget/ListViewCard.dart';
import 'package:plan_trips/Widget/LoadingScreen.dart';

import '../Constants/SizeConfig.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double hRatio = SizeConfig.heightRatio;
  double wRatio = SizeConfig.widthRatio;
  final bloc = new MainfunctionBloc();
  bool flagDomestic = false, flagNonDomestic = false;

  @override
  void initState() {
    bloc.add(getHomePageTripInfo());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        if (state is MainfunctionInitial || state is MainfunctionLoading) {
          return LoadingScreen();
        } else if (state is MainfunctionLoaded) {
          checkFlag(state.tripInfo);
          (state.tripInfo.list);
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                title: Text("Turer"),
                leadingWidth: 0,
                actions: [
                  GestureDetector(
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                          (route) => false);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: defaultColor),
                      margin: EdgeInsets.only(right: 15, top: 6, bottom: 6),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Log Out",
                        style: logOutButtonTextStyle,
                      ),
                    ),
                  )
                ],
                titleTextStyle: defaultHeading,
                backgroundColor: Colors.white,
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: wRatio * 3,
                          top: hRatio * 4,
                          bottom: hRatio * 1),
                      child: Text(
                        "Innenlandsturer",
                        style: defaultHeadingPages,
                      ),
                    ),
                    flagDomestic
                        ? SizedBox(
                            height: hRatio * 38,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.tripInfo.info.length,
                              itemBuilder: (context, index) {
                                return ListViewCard(
                                    state.tripInfo, index, true);
                              },
                            ))
                        : Container(
                            margin: EdgeInsets.only(
                                left: wRatio * 4,
                                bottom: wRatio * 20,
                                top: wRatio * 5),
                            child: Text(
                              "No Trips Available",
                              style: hintTextStyle,
                            ),
                          ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: wRatio * 3,
                          top: hRatio * 4,
                          bottom: hRatio * 1),
                      child: Text(
                        "Utenlandsturer",
                        style: defaultHeadingPages,
                      ),
                    ),
                    flagNonDomestic
                        ? SizedBox(
                            height: hRatio * 38,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.tripInfo.info.length,
                              itemBuilder: (context, index) {
                                return ListViewCard(
                                    state.tripInfo, index, false);
                              },
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.only(
                                left: wRatio * 4,
                                bottom: wRatio * 20,
                                top: wRatio * 5),
                            child: Text(
                              "No Trips Available",
                              style: hintTextStyle,
                            ),
                          ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BookedTrips(state.tripInfo)));
                      },
                      child: Container(
                        padding: EdgeInsets.all(wRatio * 4),
                        margin: EdgeInsets.only(
                            left: wRatio * 20,
                            right: wRatio * 20,
                            top: wRatio * 8),
                        decoration: BoxDecoration(
                            color: defaultColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Booked Trips",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: hRatio * 2.5,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: hRatio * 5,
                    )
                  ],
                ),
              ));
        } else {
          return Container();
        }
      },
    );
  }

  checkFlag(TripInfo tripInfo) {
    for (int i = 0; i < tripInfo.info.length; i++) {
      if (tripInfo.info[i].domestic) {
        if (flagNonDomestic) {
          flagDomestic = true;
          break;
        }
        flagDomestic = true;
      } else {
        if (flagNonDomestic) {
          flagDomestic = true;
          break;
        }
        flagNonDomestic = true;
      }
    }
  }
}
