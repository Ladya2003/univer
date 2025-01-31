import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'firebaseFirestore.dart';

class EditProductScreen extends StatefulWidget {
  final String productId;
  final FirestoreService firestoreService;

  EditProductScreen({
    required this.productId,
    FirestoreService? firestoreService,
  }) : firestoreService = firestoreService ?? FirestoreService();

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _price = '';
  String _image = '';
  String _description = '';

  bool _isLoading = true;

  void _updateProduct() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.firestoreService.updateProduct(widget.productId, {
        'name': _name,
        'price': double.tryParse(_price) ?? 0.0,
        'image': _image,
        'description': _description,
      });
      Navigator.pop(context);
    }
  }

  void _loadProductData() async {
    DocumentSnapshot doc = await widget.firestoreService.productsCollection.doc(widget.productId).get();

    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    setState(() {
      _name = data['name'];
      _price = data['price'].toString();
      _image = data['image'];
      _description = data['description'];
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadProductData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Редактировать товар'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text('Редактирование товара', style: TextStyle(fontSize: 24)),
              TextFormField(
                initialValue: _name,
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
                initialValue: _price,
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
                initialValue: _image,
                decoration: InputDecoration(labelText: 'Ссылка на изображение'),
                onSaved: (value) => _image = value!.trim(),
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Описание'),
                maxLines: 3,
                onSaved: (value) => _description = value!.trim(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateProduct,
                child: Text('Сохранить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
