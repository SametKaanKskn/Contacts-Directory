//Kullanıcın auth bilgi ile hangi sayfaya yönlendirilecegini saglayan widget

import 'package:bitirme/core/model/user_model.dart';
import 'package:bitirme/core/widgets/error_page.dart';
import 'package:bitirme/view/home_page.dart';
import 'package:bitirme/view/login_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key, required this.snapshot});
  final AsyncSnapshot<UserModel?> snapshot;

  @override
  Widget build(BuildContext context) {
    final _firebaseAuth = FirebaseAuth.instance;

    if (snapshot.connectionState == ConnectionState.active) {
      if (_firebaseAuth.currentUser != null) {
        return HomePage();
      } else {
        return LoginPage();
      }
    }
    return ErrorPage();
  }
}


// pages/home_page.dart
