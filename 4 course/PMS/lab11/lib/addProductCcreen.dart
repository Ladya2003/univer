
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'firebaseFirestore.dart';

class AddProductScreen extends StatefulWidget {
  final FirestoreService firestoreService;

  AddProductScreen({Key? key, FirestoreService? firestoreService})
      : firestoreService = firestoreService ?? FirestoreService(),
        super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _price = '';
  String _image = '';
  String _description = '';

  void _addProduct() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.firestoreService.createProduct({
        'name': _name,
        'price': double.tryParse(_price) ?? 0.0,
        'image': _image,
        'description': _description,
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить товар'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                key: Key('nameField'),
                decoration: InputDecoration(labelText: 'Название'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите название';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!.trim(),
              ),
              TextFormField(
                key: Key('priceField'),
                decoration: InputDecoration(labelText: 'Цена'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите цену';
                  }
                  return null;
                },
                onSaved: (value) => _price = value!.trim(),
              ),
              TextFormField(
                key: Key('imageField'),
                decoration: InputDecoration(labelText: 'Ссылка на изображение'),
                onSaved: (value) => _image = value!.trim(),
              ),
              TextFormField(
                key: Key('descriptionField'),
                decoration: InputDecoration(labelText: 'Описание'),
                maxLines: 3,
                onSaved: (value) => _description = value!.trim(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addProduct,
                child: Text('Добавить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}