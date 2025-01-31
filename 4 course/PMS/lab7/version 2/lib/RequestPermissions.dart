import 'package:permission_handler/permission_handler.dart';

Future<void> requestPermissions() async {
  if (await Permission.storage.request().isGranted) {
    // Разрешения даны, продолжаем
  } else {
    // Разрешения не получены, нужно обработать
    throw 'Storage permission not granted';
  }
}

