import 'package:bitirme/core/service/i_auth_service.dart';
import 'package:bitirme/view/login_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//HomePage appBarda bu butonun eklenmesini sağladım çünkü direkt appBar da yapınca hata veriyor
class SignOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.exit_to_app),
      color: Colors.black,
      onPressed: () async {
        final authService = Provider.of<IAuthService>(context, listen: false);
        await FirebaseAuth.instance.signOut();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      },
    );
  }
}
