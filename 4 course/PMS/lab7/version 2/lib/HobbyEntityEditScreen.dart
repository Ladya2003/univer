import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/Entities.dart';

class HobbyEntityEditScreen extends StatefulWidget {
  final HobbyEntity? hobbyEntity; // Если null — это новый элемент, если не null — это редактирование

  HobbyEntityEditScreen({this.hobbyEntity});

  @override
  _HobbyEntityEditScreenState createState() => _HobbyEntityEditScreenState();
}

class _HobbyEntityEditScreenState extends State<HobbyEntityEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.hobbyEntity?.name ?? '');
    _descriptionController = TextEditingController(text: widget.hobbyEntity?.description ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.hobbyEntity == null ? 'Add Hobby Entity' : 'Edit Hobby Entity'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Логика для сохранения нового элемента или обновления существующего
                  final newHobbyEntity = HobbyEntity(
                    id: widget.hobbyEntity?.id,
                    name: _nameController.text,
                    description: _descriptionController.text,
                    type: widget.hobbyEntity?.type ?? 'defaultType', // or another suitable default
                  );


                  if (widget.hobbyEntity == null) {
                    // Логика добавления нового элемента
                    // Например, DatabaseHelper.instance.create(newHobbyEntity);
                  } else {
                    // Логика обновления существующего элемента
                    // Например, DatabaseHelper.instance.update(newHobbyEntity);
                  }

                  Navigator.pop(context);
                }
              },
              child: Text(widget.hobbyEntity == null ? 'Add' : 'Save'),
            ),
          ],
        ),
      ),
    );
  }
}
