//Burası Auth işlemlerini yönetecek widget
import 'package:bitirme/core/model/user_model.dart';
import 'package:bitirme/core/service/i_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

//Bu widget firabaseden gelecek kullanıcının dinlemesini yapacak.Bunu service kısmında stream ile yapacak
//Bu kullanıcının online veya ofline durumuna göre yönlendirsin.Online ysa örnegin homepage e ofline ise signin page sayfasına yönlendirecek.Uygulama içinde gezinmemizi saglayacak.
class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({super.key, required this.onPageBuilder});
  final Widget Function(
      BuildContext context, AsyncSnapshot<UserModel?> snapshot) onPageBuilder;
  @override
  Widget build(BuildContext context) {
    final _authService = Provider.of<IAuthService>(context, listen: false);
    //Diger tüm sayfalardan IAuthService tipinden nesnenin instance bulursan bana getir.Context üzerinden dikey arama yaparak aranan datayı getirme işlemi
    return StreamBuilder<UserModel?>(
      stream: _authService.onAuthStateChanged,
      builder: (context, AsyncSnapshot<UserModel?> snapShot) {
        final _userData = snapShot.data;
        if (_userData != null) {
          return MultiProvider(providers: [
            Provider.value(
              value: _userData,
            ),
            //Bu _userdatayı context üzerinden erişmek istedigimde alabiliriz.
          ], child: onPageBuilder(context, snapShot));
          //Signin olduktan sonra uygulama içinde başka verilerin saglanması için MultiProvider ile sarıyoruz.
        }
        return onPageBuilder(context, snapShot);
      },
    );
  }
}
