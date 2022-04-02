import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plan_trips/Model/TripInfo.dart';

part '../event/mainfunction_event.dart';
part '../state/mainfunction_state.dart';

class MainfunctionBloc extends Bloc<MainfunctionEvent, MainfunctionState> {
  MainfunctionBloc() : super(MainfunctionInitial()) {
    on<MainfunctionEvent>((event, emit) async {
      if (event is getHomePageTripInfo) {
        emit(MainfunctionLoading());
        CollectionReference users =
            FirebaseFirestore.instance.collection('trips');
        var res = await users.get();
        TripInfo tripInfo = TripInfo.fromJson(res.docs);
        User user = FirebaseAuth.instance.currentUser;
        users = FirebaseFirestore.instance.collection('users');
        var ress = await users.doc(user.email).get();
        tripInfo.bookedList(ress.get("bookedtrips"));
        emit(MainfunctionLoaded(tripInfo));
      }

      if (event is removeTrip) {
        emit(MainfunctionLoading());
        event.bookedTrips.remove(event.id);
        User user = FirebaseAuth.instance.currentUser;
        CollectionReference users =
            FirebaseFirestore.instance.collection('users');
        try {
          await users
              .doc(user.email)
              .update({'bookedtrips': event.bookedTrips});
          emit(MainfunctionLoadedWithoutResponse(201));
        } catch (e) {
          event.bookedTrips.add(event.id);
          emit(MainfunctionLoadedWithoutResponse(400));
        }
      }

      if (event is addTrip) {
        emit(MainfunctionLoading());
        event.bookedTrips.add(event.id);
        User user = FirebaseAuth.instance.currentUser;
        CollectionReference users =
            FirebaseFirestore.instance.collection('users');
        try {
          await users
              .doc(user.email)
              .update({'bookedtrips': event.bookedTrips});
          emit(MainfunctionLoadedWithoutResponse(200));
        } catch (e) {
          event.bookedTrips.remove(event.id);
          emit(MainfunctionLoadedWithoutResponse(400));
        }
      }
    });
  }
}
