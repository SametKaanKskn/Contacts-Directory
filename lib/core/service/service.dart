import 'package:bitirme/core/model/user_model.dart';
import 'package:bitirme/core/service/i_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bitirme/core/model/user_model.dart';
import 'package:bitirme/core/service/i_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService implements IAuthService {
  final FirebaseAuth _authInstance = FirebaseAuth.instance;

  static UserModel? currentUser;
  //Buradan firebase e baglanarak kullanıcılarımızı oluşturacagız.
  UserModel _getUser(User? user) {
    return UserModel(userId: user!.uid, userMail: user.email!);
  }

  @override
  Future<UserModel> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    var _tempUser = await _authInstance.createUserWithEmailAndPassword(
        email: email, password: password);
    return convertUser(_tempUser);
    //parametre olarak dışarıdan gelen mail ve şifre verildi
  }

  @override
  Stream<UserModel?> get onAuthStateChanged =>
      _authInstance.authStateChanges().map(_getUser);
//Uygulama içerisinde aktif kullanıcı varsa bilgisini verecek metot
  @override
  Future<UserModel> sigInEmailAndPassword(
      {required String email, required String password}) async {
    var _tempUser = await _authInstance.signInWithEmailAndPassword(
        email: email, password: password);
    return convertUser(_tempUser);
  }

  Future<void> signOut() async {
    await _authInstance.signOut();
  }

  UserModel convertUser(UserCredential user) {
    currentUser =
        UserModel(userId: user.user!.uid, userMail: user.user!.email!);
    return currentUser!;
  }
}
