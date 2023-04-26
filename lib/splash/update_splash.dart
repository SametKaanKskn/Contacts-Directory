import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

//Kişi güncelle tuşuna bastıktan sonra splash ekranı olarak burası dönecek
class UpdateSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/updating.json',
              width: 300,
              height: 300,
              onLoaded: (composition) {
                Future.delayed(composition.duration, () {
                  Navigator.popAndPushNamed(context, '/home');
                });
              },
            ),
            Text(
              "Kişi Güncelleniyor...",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
