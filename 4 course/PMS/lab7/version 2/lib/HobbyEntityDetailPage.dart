import 'package:flutter/material.dart';
import 'model/Entities.dart';
import 'DatabaseHelper.dart';
import 'EditEntityPage.dart';

class HobbyEntityDetailPage extends StatelessWidget {
  final HobbyEntity entity;
  final Function() onUpdate; // Колбэк для обновления списка

  HobbyEntityDetailPage({required this.entity, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(entity.name),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditEntityPage(entity: entity),
                ),
              ).then((_) {
                onUpdate(); // Обновление списка после редактирования
                Navigator.pop(context);
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${entity.name}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Type: ${entity is Read ? 'Read' : 'Draw'}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Удаление сущности
                DatabaseHelper.instance.delete(entity.id!);
                onUpdate(); // Вызов колбэка для обновления списка
                Navigator.pop(context); // Вернуться к списку
              },
              child: Text('Delete Entity'),
            ),
          ],
        ),
      ),
    );
  }
}
