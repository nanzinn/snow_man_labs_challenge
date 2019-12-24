import 'package:snowmanlabs_challenge/model/facebook_user_model.dart';
import 'package:snowmanlabs_challenge/provider/login_provider.dart';

class LoginRepository{
  static Future getFacebookUser() async {
    return await LoginProvider.getFacebookUser();
  }

  static Future loginInFirebase({FacebookUserModel facebookUserModel}) async {
    return await LoginProvider.loginInFirebase(facebookUserModel: facebookUserModel);
  }

  static Future createFirebaseUser({FacebookUserModel facebookUserModel}) async {
    return await LoginProvider.createFirebaseUser(facebookUserModel: facebookUserModel);
  }
}