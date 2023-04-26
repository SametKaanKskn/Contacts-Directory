import 'package:bitirme/core/model/item_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bitirme/providers/home_provider.dart';

class PersonDetail extends StatelessWidget {
  final Item person;
  PersonDetail({required this.person});

  @override
  Widget build(BuildContext context) {
    var name = TextEditingController();
    var phone = TextEditingController();

    name.text = person.name;
    phone.text = person.phone;

    void _navigateToHomePage(BuildContext context) {
      Navigator.popAndPushNamed(context, '/home');
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text(
            "Kişi Detay",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 40,
              right: 40,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Resimleri yatay eksende ortaladım
                  children: [
                    Image.asset('assets/female_person.png',
                        width: 100, height: 100),
                    SizedBox(width: 10), // İki resim arasında boşluk bıraktım
                    Image.asset('assets/male_person.png',
                        width: 100, height: 100),
                  ],
                ),
                SizedBox(height: 20),
                TextField(
                  controller: name,
                  decoration: InputDecoration(
                    labelText: "Kişi Adı",
                    labelStyle: TextStyle(color: Colors.deepPurple),
                    fillColor: Colors.deepPurple.shade50,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Kişi Adı",
                    prefixIcon: Icon(Icons.person, color: Colors.deepPurple),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: phone,
                  decoration: InputDecoration(
                    labelText: "Kişi Telefon",
                    labelStyle: TextStyle(color: Colors.deepPurple),
                    fillColor: Colors.deepPurple.shade50,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Kişi Telefon",
                    prefixIcon: Icon(Icons.phone, color: Colors.deepPurple),
                  ),
                ),
                SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<HomeProvider>(context, listen: false)
                        .updateItem(
                      person.id,
                      name.text,
                      phone.text,
                    );
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/updateSplash');
                  },
                  child:
                      Text("Güncelle", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
