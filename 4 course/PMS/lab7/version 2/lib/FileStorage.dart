import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'model/Entities.dart';

class FileStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<String> _getTemporaryPath() async {
    final directory = await getTemporaryDirectory();
    return directory.path;
  }

  Future<String> _getApplicationSupportPath() async {
    final directory = await getApplicationSupportDirectory();
    return directory.path;
  }

  Future<String> _getExternalStoragePath() async {
    final directory = await getExternalStorageDirectory();
    return directory?.path ?? '';
  }

  Future<File> _localFile(String filename, String dir) async {
    String dirPath;
    try {
      switch (dir) {
        case 'Temporary':
          dirPath = (await getTemporaryDirectory()).path;
          break;
        case 'Application Support':
          dirPath = (await getApplicationSupportDirectory()).path;
          break;
        case 'Application Library':
          dirPath = (await getLibraryDirectory()).path;
          break;
        case 'Application Documents':
          dirPath = (await getApplicationDocumentsDirectory()).path;
          break;
        case 'Application Cache':
          dirPath = (await getTemporaryDirectory()).path;
          break;
        case 'External Storage':
          dirPath = (await getExternalStorageDirectory())!.path;
          break;
        case 'ExternalCache':
          final directories = await getExternalCacheDirectories();
          if (directories != null && directories.isNotEmpty) {
            dirPath = directories.first.path;
          } else {
            throw 'External cache directories not available';
          }
          break;
        case 'External Storage Directories':
          dirPath = (await getExternalStorageDirectory())!.path;
          break;
        case 'Downloads':
          dirPath = (await getDownloadsDirectory())!.path;
          break;
        default:
          throw Exception('Unknown directory: $dir');
      }

      final directory = Directory(dirPath);
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      return File('$dirPath/$filename.txt');
    } catch (e) {
      throw Exception('Unknown directory: $dir');
    }
  }

  Future<File> writeHobbyEntity(HobbyEntity entity, String filename, String dir) async {
    try {
      final file = await _localFile(filename, dir);
      return await file.writeAsString(entity.toJson().toString());
    } catch (e) {
      throw Exception('Error writing to file: $e');
    }
  }

  Future<String> readHobbyEntity(String filename, String dir) async {
    try {
      final file = await _localFile(filename, dir);
      return await file.readAsString();
    } catch (e) {
      return 'Error: $e';
    }
  }

  Future<File> writeEntityList(List<HobbyEntity> entityList, String filename, String dir) async {
    try {
      final file = await _localFile(filename, dir);
      return await file.writeAsString(jsonEncode(HobbyEntity.listToJson(entityList)));
    } catch (e) {
      throw Exception('Error writing to file: $e');
    }
  }

  Future<List<HobbyEntity>> readEntityList(String filename, String dir) async {
    try {
      final file = await _localFile(filename, dir);
      final contents = await file.readAsString();
      final jsonList = jsonDecode(contents) as List<dynamic>;
      return HobbyEntity.listFromJson(jsonList);
    } catch (e) {
      throw Exception('Error reading from file: $e');
    }
  }
}
