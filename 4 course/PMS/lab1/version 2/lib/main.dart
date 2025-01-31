import 'dart:convert';

import 'package:flutter/material.dart';
import 'developer_classes.dart'; // Импортируем классы разработчиков
import 'dev_tools.dart'; // Импортируем DevTools

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Создаем объекты разработчиков
    FrontendDeveloper frontendDev = FrontendDeveloper(
      name: 'Vlad',
      experienceYears: 1,
      framework: 'Next.JS',
    );

    BackendDeveloper backendDev = BackendDeveloper(
      name: 'Halwa',
      experienceYears: 3,
      language: 'Node JS',
    );

    // Использование методов
    frontendDev.code();
    frontendDev.useIDE();
    frontendDev.developUI();
    frontendDev.performAction(() {
      print("Custom action executed.");
    });

    backendDev.code();
    backendDev.deployBackend();

    // Вызов методов debug и test из миксинов
    frontendDev.debug(); // Debugging the application...
    frontendDev.test();  // Running tests...

    // Вызов метода compareTo
    print("Comparing Vlad and Halwa experience:");
    int comparisonResult = frontendDev.compareTo(backendDev);
    if (comparisonResult < 0) {
      print("${backendDev.name} has more experience than ${frontendDev.name}");
    } else if (comparisonResult > 0) {
      print("${frontendDev.name} has more experience than ${backendDev.name}");
    } else {
      print("${frontendDev.name} and ${backendDev.name} have the same experience.");
    }

    // Сериализация объектов в JSON
    String frontendJson = jsonEncode(frontendDev.toJson());
    String backendJson = jsonEncode(backendDev.toJson());
    print("Frontend Developer as JSON: $frontendJson");
    print("Backend Developer as JSON: $backendJson");

    // Десериализация из JSON
    Developer deserializedFrontend = Developer.fromJson(jsonDecode(frontendJson));
    Developer deserializedBackend = Developer.fromJson(jsonDecode(backendJson));
    print("Deserialized Frontend Developer: ${deserializedFrontend.name}, Experience: ${deserializedFrontend.experienceYears}");
    print("Deserialized Backend Developer: ${deserializedBackend.name}, Experience: ${deserializedBackend.experienceYears}");

    // Работа с Iterable и Iterator
    List<String> experienceList = ['Junior', 'Middle', 'Senior'];
    DevExperienceIterable iterable = DevExperienceIterable(experienceList);
    Iterator<String> iterator = iterable.iterator;

    print("Developer experience levels:");
    while (iterator.moveNext()) {
      print(iterator.current);  // Печатает уровни: Junior, Middle, Senior
    }

    // Пример асинхронного вызова
    fetchData().then((_) {
      print("Asynchronous fetch completed.");
    });

    // Работа с Future
    fetchDeveloperData().then((data) {
      print("Received data: $data");
    }).catchError((error) {
      print("Error occurred: $error");
    });

    // Работа с Stream
    generateNumbers().listen((event) {
      print("Number from single subscription stream: $event");
    });

    var broadcastStream = broadcastStreamExample();
    broadcastStream.listen((event) {
      print("Listener 1 from broadcast stream: $event");
    });
    broadcastStream.listen((event) {
      print("Listener 2 from broadcast stream: $event");
    });

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Developer App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
