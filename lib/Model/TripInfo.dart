import 'package:cloud_firestore/cloud_firestore.dart';

class TripInfo {
  List<SingleTripInfo> info;
  List<dynamic> list;
  TripInfo({this.info});

  factory TripInfo.fromJson(List<QueryDocumentSnapshot<Object>> list) =>
      TripInfo(
          info: list == null
              ? null
              : List<SingleTripInfo>.from(
                  list.map((e) => SingleTripInfo.fromJson(e))));

  bookedList(List<dynamic> list) {
    this.list = list;
  }
}

class SingleTripInfo {
  String name, tagLine, startDate, endDate, days, imageUrl, price, desc, id;
  bool domestic;
  List<daybyday> dayList;
  SingleTripInfo(
      {this.id,
      this.name,
      this.tagLine,
      this.startDate,
      this.endDate,
      this.days,
      this.imageUrl,
      this.price,
      this.desc,
      this.domestic,
      this.dayList});

  factory SingleTripInfo.fromJson(QueryDocumentSnapshot<Object> json) =>
      SingleTripInfo(
          id: json.get("id"),
          name: json.get("name"),
          tagLine: json.get("tagline"),
          startDate: json.get("startdate"),
          endDate: json.get("enddate"),
          days: json.get("days"),
          imageUrl: json.get("imageurl"),
          price: json.get("price"),
          domestic: json.get("domestic"),
          desc: json.get("desc"),
          dayList: List<daybyday>.from(
              json.get("daybyday").map((e) => daybyday.fromJson(e))));
}

class daybyday {
  String desc, time, imageurl;

  daybyday({this.desc, this.time, this.imageurl});

  factory daybyday.fromJson(Map<String, dynamic> json) => daybyday(
      desc: json["desc"], time: json["time"], imageurl: json["imageurl"]);
}
