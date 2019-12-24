import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:snowmanlabs_challenge/common_widgets/error_widget.dart';
import 'package:snowmanlabs_challenge/model/facebook_user_model.dart';
import 'package:snowmanlabs_challenge/model/firebase_user_model.dart';
import 'package:snowmanlabs_challenge/repository/login_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snowmanlabs_challenge/ui/map/map_page.dart';

LoginBLoC getLoginBLoC(BuildContext context) {
  return Provider.of<LoginBLoC>(context);
}

class LoginBLoC {
  final FacebookLogin facebookSign = new FacebookLogin();

  Future<FacebookUserModel> _getFacebookUser() async {
    return await LoginRepository.getFacebookUser();
  }

  Future<FirebaseUserModel> _signInFirebase({FacebookUserModel facebookUserModel}) async {
    return await LoginRepository.loginInFirebase(facebookUserModel: facebookUserModel);
  }

  Future<FirebaseUserModel> _createFirebaseUser({FacebookUserModel facebookUserModel}) async {
    return await LoginRepository.createFirebaseUser(facebookUserModel: facebookUserModel);
  }

  Future signIn(BuildContext context) async {
    FacebookUserModel facebookUserModel = await _getFacebookUser();

    if (facebookUserModel.error == null) {
      FirebaseUserModel user = await _signInFirebase(facebookUserModel: facebookUserModel);
      if (user.error != null) {
        showError(context: context, error: user.error);
        return;
      }
      MapPage.show(context);
      return;
    }
  }

  Future signUp(BuildContext context) async {
    FacebookUserModel facebookUserModel = await _getFacebookUser();

    if (facebookUserModel.error == null) {
      FirebaseUserModel user = await _createFirebaseUser(facebookUserModel: facebookUserModel);
      if (user.error != null) {
        showError(context: context, error: user.error);
        return;
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("firebaseUser", user.toJson());
      MapPage.show(context);
      return;
    }

    showError(context: context, error: facebookUserModel?.error);
  }

  void dispose() {}
}
