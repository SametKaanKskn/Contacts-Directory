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
      {required String email,
      required String password,
      required String name}) async {
    var _tempUser = await _authInstance.createUserWithEmailAndPassword(
        email: email, password: password);
    User? user = _tempUser.user;

    if (user != null) {
      await user.updateProfile(displayName: name);
      await user.reload();
      user = _authInstance.currentUser;
      return _getUser(user);
    } else {
      throw Exception("Kullanıcı oluşturulamadı");
    }
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
    return _getUser(_tempUser.user);
  }

  Future<void> signOut() async {
    await _authInstance.signOut();
  }
}
