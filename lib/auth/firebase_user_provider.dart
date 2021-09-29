import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class OwnDesignFirebaseUser {
  OwnDesignFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

OwnDesignFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<OwnDesignFirebaseUser> ownDesignFirebaseUserStream() => FirebaseAuth
    .instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<OwnDesignFirebaseUser>(
        (user) => currentUser = OwnDesignFirebaseUser(user));
