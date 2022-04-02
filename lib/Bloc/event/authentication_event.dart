part of '../bloc/authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class register extends AuthenticationEvent {
  final String email, pass;
  register(this.email, this.pass);
}

class checkUser extends AuthenticationEvent {}

class login extends AuthenticationEvent {
  final String email, pass;

  login(this.email, this.pass);
}
