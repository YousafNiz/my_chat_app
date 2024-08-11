import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/snackbar_service.dart';

enum AuthStatus {
  NotAuthenticated,
  Authenticating,
  Authenticated,
  UserNotFound,
  Error,
}

class AuthProvider extends ChangeNotifier {
  User? user;
  late AuthStatus status = AuthStatus.NotAuthenticated;

  late FirebaseAuth _auth;

  static AuthProvider instance = AuthProvider();

  AuthProvider() {
    _auth = FirebaseAuth.instance;
  }

  void loginUserWithEmailAndPassword(String _email, String _password) async {
    status = AuthStatus.Authenticating;
    notifyListeners();
    try {
      UserCredential _result = await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      user = _result.user;
      status = AuthStatus.Authenticated;
      SnackBarService.instance.showSnackBarSuccess('Wellcome,${user!.email}');
    } catch (e) {
      status = AuthStatus.Error;
      SnackBarService.instance.showSnackBarError('Error Authenticating');
    }
    notifyListeners();
  }
}
