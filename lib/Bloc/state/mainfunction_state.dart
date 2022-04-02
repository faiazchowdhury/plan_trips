part of '../bloc/mainfunction_bloc.dart';

@immutable
abstract class MainfunctionState {}

class MainfunctionInitial extends MainfunctionState {}

class MainfunctionLoading extends MainfunctionState {}

class MainfunctionLoaded extends MainfunctionState {
  final TripInfo tripInfo;
  MainfunctionLoaded(this.tripInfo);
}

class MainfunctionLoadedWithoutResponse extends MainfunctionState {
  final int statusCode;
  MainfunctionLoadedWithoutResponse(this.statusCode);
}
