part of '../bloc/mainfunction_bloc.dart';

@immutable
abstract class MainfunctionEvent {}

class getHomePageTripInfo extends MainfunctionEvent {}

class removeTrip extends MainfunctionEvent {
  final List bookedTrips;
  final String id;
  removeTrip(this.bookedTrips, this.id);
}

class addTrip extends MainfunctionEvent {
  final List bookedTrips;
  final String id;
  addTrip(this.bookedTrips, this.id);
}
