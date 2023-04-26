//Farklı Servisler eklenirse bu soyut sınıf projede kullanıcılak metotlar ile ilgili yol gösterecek
import 'package:bitirme/core/model/user_model.dart';
import 'package:bitirme/main.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthService {
  Future<UserModel> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });
  //Bu fonksiyonu kullanan sınıf email ve password alıp kullanıcı oluşturulması sağlanacak
  Future<UserModel> sigInEmailAndPassword(
      {required String email, required String password});
  //Giriş yapan kullanıcı usermodel verecek

  Stream<UserModel?> get onAuthStateChanged;
  //Kullanıcının uygulamada online olup olmadıgını denetleme
}
