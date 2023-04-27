import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:bitirme/core/model/item_model.dart';
import 'package:bitirme/providers/home_provider.dart';
import 'package:lottie/lottie.dart';

class PersonAdd extends StatefulWidget {
  const PersonAdd({Key? key}) : super(key: key);

  @override
  _PersonAddState createState() => _PersonAddState();
}

class _PersonAddState extends State<PersonAdd> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userTelController = TextEditingController();
  final TextEditingController details = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<HomeProvider>(context, listen: false).fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title:
              const Text("Kişi Kayıt", style: TextStyle(color: Colors.white)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Lottie.asset('assets/person_add_animation.json',
                    width: 200, height: 200),
                SizedBox(height: 20),
                TextField(
                  controller: _userNameController,
                  decoration: InputDecoration(
                    labelText: "Kişi Adı",
                    labelStyle: TextStyle(color: Colors.deepPurple),
                    fillColor: Colors.deepPurple.shade50,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _userTelController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Kişi Telefon",
                    labelStyle: TextStyle(color: Colors.deepPurple),
                    fillColor: Colors.deepPurple.shade50,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: details,
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: "Kişi Detayları",
                    labelStyle: TextStyle(color: Colors.deepPurple),
                    fillColor: Colors.deepPurple.shade50,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Kişi Detayları",
                    prefixIcon: Icon(Icons.notes, color: Colors.deepPurple),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final item = Item(
                        id: '',
                        name: _userNameController.text,
                        phone: _userTelController.text,
                        details: details.text);
                    await Provider.of<HomeProvider>(context, listen: false)
                        .addItem(item);

                    // Kullanıcı ekleme yaptıktaktan kişinin kaydedildigine dair bu splash dönecek
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Lottie.asset('assets/onay.json',
                                  width: 100, height: 100),
                              SizedBox(height: 10),
                              Text("Kişi kaydedildi!",
                                  style: TextStyle(fontSize: 18)),
                              SizedBox(width: 10),
                            ],
                          ),
                        );
                      },
                    );

                    //Burada onaylandıktan sonra bu ekranı kapatmak için 2 saniye bekletme
                    await Future.delayed(Duration(seconds: 2));
                    Navigator.pop(context);
                    Navigator.pop(context); // Bu sayfayı kapatacaktır
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 100, vertical: 16),
                  ),
                  child: const Text("Kaydet",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
