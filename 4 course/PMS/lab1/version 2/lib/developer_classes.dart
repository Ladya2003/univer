import 'dart:convert';
import 'dev_tools.dart'; // Импортируем интерфейс DevTools

// Mixin для добавления отладочных возможностей
mixin Debuggable {
  void debug() {
    print("Debugging the application");
  }
}

// Mixin для тестирования
mixin Tester {
  void test() {
    print("Running tests");
  }
}

// Базовый класс Developer с реализацией интерфейса Comparable
class Developer implements Comparable<Developer> {
  String name;
  int experienceYears;

  Developer(this.name, this.experienceYears);

  @override
  int compareTo(Developer other) {
    return experienceYears.compareTo(other.experienceYears);
  }

  // Пример сериализации в JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'experienceYears': experienceYears,
    };
  }

  factory Developer.fromJson(Map<String, dynamic> json) {
    return Developer(
      json['name'],
      json['experienceYears'],
    );
  }
}

class DevExperienceIterator implements Iterator<String> {
  final List<String> experienceList; // cant override (const)
  int _index = -1;

  DevExperienceIterator(this.experienceList);

  @override
  String get current => experienceList[_index];

  @override
  bool moveNext() {
    if (_index < experienceList.length - 1) {
      _index++;
      return true;
    }
    return false;
  }
}

class DevExperienceIterable extends Iterable<String> {
  final List<String> experienceList;

  DevExperienceIterable(this.experienceList);

  @override
  Iterator<String> get iterator => DevExperienceIterator(experienceList);
}

class FrontendDeveloper extends Developer with Debuggable, Tester implements DevTools {
  String framework;

  FrontendDeveloper({
    required String name,
    required int experienceYears,
    required this.framework,
  }) : super(name, experienceYears);

  @override
  void code() {
    print("$name is coding a frontend application using $framework.");
  }

  @override
  void useIDE() {
    print("$name is using Android Studio.");
  }

  @override
  void useVersionControl() {
    print("$name is using Git.");
  }

  void developUI({String tool = "Figma"}) {
    print("$name is designing UI using $tool.");
  }

  void performAction(Function() action) {
    print("Performing action...");
    action();
  }
}

class BackendDeveloper extends Developer {
  String language;

  BackendDeveloper({
    required String name,
    required int experienceYears,
    required this.language,
  }) : super(name, experienceYears);

  @override
  void code() {
    print("$name is coding backend logic using $language.");
  }

  void deployBackend([bool useDocker = true]) {
    if (useDocker) {
      print("$name is deploying using Docker.");
    } else {
      print("$name is deploying without Docker.");
    }
  }
}
