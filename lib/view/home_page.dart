// home_page.dart
import 'package:bitirme/core/widgets/sign_out.dart';
import 'package:bitirme/view/person_details.dart';
import 'package:bitirme/view/person_update_page.dart';
import 'package:bitirme/view/person_add_page.dart';
import 'package:bitirme/view/profil_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:bitirme/core/model/item_model.dart';
import 'package:bitirme/providers/home_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kişiler'),
        backgroundColor: Colors.deepPurple,
        actions: [
          SignOutButton(),
        ],
      ),
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          if (homeProvider.items.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Scrollbar(
              isAlwaysShown: true,
              thickness: 8.0,
              controller: ScrollController(),
              hoverThickness: 12.0,
              radius: Radius.circular(8.0),
              child: ListView.builder(
                itemCount: homeProvider.items.length,
                itemBuilder: (context, index) {
                  Item item = homeProvider.items[index];
                  return Dismissible(
                    key: Key(item.id),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      homeProvider.removeItem(item);
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.all(8),
                      elevation: 4,
                      child: ListTile(
                        leading: Lottie.asset('assets/user_card.json',
                            width: 30, height: 30),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PersonUpdate(person: item),
                            ),
                          );
                        },
                        title: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Kişi Adı: ',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              TextSpan(
                                text: '${item.name}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        subtitle: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Telefon: ',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              TextSpan(
                                text: '${item.phone}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PersonDetail(person: item),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.visibility,
                                color: Colors.black54,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${item.name} silinsin mi?',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                        Row(
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                homeProvider.removeItem(item);
                                                ScaffoldMessenger.of(context)
                                                    .hideCurrentSnackBar();
                                              },
                                              child: Text('EVET',
                                                  style: TextStyle(
                                                      color: Colors.red)),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                ScaffoldMessenger.of(context)
                                                    .hideCurrentSnackBar();
                                              },
                                              child: Text('HAYIR',
                                                  style: TextStyle(
                                                      color: Colors.green)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    duration: Duration(seconds: 5),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
      floatingActionButton: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton.extended(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PersonAdd()),
              ),
              backgroundColor: Colors.deepPurple,
              icon: Lottie.asset('assets/person_add_animation.json',
                  width: 40, height: 40),
              label: Text('Kişi Ekle'),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton.extended(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              ),
              backgroundColor: Colors.deepPurple,
              icon: Icon(Icons.account_circle, size: 35),
              label: Text('Profil'),
            ),
          ),
        ],
      ),
    );
  }
}
