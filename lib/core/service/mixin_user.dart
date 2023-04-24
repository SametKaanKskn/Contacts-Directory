import 'package:bitirme/core/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

mixin ConvertUser {
  UserModel convertUser(UserCredential user) {
    return UserModel(userId: user.user!.uid, userMail: user.user!.email!);
  }
}
