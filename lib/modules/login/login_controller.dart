import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:payflow/shared/models/user_model.dart';

class LoginController {
  final authController = AuthController();
  GoogleSignIn _google = GoogleSignIn(
    scopes: [
      "email",
    ],
  );
  Future<void> googleSignIn(BuildContext context) async {
    try {
      final response = await _google.signIn();
      final user = UserModel(
        name: response!.displayName!,
        photoURL: response.photoUrl,
      );
      authController.setUser(context, user);
      print(response);
    } catch (e) {
      print(e);
    }
  }

  Future<void> googleLogOut(BuildContext context) async {
    try {
      await _google.signOut();
      authController.logOut();
      Navigator.pushReplacementNamed(context, "/login");
    } catch (e) {
      print(e);
    }
  }
}
