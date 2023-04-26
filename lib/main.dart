import 'package:bitirme/core/model/user_model.dart';
import 'package:bitirme/core/service/i_auth_service.dart';
import 'package:bitirme/core/service/service.dart';
import 'package:bitirme/core/widgets/auth_widget.dart';
import 'package:bitirme/core/widgets/auth_widget_builder.dart';
import 'package:bitirme/firebase_options.dart';
import 'package:bitirme/providers/home_provider.dart';
import 'package:bitirme/splash/update_splash.dart';
import 'package:bitirme/view/home_page.dart';
import 'package:bitirme/view/person_details_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<IAuthService>(
          create: (_) => AuthService(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
      ],
      child: AuthWidgetBuilder(
        onPageBuilder: (context, AsyncSnapshot<UserModel?> snapShot) =>
            MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: AuthWidget(
            snapshot: snapShot,
          ),
          routes: {
            '/home': (context) => HomePage(),
            '/updateSplash': (context) => UpdateSplash(),
          },
        ),
      ),
    );
  }
}
