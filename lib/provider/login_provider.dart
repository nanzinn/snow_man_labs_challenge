import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:snowmanlabs_challenge/model/facebook_user_model.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:snowmanlabs_challenge/model/firebase_user_model.dart';

class LoginProvider {
  static Future<FacebookUserModel> getFacebookUser() async {
    final FacebookLogin facebookSign = new FacebookLogin();
    try {
      FacebookLoginResult result = await facebookSign.logIn(['email', 'public_profile']);
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          final token = result.accessToken.token;
          final graphResponse = await http.get(
              'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');

          return FacebookUserModel.fromJson(graphResponse.body);
          break;
        case FacebookLoginStatus.cancelledByUser:
          return FacebookUserModel((b) => b..error = "Você cancelou!");
          break;
        case FacebookLoginStatus.error:
          return FacebookUserModel((b) => b..error = result.errorMessage);
          break;
      }
    } on Exception catch (e) {}
    return null;
  }

  static Future<FirebaseUserModel> loginInFirebase({FacebookUserModel facebookUserModel}) async {
    try {
      FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: facebookUserModel.email, password: facebookUserModel.id);
      FirebaseUser firebaseUser = result.user;
      return FirebaseUserModel((b) => b
        ..email = firebaseUser.email
        ..displayName = firebaseUser.displayName
        ..uid = firebaseUser.uid);
    } on PlatformException catch (error) {
      return FirebaseUserModel(
              (b) => b..error = "Erro ao realizar o login");
    }
  }

  static Future<FirebaseUserModel> createFirebaseUser({FacebookUserModel facebookUserModel}) async {
    try {
      FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
      FirebaseUser savedFirebaseUser = (await _firebaseAuth.createUserWithEmailAndPassword(
        email: facebookUserModel.email,
        password: facebookUserModel.id,
      ))
          .user;

      return FirebaseUserModel((b) => b
        ..email = savedFirebaseUser.email
        ..displayName = savedFirebaseUser.displayName
        ..uid = savedFirebaseUser.uid);
    } on Exception catch (e) {
      return FirebaseUserModel(
          (b) => b..error = "Erro ao criar sua conta. Talvez essa conta ja exista?!");
    }
  }
}
