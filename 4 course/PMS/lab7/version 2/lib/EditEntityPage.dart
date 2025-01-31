import 'package:flutter/material.dart';
import 'model/Entities.dart';
import 'DatabaseHelper.dart';

class EditEntityPage extends StatelessWidget {
  final HobbyEntity? entity;

  const EditEntityPage({Key? key, this.entity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(
        text: entity != null ? entity!.name : '');
    final descriptionController = TextEditingController(
        text: entity != null ? entity!.description : '');

    // Добавляем контроллер для типа сущности (Read или Draw)
    String type = entity?.type ?? 'Read';

    return Scaffold(
      appBar: AppBar(title: Text(entity == null ? 'Add Entity' : 'Edit Entity')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            DropdownButton<String>(
              value: type,
              onChanged: (String? newType) {
                if (newType != null) {
                  type = newType;
                }
              },
              items: <String>['Read', 'Draw']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final newEntity = HobbyEntity(
                  name: nameController.text,
                  type: type,
                  description: descriptionController.text,
                );

                if (entity == null) {
                  await DatabaseHelper.instance.create(newEntity);
                } else {
                  await DatabaseHelper.instance.update(
                      entity!.copy(
                        name: newEntity.name,
                        type: newEntity.type,
                        description: newEntity.description,
                      ));
                }
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
