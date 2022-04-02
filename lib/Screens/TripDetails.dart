import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:plan_trips/Bloc/bloc/mainfunction_bloc.dart';
import 'package:plan_trips/Constants/Style.dart';
import 'package:plan_trips/Model/TripInfo.dart';
import 'package:plan_trips/Widget/Toast.dart';

import '../Constants/SizeConfig.dart';

class TripDetails extends StatefulWidget {
  final SingleTripInfo temp;
  final List bookedTrips;
  TripDetails(this.temp, this.bookedTrips);

  @override
  State<StatefulWidget> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  double hRatio = SizeConfig.heightRatio;
  double wRatio = SizeConfig.widthRatio;
  final pageViewController = new PageController();
  int currentDay = 1;
  final bloc = new MainfunctionBloc();
  bool flag;

  @override
  void initState() {
    flag = checkBooked(widget.temp, widget.bookedTrips);
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var temp = widget.temp;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Image.network(
                temp.imageUrl,
                errorBuilder: (context, object, stackTrace) {
                  return Image.asset(
                    "assets/Error Images.png",
                    width: wRatio * 100,
                    fit: BoxFit.cover,
                  );
                },
              ),
              Positioned(
                bottom: -1,
                child: Container(
                  width: wRatio * 100,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30))),
                ),
              ),
              Positioned(
                top: 40,
                left: 30,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: defaultColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ]),
            Container(
              width: wRatio * 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(15))),
              child: SingleChildScrollView(
                  child: Padding(
                padding:
                    EdgeInsets.fromLTRB(wRatio * 5, 0, wRatio * 5, wRatio * 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          color: Color.fromRGBO(180, 180, 180, 1),
                        ),
                        SizedBox(
                          width: wRatio * 2,
                        ),
                        Text(
                          "${temp.startDate} - ${temp.endDate}",
                          style: defaultText,
                        )
                      ],
                    ),
                    SizedBox(
                      height: hRatio * 2,
                    ),
                    Text(
                      temp.name,
                      style: defaultHeadingPages,
                    ),
                    Text(
                      temp.tagLine,
                      style: hintTextStyle,
                    ),
                    SizedBox(
                      height: hRatio * 2,
                    ),
                    Container(
                      height: 1,
                      width: wRatio * 100,
                      color: Color.fromRGBO(200, 200, 200, 1),
                    ),
                    SizedBox(
                      height: hRatio * 2,
                    ),
                    Text(
                      temp.desc,
                      style: defaultText,
                    ),
                    SizedBox(
                      height: hRatio * 3,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Program",
                          style: pageViewHeadingTextStyle,
                        ),
                        Text(
                          "Dag $currentDay av ${temp.days}",
                          style: pageViewHeadingTextStyleWithColor,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: hRatio * 1.5,
                    ),
                    Container(
                      height: 1,
                      width: wRatio * 100,
                      color: Color.fromRGBO(200, 200, 200, 1),
                    ),
                    SizedBox(
                      height: hRatio * 1.5,
                    ),
                    SizedBox(
                      height: hRatio * 50,
                      child: PageView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          controller: pageViewController,
                          itemCount: temp.dayList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      temp.dayList[index].imageurl,
                                      width: wRatio * 100,
                                      height: hRatio * 25,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, object, stackTrace) {
                                        return Image.asset(
                                          "assets/Error Images.png",
                                          width: wRatio * 100,
                                          height: hRatio * 25,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: hRatio * 1.5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "dag $currentDay",
                                        style: pageViewDayTextStyle,
                                      ),
                                      Text(
                                        "${DateFormat.MMMMEEEEd().format(DateFormat('dd/MM/yy').parse(temp.startDate).add(Duration(days: currentDay - 1)))}",
                                        style: pageViewDayHintTextStyle,
                                      ),
                                      Text(temp.dayList[index].time,
                                          style: pageViewDayHintTextStyle)
                                    ],
                                  ),
                                  SizedBox(
                                    height: hRatio * 1.5,
                                  ),
                                  Text(
                                    temp.dayList[index].desc,
                                    style: defaultText,
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: hRatio * 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (currentDay != 1) {
                              setState(() {
                                currentDay--;
                              });
                              pageViewController.previousPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            }
                          },
                          child: Row(children: [
                            Icon(
                              Icons.arrow_back_ios,
                              color: currentDay != 1
                                  ? defaultColor
                                  : Color.fromRGBO(200, 200, 200, 1),
                            ),
                            Text(
                              "Forrige dag",
                              style: currentDay != 1
                                  ? hintTextStyleWithColor
                                  : hintTextStyle,
                            ),
                          ]),
                        ),
                        SizedBox(
                          width: wRatio * 2,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (currentDay != int.parse(temp.days)) {
                              setState(() {
                                currentDay++;
                              });
                              pageViewController.nextPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            }
                          },
                          child: Row(
                            children: [
                              Text(
                                "Neste dag",
                                style: currentDay != int.parse(temp.days)
                                    ? hintTextStyleWithColor
                                    : hintTextStyle,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: currentDay != int.parse(temp.days)
                                    ? defaultColor
                                    : Color.fromRGBO(200, 200, 200, 1),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: hRatio * 4,
                    ),
                    BlocProvider(
                      create: (context) => bloc,
                      child: BlocListener(
                        bloc: bloc,
                        listener: (context, state) {
                          if (state is MainfunctionLoadedWithoutResponse) {
                            if (state.statusCode != 400) {
                              setState(() {
                                flag = checkBooked(temp, widget.bookedTrips);
                              });
                              state.statusCode == 200
                                  ? Tost("Trip successfully booked!", context)
                                      .showToast()
                                  : Tost("Trip cancelled!", context)
                                      .showToast();
                            } else {
                              Tost("Something went wrong!", context)
                                  .showErrorToast();
                            }
                          }
                        },
                        child: BlocBuilder(
                            bloc: bloc,
                            builder: (context, state) {
                              if (state is MainfunctionInitial ||
                                  state is MainfunctionLoadedWithoutResponse) {
                                return button(temp.id);
                              } else {
                                return Container(
                                    padding: EdgeInsets.only(
                                        top: wRatio * 4, bottom: wRatio * 4),
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator());
                              }
                            }),
                      ),
                    ),
                    SizedBox(
                      height: hRatio * 6,
                    ),
                  ],
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }

  button(String id) {
    return TextButton(
        onPressed: () {
          if (!flag) {
            ("add");
            bloc.add(addTrip(widget.bookedTrips, id));
          } else {
            ("object hererem");
            bloc.add(removeTrip(widget.bookedTrips, id));
          }
        },
        style: ButtonStyle(
            padding: MaterialStateProperty.all(
                EdgeInsets.only(top: wRatio * 4, bottom: wRatio * 4)),
            minimumSize: MaterialStateProperty.all(Size(wRatio * 90, 00)),
            backgroundColor:
                MaterialStateProperty.all(Color.fromARGB(255, 164, 40, 40))),
        child: Text(
          flag ? "Cancel" : "Book Na",
          style: TextStyle(color: Colors.white, fontSize: hRatio * 2.5),
        ));
  }

  bool checkBooked(SingleTripInfo temp, List bookedTrips) {
    bool flag = false;
    for (int i = 0; i < bookedTrips.length; i++) {
      if (bookedTrips[i] == temp.id) {
        flag = true;
        break;
      }
    }
    return flag;
  }
}
