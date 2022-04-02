import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meta/meta.dart';

part '../event/authentication_event.dart';
part '../state/authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is register) {
        emit(AuthenticationLoading());
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: event.email, password: event.pass);
          CollectionReference users =
              FirebaseFirestore.instance.collection("users");
          users.doc(event.email).set({'bookedtrips': []});
          emit(AuthenticationLoaded(200));
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            emit(AuthenticationLoaded(201));
          } else if (e.code == 'email-already-in-use') {
            emit(AuthenticationLoaded(202));
          } else if (e.code == 'invalid-email') {
            emit(AuthenticationLoaded(204));
          } else {
            emit(AuthenticationLoaded(203));
          }
        } catch (e) {
          emit(AuthenticationLoaded(203));
        }
      }

      if (event is checkUser) {
        emit(AuthenticationLoading());
        User user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          emit(AuthenticationLoaded(200));
        } else {
          emit(AuthenticationLoaded(201));
        }
      }

      if (event is login) {
        emit(AuthenticationLoading());
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: event.email, password: event.pass);
          emit(AuthenticationLoaded(200));
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            emit(AuthenticationLoaded(201));
          } else if (e.code == 'wrong-password') {
            emit(AuthenticationLoaded(202));
          } else if (e.code == 'invalid-email') {
            emit(AuthenticationLoaded(204));
          } else {
            emit(AuthenticationLoaded(203));
          }
        }
      }
    });
  }
}
