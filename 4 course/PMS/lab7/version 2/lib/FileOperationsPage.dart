import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'model/Entities.dart';
import 'FileStorage.dart';

class FileOperationsPage extends StatefulWidget {
  final List<HobbyEntity> entityList;

  FileOperationsPage({Key? key, required this.entityList}) : super(key: key);

  @override
  _FileOperationsPageState createState() => _FileOperationsPageState();
}

class _FileOperationsPageState extends State<FileOperationsPage> {
  final FileStorage fileStorage = FileStorage();
  String? fileContents;
  String selectedPath = 'Application Documents';
  final List<String> storagePaths = [
    'Temporary',
    'Application Support',
    'Application Library',
    'Application Documents',
    'Application Cache',
    'External Storage',
    'External Cache Directories',
    'External Storage Directories',
    'Downloads'
  ];

  Future<bool> _checkAndRequestPermission() async {
    if (selectedPath.contains('External')) {
      if (await Permission.storage.isGranted) {
        return true;
      } else {
        final result = await Permission.storage.request();
        return result.isGranted;
      }
    }
    return true; // Для внутренних директорий разрешение не требуется
  }

  String? _checkLibraryAccess() {
    if (selectedPath.contains('Application Library') && Platform.isAndroid) {
      return "You don't have this directory";
    }
    return null;
  }



  Future<void> _writeEntityList() async {
    if (await _checkAndRequestPermission()) {
      try {
        String? err = _checkLibraryAccess();
        if (err != null) throw new Exception(err);

        await fileStorage.writeEntityList(widget.entityList, 'entity_list', selectedPath);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data written successfully!')));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error writing data: $e')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Permission denied for external storage.')));
    }
  }

  Future<void> _readEntityList() async {
    if (await _checkAndRequestPermission()) {
      try {
        final contents = await fileStorage.readEntityList('entity_list', selectedPath);
        setState(() {
          fileContents = contents.map((entity) =>
          '\nID: ${entity.id}, Name: ${entity.name}, Type: ${entity.type}, Description: ${entity.description}'
          ).join(';\n ');
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error reading data: $e')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Permission denied for external storage.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('File Operations')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Hobby Entities:'),
            ...widget.entityList.map((entity) => Text(entity.name)).toList(),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedPath,
              onChanged: (String? newValue) {
                setState(() {
                  selectedPath = newValue!;
                });
              },
              items: storagePaths.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _writeEntityList,
              child: Text('Write Entity Data'),
            ),
            ElevatedButton(
              onPressed: _readEntityList,
              child: Text('Read Entity Data'),
            ),
            SizedBox(height: 20),
            if (fileContents != null)
              Text('File Contents: $fileContents'),
          ],
        ),
      ),
    );
  }
}
