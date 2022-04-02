import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plan_trips/Constants/Style.dart';
import 'package:plan_trips/Model/TripInfo.dart';
import 'package:plan_trips/Screens/TripDetails.dart';

import '../Constants/SizeConfig.dart';

class BookedTrips extends StatefulWidget {
  final TripInfo tripInfo;
  BookedTrips(this.tripInfo);

  @override
  State<StatefulWidget> createState() => _BookedTripsState();
}

class _BookedTripsState extends State<BookedTrips> {
  double hRatio = SizeConfig.heightRatio;
  double wRatio = SizeConfig.widthRatio;
  List<dynamic> bookedTrips;
  List<SingleTripInfo> temp;

  @override
  void initState() {
    temp = widget.tripInfo.info;
    bookedTrips = widget.tripInfo.list;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
            onTap: (() {
              Navigator.pop(context);
            }),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            )),
        title: Text("Booked Trips"),
        titleTextStyle: defaultHeading,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: bookedTrips.length == 0
              ? Container(
                  width: wRatio * 100,
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(top: hRatio * 30),
                  child: Text(
                    "You haven't booked any trips yet!",
                    style: hintTextStyleWithColor,
                  ))
              : ListView.builder(
                  itemCount: temp.length,
                  itemBuilder: ((context, index) {
                    return Visibility(
                      visible: checkBooked(bookedTrips, temp[index]),
                      child: Container(
                        padding: EdgeInsets.all(wRatio * 3),
                        margin: EdgeInsets.fromLTRB(
                            wRatio * 3, wRatio * 2, wRatio * 3, wRatio * 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset:
                                  Offset(-1, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    temp[index].imageUrl,
                                    width: wRatio * 35,
                                    height: wRatio * 35,
                                    fit: BoxFit.cover,
                                  )),
                              SizedBox(
                                height: wRatio * 35,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      temp[index].name,
                                      style: cardHeading,
                                    ),
                                    SizedBox(
                                      height: wRatio * 1,
                                    ),
                                    Text(
                                      temp[index].tagLine,
                                      style: cardHintTextStyle,
                                    ),
                                    SizedBox(
                                      height: wRatio * 3,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today_outlined,
                                          color:
                                              Color.fromRGBO(180, 180, 180, 1),
                                        ),
                                        SizedBox(
                                          width: wRatio * 1,
                                        ),
                                        Text(
                                          temp[index].startDate,
                                          style: defaultText,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: wRatio * 3,
                                    ),
                                    SizedBox(
                                      width: wRatio * 39,
                                      child: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: "Pris: ",
                                              style: defaultText),
                                          TextSpan(
                                              text: "NOK ${temp[index].price}",
                                              style:
                                                  cardHintTextStyleWithColor),
                                          TextSpan(
                                              text:
                                                  " / ${temp[index].days} Dager",
                                              style: cardHintTextStyle)
                                        ]),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: wRatio * 35,
                                alignment: Alignment.bottomCenter,
                                child: GestureDetector(
                                  onTap: () async {
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) => TripDetails(
                                                temp[index], bookedTrips))));
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(50),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.amber.withOpacity(0.3),
                                          spreadRadius: 3,
                                          blurRadius: 5,
                                          offset: Offset(0,
                                              0), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.arrow_forward_sharp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    );
                  }))),
    );
  }

  checkBooked(List bookedTrips, SingleTripInfo temp) {
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
