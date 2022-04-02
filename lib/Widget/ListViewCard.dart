import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plan_trips/Model/TripInfo.dart';
import 'package:plan_trips/Screens/TripDetails.dart';

import '../Constants/SizeConfig.dart';
import '../Constants/Style.dart';

class ListViewCard extends StatelessWidget {
  double hRatio = SizeConfig.heightRatio;
  double wRatio = SizeConfig.widthRatio;
  final int index;
  final TripInfo tripInfo;
  final bool domestic;
  ListViewCard(this.tripInfo, this.index, this.domestic);
  @override
  Widget build(BuildContext context) {
    var temp = tripInfo.info[index];
    return Visibility(
      visible: domestic == temp.domestic,
      child: Stack(
        children: [
          Container(
            width: wRatio * 65,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(-1, 1), // changes position of shadow
                ),
              ],
            ),
            margin: EdgeInsets.fromLTRB(
                wRatio * 2, wRatio * 2, wRatio * 2, wRatio * 3),
            padding: EdgeInsets.all(wRatio * 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    temp.imageUrl,
                    height: wRatio * 42,
                    width: wRatio * 65,
                    fit: BoxFit.cover,
                    errorBuilder: (context, object, stackTrace) {
                      return Image.asset(
                        "assets/Error Images.png",
                        height: wRatio * 42,
                        width: wRatio * 65,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: hRatio * 2,
                ),
                Padding(
                  padding: EdgeInsets.only(left: wRatio * 1),
                  child: Text(
                    temp.name,
                    style: cardHeading,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: wRatio * 1),
                    child: Text(
                      temp.tagLine,
                      style: hintTextStyle,
                    )),
                SizedBox(
                  height: hRatio * 2,
                ),
                Padding(
                    padding:
                        EdgeInsets.only(left: wRatio * 1, right: wRatio * 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              color: Color.fromRGBO(180, 180, 180, 1),
                            ),
                            SizedBox(
                              width: wRatio * 1,
                            ),
                            Text(
                              temp.startDate,
                              style: defaultText,
                            ),
                          ],
                        ),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "NOK ${temp.price}",
                                style: cardHintTextStyleWithColor),
                            TextSpan(
                                text: "/ ${temp.days} Dager",
                                style: cardHintTextStyle)
                          ]),
                        )
                      ],
                    ))
              ],
            ),
          ),
          Positioned(
            right: wRatio * 8,
            top: hRatio * 20,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>
                            TripDetails(temp, tripInfo.list))));
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
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: Icon(
                  Icons.arrow_forward_sharp,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
