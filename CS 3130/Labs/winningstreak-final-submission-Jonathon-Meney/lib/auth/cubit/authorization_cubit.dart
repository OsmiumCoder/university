import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'authorization_state.dart';

class AuthorizationCubit extends Cubit<AuthorizationState> {
  String initials= "";
  AuthorizationCubit() : super(AuthorizationSignedOut()) {
    _subscribe();
  }

  Future<void> _subscribe() async {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) async {
      if (user == null) {
        print("signed out");
        emit(AuthorizationSignedOut());
        await signIn();
      }
      else {
        print("user is signed in");
      }
    });
  }

  Future<void> signIn() async {
    if(state is AuthorizationSignedOut) {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInAnonymously();
      if (initials.isEmpty) {
        initials = _genRandomString();
      }
      if (userCredential.user != null &&
          userCredential.user?.displayName == null) {
        await setInitials(initials);
      }
      else if (userCredential.user != null) {
        initials = userCredential.user?.displayName ?? initials;
      }
      print("user: ${userCredential.user}");
      emit(AuthorizationSignedIn(initials: initials));
    }
  }


  Future<void> setInitials(String initials) async {
    User? user = FirebaseAuth.instance.currentUser;
    this.initials = initials;
    if (user!= null) {
      await user.updateDisplayName(initials);

    }
  }

  String _genRandomString() {
    Random r = Random();
    return String.fromCharCode(r.nextInt(26)+65) + String.fromCharCode(r.nextInt(26)+65) + String.fromCharCode(r.nextInt(26)+65);
  }
}