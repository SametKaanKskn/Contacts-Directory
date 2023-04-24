// pages/home_page.dart

import 'package:bitirme/core/model/item_model.dart';
import 'package:bitirme/core/widgets/sign_out.dart';
import 'package:bitirme/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rehber Listesi'),
        backgroundColor: Colors.amber,
        actionsIconTheme: IconThemeData(),
        actions: [
          SignOutButton(),
        ],
      ),
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          if (homeProvider.items.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: homeProvider.items.length,
              itemBuilder: (context, index) {
                Item item = homeProvider.items[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(item.description),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddItemDialog(context),
        tooltip: 'Kişi Ekle',
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddItemDialog(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String itemName = '';
    String itemDescription = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Kişi Ekle'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Kişi Adı'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen Kişi Adı Giriniz';
                    }
                    return null;
                  },
                  onSaved: (value) => itemName = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Telefon Numarası'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen Telefon Numarası giriniz';
                    }
                    return null;
                  },
                  onSaved: (value) => itemDescription = value!,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Kapat'),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  Provider.of<HomeProvider>(context, listen: false).addItem(
                    Item(id: '', name: itemName, description: itemDescription),
                  );
                  Navigator.of(context).pop();
                }
              },
              child: Text('Ekle'),
            ),
          ],
        );
      },
    );
  }
}
